param(
    [ValidateSet("bind", "pull", "push", "watch", "status")]
    [string]$Action = "status",
    [string]$RemoteUrl = ""
)

$ErrorActionPreference = "Continue"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

$LogFilePath = Join-Path $RepoRoot "shared_files\SYNC_LOG.md"

function Write-SyncRecord {
    param(
        [string]$OpType,      # [UPLOAD] 或 [DOWNLOAD]
        [string]$FileSummary, # 涉及的文件名称
        [string]$Comment      # 备注
    )
    if (-not (Test-Path $LogFilePath)) {
        $header = @"
# 📜 团队文件传输与同步日志 (Sync Log)

| 时间 (年-月-日 时:分:秒) | 操作类型 | 操作者 / Agent | 涉及文件或目录 | 备注说明 |
| :--- | :--- | :--- | :--- | :--- |
"@
        Set-Content -Path $LogFilePath -Value $header -Encoding UTF8
    }

    $timeStr = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $operator = "$env:USERNAME ($env:COMPUTERNAME)"
    $entry = "| $timeStr | $OpType | $operator | $FileSummary | $Comment |"
    Add-Content -Path $LogFilePath -Value $entry -Encoding UTF8
}

function Ensure-Remote {
    $currentRemote = git remote get-url origin 2>$null
    if (-not $currentRemote) {
        Write-Host "`n[提示] 当前尚未绑定云端 Git 仓库地址。" -ForegroundColor Yellow
        if (-not $RemoteUrl) {
            $RemoteUrl = Read-Host "请粘贴云端仓库地址"
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
    Write-Host "`n>>> 正在从云端拉取最新文件..." -ForegroundColor Cyan

    $oldHead = git rev-parse HEAD 2>$null
    git pull --rebase --autostash origin main
    git lfs pull 2>$null
    $newHead = git rev-parse HEAD 2>$null

    if ($oldHead -and $newHead -and ($oldHead -ne $newHead)) {
        $pulledFiles = git diff --name-only $oldHead $newHead
        $filesStr = ($pulledFiles -join ", ")
        if (-not $filesStr) { $filesStr = "检测到云端更新" }
        Write-Host "[完成] 已成功从云端下载最新文件: $filesStr" -ForegroundColor Green

        # 记录下载日志并同步回云端凭据
        Write-SyncRecord -OpType "[DOWNLOAD] 下载" -FileSummary $filesStr -Comment "从云端同步到本地"
        git add $LogFilePath
        git commit -m "Log download receipt by $env:USERNAME" | Out-Null
        git push origin main | Out-Null
    } else {
        Write-Host "[完成] 本地已是最新版本，无新文件需下载。" -ForegroundColor Green
    }
}

function Invoke-CloudPush {
    if (-not (Ensure-Remote)) { return }
    Write-Host "`n>>> 正在检查本地新增或修改的文件..." -ForegroundColor Cyan

    $changedFiles = git status --porcelain
    if ($changedFiles) {
        $filesList = ($changedFiles -split "`r?`n" | ForEach-Object { $_.Substring(3) }) -join ", "
        # 记录上传日志
        Write-SyncRecord -OpType "[UPLOAD] 上传" -FileSummary $filesList -Comment "由本地推送到云端"

        git add -A
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $msg = "Upload from $env:USERNAME at $timestamp"
        git commit -m $msg
        Write-Host ">>> 已打包本地文件与同步日志，正在推送到云端..." -ForegroundColor Cyan
    } else {
        Write-Host ">>> 本地没有需要上传的新文件或改动。" -ForegroundColor Gray
    }

    git pull --rebase --autostash origin main
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[完成] 文件与同步日志已成功上传至云端仓库！" -ForegroundColor Green
    } else {
        Write-Host "[错误] 上传失败，请检查网络连接。" -ForegroundColor Red
    }
}

switch ($Action) {
    "bind" {
        Ensure-Remote | Out-Null
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
        Write-Host "  已启动【自动双向同步与日志守护进程】 (每 30 秒自动记录并同步)" -ForegroundColor Green
        Write-Host "  日志文件位于: $LogFilePath" -ForegroundColor Cyan
        Write-Host "==========================================================" -ForegroundColor Green
        while ($true) {
            $changed = git status --porcelain
            if ($changed) {
                Invoke-CloudPush
            } else {
                git fetch origin main 2>$null
                $localHash = git rev-parse HEAD 2>$null
                $remoteHash = git rev-parse origin/main 2>$null
                if ($remoteHash -and ($localHash -ne $remoteHash)) {
                    Invoke-CloudPull
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
