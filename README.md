# ☁️ MathModelSharing — 团队跨模型云端共享工作区

- **云端仓库主页**：https://github.com/xph111/MathModelSharing
- **云端共享文件夹直达链接**：https://github.com/xph111/MathModelSharing/tree/main/shared_files
- **云端网页版 VS Code（免安装在线管理）**：https://github.dev/xph111/MathModelSharing

本仓库将所有共享文件（压缩包 `.zip`、数据表 `.csv`/`.xlsx`、代码、文档、图表）直接存储在云端 [`shared_files/`](https://github.com/xph111/MathModelSharing/tree/main/shared_files) 目录下，确保**任何大模型 / Agent 均可直接联网读取真实文件**，你和队友也可随时在网页手动上传和下载。

---

## 🖐️ 一、你和队友如何手动在云端上传 / 下载文件？

无需安装任何软件，直接打开浏览器访问 **[shared_files 云端文件夹](https://github.com/xph111/MathModelSharing/tree/main/shared_files)**：

1. **手动上传文件或压缩包到云端**：
   - 打开 https://github.com/xph111/MathModelSharing/upload/main/shared_files （或在 `shared_files` 页面点击右上角 **`Add file` $\rightarrow$ `Upload files`**）。
   - 直接把 `.zip` 压缩包、数据集或代码拖入网页窗口。
   - 点击底部绿色按钮 **`Commit changes`**，文件即刻保存在云端！
2. **手动从云端下载文件**：
   - **下载单个文件/压缩包**：在 `shared_files` 中点开对应文件，点击右侧 **`Download raw file`**（下载图标）即可。
   - **打包下载全部云端文件**：直接访问或点击 https://github.com/xph111/MathModelSharing/archive/refs/heads/main.zip 即可一键下载整个云端库压缩包。
3. **在线文件夹视图（推荐）**：
   - 直接打开 **https://github.dev/xph111/MathModelSharing**（或在 GitHub 页面按键盘上的 `.` 键），浏览器会直接打开云端 VS Code，可直接在左侧文件树中右键下载、拖拽上传或在线查看/编辑文件。

---

## 🤖 二、各家大模型 / Agent 如何直接读取云端文件？

所有文件均以**真实文件（非 LFS 指针）**保存在云端，任何 Agent 都能直接读取：

1. **ChatGPT（Plus / Team / Pro / 桌面版）**：
   - **方式 A（原生绑定）**：在输入框点击 **`+` $\rightarrow$ `Connect to GitHub`**，授权选择 `xph111/MathModelSharing`，ChatGPT 即可直接读取 `shared_files/` 中的所有数据和代码。
   - **方式 B（联网直读）**：如果仓库设为 Public，直接把云端文件链接发给 GPT，或发送 `https://gitingest.com/xph111/MathModelSharing` 让其直接联网读取全库内容。
2. **Devin（云端 Agent）**：
   - 在 Devin 中绑定 `xph111/MathModelSharing` 仓库，直接发指令：*“读取 `shared_files/` 下的最新压缩包/数据并处理，完成后将结果 push 回 `shared_files/`”*。
3. **Antigravity（本地 Agent）**：
   - 直接在 Antigravity 中说：*“从 `https://github.com/xph111/MathModelSharing` 拉取最新文件并处理，做完后推送到云端”*，Agent 会自动执行 `git pull` 与 `git push`。
4. **DeepSeek / 其他模型**：
   - 若使用网页版 DeepSeek：队友点击上方[一键打包下载链接](https://github.com/xph111/MathModelSharing/archive/refs/heads/main.zip)或单文件下载后拖入对话框；或者直接把 `https://uithub.com/xph111/MathModelSharing` / `https://gitingest.com/xph111/MathModelSharing` 的汇总内容发给 DeepSeek。

---

## 💻 三、本地电脑一键同步脚本（可选）

如果把本仓库克隆到了电脑本地（[`d:/中大资料/20_AI/Antigravity/SharedCloudRepo`](file:///d:/中大资料/20_AI/Antigravity/SharedCloudRepo)），可直接双击根目录脚本与云端同步：
- **`2_一键从云端下载最新文件_Pull.bat`**：将云端 `shared_files/` 的最新文件同步到本地。
- **`3_一键上传本地文件到云端_Push.bat`**：将本地 `shared_files/` 的修改一键推送到云端。
- **`4_开启后台实时双向自动同步_AutoSync.bat`**：每 30 秒自动与云端双向同步。
