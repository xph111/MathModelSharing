# ☁️ MathModelSharing — 团队跨模型云端共享工作区

- **云端仓库主页**：https://github.com/xph111/MathModelSharing
- **云端共享文件夹直达**：https://github.com/xph111/MathModelSharing/tree/main/shared_files
- **极简索引清单（模型首选读取入口）**：https://github.com/xph111/MathModelSharing/blob/main/shared_files/MANIFEST.md
- **📜 传输与同步流水账（上传下载记录）**：https://github.com/xph111/MathModelSharing/blob/main/shared_files/SYNC_LOG.md
- **云端网页版 VS Code（免安装在线管理）**：https://github.dev/xph111/MathModelSharing

本仓库专为**数学建模团队跨 AI 模型（Antigravity / Devin / Codex / DeepSeek / ChatGPT）及跨设备协同**设计。

---

## ⚡ 核心规范：极简 Token 与按需读取协议（防止爆 Context 额度）

为了防止大模型过度加载无关文件、频繁通读大压缩包而迅速耗尽 Context 额度，团队制定了**两阶段外科手术式读取与写入规范**：

### 1. 🤖 模型阅读与下载规范
- **第一阶段（轻量索引）**：任何 Agent / 大模型介入时，**只允许先读取 [`shared_files/MANIFEST.md`](https://github.com/xph111/MathModelSharing/blob/main/shared_files/MANIFEST.md)**（该文件仅几十行，耗费 Token 极低）。
- **第二阶段（按需单点读取）**：通过清单中的【核心用途与内容摘要】确认需要的目标文件后，**仅单点读取该具体文件**；如无必要，严禁全量 dump 整个目录。
- **下载记录（可选）**：Agent 在读取或下载关键文件后，可在 [`shared_files/SYNC_LOG.md`](https://github.com/xph111/MathModelSharing/blob/main/shared_files/SYNC_LOG.md) 中登记一条 `[DOWNLOAD]` 记录，告知队友你正在处理该数据。

### 2. ✍️ 写入、分类与日志规范（每次上传必须分类归档并登记）
所有文件严禁直接散乱丢在根目录，必须按以下 5 类结构存放，且**上传后必须在 `MANIFEST.md` 登记摘要，并在 `SYNC_LOG.md` 记录流水账**：

| 文件夹目录 | 存放内容与分类要求 |
| :--- | :--- |
| **`shared_files/01_raw_data/`** | 赛题原始附件、数据压缩包（`.zip`/`.rar`/`.7z`，只读归档） |
| **`shared_files/02_processed_data/`** | 清洗、去噪、特征工程后的干净数据集（`.csv`/`.parquet`/`.npy`） |
| **`shared_files/03_code_scripts/`** | 各小问的核心求解代码、算法模型与数据处理脚本（`.py`/`.m`/`.ipynb`） |
| **`shared_files/04_results_figures/`** | 模型输出的对比图表、指标评估表（`.png`/`.pdf`/`.xlsx`） |
| **`shared_files/05_paper_docs/`** | 论文片段、LaTeX 源码、公式推导、最终排版文档（`.tex`/`.docx`/`.md`） |

> **双重登记契约**：
> 1. 在 [`MANIFEST.md`](https://github.com/xph111/MathModelSharing/blob/main/shared_files/MANIFEST.md) 登记用途（供其他模型了解内容）。
> 2. 在 [`SYNC_LOG.md`](https://github.com/xph111/MathModelSharing/blob/main/shared_files/SYNC_LOG.md) 登记操作时间与作者（上传与下载流水账，由本地脚本或 Agent 自动维护）。

---

## 🖐️ 手动在云端网页上传 / 下载方法

- **上传新文件/压缩包**：打开对应分类子文件夹（如 `01_raw_data`） $\rightarrow$ 点击右上角 **`Add file` $\rightarrow$ `Upload files`** 拖拽上传。
- **单个文件下载**：点击文件名 $\rightarrow$ 点击右侧 **`Download raw file`** 图标。
- **整库打包下载**：直接访问 https://github.com/xph111/MathModelSharing/archive/refs/heads/main.zip 。

---

## 🤖 给各家大模型 / Agent 的配置指令

将以下指令复制给 **Codex / DeepSeek / Devin / ChatGPT**：

> “你已接入团队云端共享库 `https://github.com/xph111/MathModelSharing.git`：
> 1. **阅读约束**：绝不要自动遍历通读整个仓库。需要了解云端文件时，**优先只读取 `shared_files/MANIFEST.md` 索引清单**，确认目标文件后再按需拉取具体文件，严格控制 Token 消耗。
> 2. **写入与日志约束**：生成重要代码、数据或成果时，必须将文件分类存放至 `shared_files/` 的对应子目录（`01_raw_data/` ~ `05_paper_docs/`），在 `shared_files/MANIFEST.md` 中说明其用途，并在 `shared_files/SYNC_LOG.md` 中追加一行操作流水账说明是你（模型名）上传或读取了该文件。”
