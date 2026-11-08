# ☁️ 团队跨模型云端共享工作区 (Git + Git LFS)

本仓库作为团队与多 AI 模型（**Antigravity / Devin / ChatGPT / DeepSeek**）的**云端实时共享文件夹**。已预配置 **Git LFS 大文件支持**，可直接上传/下载 `.zip`、`.rar`、`.7z`、`.xlsx`、`.pdf`、`.docx` 等任意格式文件。

---

## 📁 目录说明

- **`shared_files/`**：**核心云端共享文件夹**。你和队友的所有压缩包、数据集、代码、图表、文档统一放在此目录下（可自由新建子文件夹）。
- **`scripts/`** 与根目录 **`.bat` 脚本**：供队友在本地电脑上零命令行一键上传、下载或开启后台实时自动同步。

---

## 🚀 方式一：直接在云端网页手动上传 / 下载（无需安装任何软件）

不管队友用什么电脑或平板，只要打开本仓库的 **GitHub / Gitee 网页链接**：

1. **云端网页直接上传文件/压缩包**：
   - 进入网页上的 `shared_files` 文件夹 $\rightarrow$ 点击右上角 **`Add file` $\rightarrow$ `Upload files`**。
   - 直接把 `.zip` 压缩包或文件拖进浏览器窗口 $\rightarrow$ 点击底部绿色按钮 **`Commit changes`** 即可完成上传！
2. **云端网页直接下载**：
   - **下载单个文件/压缩包**：点击文件名 $\rightarrow$ 点击右侧 **`Download raw file`** 图标（下载箭头）。
   - **下载整个云端文件夹**：在仓库首页点击绿色按钮 **`<> Code` $\rightarrow$ `Download ZIP`**，或者在仓库网页按下键盘上的 **`.`（英文句号键）** 进入 **`github.dev` 云端网页版 VS Code**，即可像操作本地电脑一样右键任意文件夹直接下载或拖拽上传！

---

## 🤖 方式二：各家 AI 模型 / Agent 直接绑定云端文件夹

1. **Devin（云端全自动 Agent）**：
   - 在 Devin 后台 **`Settings -> GitHub Integration`** 中直接授权绑定本仓库。
   - 对 Devin 下达指令时直接说：*“拉取 `shared_files` 下的最新文件进行处理，完成后 push 回 `main` 分支”*。
2. **Antigravity（本地全能 Agent）**：
   - 直接在 Antigravity 中打开本目录，对 Agent 说：*“从云端拉取队友刚传的文件”* 或 *“把做好的文件上传到云端”*，Agent 会自动调用 Git 完成下载与上传。
3. **ChatGPT（Plus / Team / 桌面版）**：
   - 在 ChatGPT 对话框点击 **`+` 号 $\rightarrow$ `Connect to GitHub`**，直接勾选本云端仓库，GPT 即可直接联网读取仓库内所有文件。
4. **DeepSeek / 其他网页大模型**：
   - 队友用网页手动下载或双击下方 `.bat` 同步到本地后，直接把 `shared_files` 里的文件拖入 DeepSeek 对话框；做完后放回 `shared_files` 即可。

---

## 💻 方式三：本地电脑一键上传 / 下载（免命令行 `.bat`）

如果队友把仓库克隆（Clone）到了自己电脑上，**完全不需要记任何 Git 命令**，直接双击根目录的 4 个脚本即可：

1. **`1_首次绑定云端仓库地址.bat`**：首次建立仓库时粘贴 GitHub / Gitee 链接完成绑定。
2. **`2_一键从云端下载最新文件_Pull.bat`**：双击即可把队友和云端 Agent 最新上传的文件下载到 `shared_files/`。
3. **`3_一键上传本地文件到云端_Push.bat`**：把文件丢进 `shared_files/` 后，双击即可自动打包上传到云端。
4. **`4_开启后台实时双向自动同步_AutoSync.bat`**：双击后最小化窗口，每 30 秒自动检测本地新文件上传、检测云端新文件下载，实现**全自动网盘级同步**！
