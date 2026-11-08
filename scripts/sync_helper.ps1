param(
    [ValidateSet("bind", "pull", "push", "watch", "status")]
    [string]$Action = "status",
    [string]$RemoteUrl = ""
)

$ErrorActionPreference = "Continue"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

function Ensure-Remote {
    $currentRemote = git remote get-url origin 2>$null
    if (-not $currentRemote) {
        Write-Host "`n[提示] 当前尚未绑定云端 Git 仓库地址 (GitHub / Gitee)。" -ForegroundColor Yellow
        if (-not $RemoteUrl) {
            $RemoteUrl = Read-Host "请粘贴云端仓库地址 (例如 https://github.com/你的用户名/仓库名.git)"
        }
        $RemoteUrl = $RemoteUrl.Trim()
        if ($RemoteUrl) {
            git remote add origin $RemoteUrl
            Write-Host "[成功] 已绑定云端仓库: $RemoteUrl" -ForegroundColor Green
            return $true
        } else {
            Write-Host "[取消] 未输入有效地址。" -ForegroundColor Red
            return $false
        }
    }
    return $true
}

function Invoke-CloudPull {
    if (-not (Ensure-Remote)) { return }
    Write-Host "`n>>> 正在从云端同步最新文件到本地..." -ForegroundColor Cyan
    git fetch origin main 2>&1
    $branchExists = git ls-remote --heads origin main 2>$null
    if ($branchExists) {
        git pull --rebase --autostash origin main
        git lfs pull
        Write-Host "[完成] 云端最新文件已下载到: $RepoRoot\shared_files" -ForegroundColor Green
    } else {
        Write-Host "[提示] 云端仓库当前为空，等待首次上传 (Push)。" -ForegroundColor Yellow
    }
}

function Invoke-CloudPush {
    if (-not (Ensure-Remote)) { return }
    Write-Host "`n>>> 正在检查本地新增或修改的文件..." -ForegroundColor Cyan
    git add -A
    $status = git status --porcelain
    if ($status) {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $msg = "Sync from $env:COMPUTERNAME ($env:USERNAME) at $timestamp"
        git commit -m $msg
        Write-Host ">>> 已打包本地改动，正在与云端合并并上传..." -ForegroundColor Cyan
    } else {
        Write-Host ">>> 本地无新增改动，正在检查是否有未推送提交..." -ForegroundColor Gray
    }

    $branchExists = git ls-remote --heads origin main 2>$null
    if ($branchExists) {
        git pull --rebase --autostash origin main
    }
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[完成] 文件已成功上传至云端仓库！队友和云端 Agent 现在可以直接读取。" -ForegroundColor Green
    } else {
        Write-Host "[错误] 上传失败，请检查网络连接或仓库权限。" -ForegroundColor Red
    }
}

switch ($Action) {
    "bind" {
        $currentRemote = git remote get-url origin 2>$null
        if ($currentRemote) {
            Write-Host "当前已绑定云端地址: $currentRemote" -ForegroundColor Cyan
            $newUrl = Read-Host "如需更换请粘贴新地址 (直接回车保持不变)"
            if ($newUrl.Trim()) {
                git remote set-url origin $newUrl.Trim()
                Write-Host "[成功] 已更新云端地址为: $($newUrl.Trim())" -ForegroundColor Green
            }
        } else {
            Ensure-Remote | Out-Null
        }
        Invoke-CloudPush
    }
    "pull" {
        Invoke-CloudPull
    }
    "push" {
        Invoke-CloudPush
    }
    "watch" {
        if (-not (Ensure-Remote)) { return }
        Write-Host "==========================================================" -ForegroundColor Green
        Write-Host "  已启动【云端共享文件夹实时双向同步守护进程】 (每 30 秒同步)" -ForegroundColor Green
        Write-Host "  本地共享目录: $RepoRoot\shared_files" -ForegroundColor Cyan
        Write-Host "  按 Ctrl + C 可随时停止自动同步" -ForegroundColor Yellow
        Write-Host "==========================================================" -ForegroundColor Green
        while ($true) {
            git add -A
            $localChanges = git status --porcelain
            if ($localChanges) {
                $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                git commit -m "AutoSync from $env:COMPUTERNAME at $timestamp" | Out-Null
                Write-Host "[$timestamp] 检测到本地新文件/修改，正在自动上传到云端..." -ForegroundColor Cyan
                git pull --rebase --autostash origin main | Out-Null
                git push -u origin main | Out-Null
                Write-Host "[$timestamp] 自动上传完成！" -ForegroundColor Green
            } else {
                git fetch origin main 2>$null
                $localHash = git rev-parse HEAD 2>$null
                $remoteHash = git rev-parse origin/main 2>$null
                if ($remoteHash -and ($localHash -ne $remoteHash)) {
                    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                    Write-Host "[$timestamp] 检测到队友/云端 Agent 上传了新文件，正在自动下载..." -ForegroundColor Cyan
                    git pull --rebase --autostash origin main | Out-Null
                    git lfs pull | Out-Null
                    Write-Host "[$timestamp] 云端新文件已同步到本地！" -ForegroundColor Green
                }
            }
            Start-Sleep -Seconds 30
        }
    }
    "status" {
        git status
        $r = git remote get-url origin 2>$null
        Write-Host "Remote Origin: $(if ($r) { $r } else { '<未绑定>' })" -ForegroundColor Cyan
    }
}
