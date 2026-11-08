# ☁️ MathModelSharing — 团队跨模型云端共享工作区

- **云端仓库主页**：https://github.com/xph111/MathModelSharing
- **云端共享文件夹直达**：https://github.com/xph111/MathModelSharing/tree/main/shared_files
- **极简索引清单（模型首选读取入口）**：https://github.com/xph111/MathModelSharing/blob/main/shared_files/MANIFEST.md
- **云端网页版 VS Code（免安装在线管理）**：https://github.dev/xph111/MathModelSharing

本仓库专为**数学建模团队跨 AI 模型（Antigravity / Devin / Codex / DeepSeek / ChatGPT）及跨设备协同**设计。

---

## ⚡ 核心规范：极简 Token 与按需读取协议（防止爆 Context 额度）

为了防止大模型过度加载无关文件、频繁通读大压缩包而迅速耗尽 Context 额度，团队制定了**两阶段外科手术式读取与写入规范**：

### 1. 🤖 模型阅读规范（两阶段按需检索，严禁盲目全量通读）
- **第一阶段（轻量索引）**：任何 Agent / 大模型介入时，**只允许先读取 [`shared_files/MANIFEST.md`](https://github.com/xph111/MathModelSharing/blob/main/shared_files/MANIFEST.md)**（该文件仅几十行，耗费 Token 极低）。
- **第二阶段（按需切片加载）**：通过清单中的【核心用途与内容摘要】确认需要的目标文件后，**仅单点读取该具体文件**；如无必要，严禁全量 dump 整个目录。

### 2. ✍️ 写入与分类规范（每次上传必须分类归档并登记）
所有文件严禁直接散乱丢在根目录，必须按以下 5 类结构存放，且**上传后必须在 `shared_files/MANIFEST.md` 中登记 1 行摘要**：

| 文件夹目录 | 存放内容与分类要求 |
| :--- | :--- |
| **`shared_files/01_raw_data/`** | 赛题原始附件、数据压缩包（`.zip`/`.rar`/`.7z`，只读归档） |
| **`shared_files/02_processed_data/`** | 清洗、去噪、特征工程后的干净数据集（`.csv`/`.parquet`/`.npy`） |
| **`shared_files/03_code_scripts/`** | 各小问的核心求解代码、算法模型与数据处理脚本（`.py`/`.m`/`.ipynb`） |
| **`shared_files/04_results_figures/`** | 模型输出的对比图表、指标评估表（`.png`/`.pdf`/`.xlsx`） |
| **`shared_files/05_paper_docs/`** | 论文片段、LaTeX 源码、公式推导、最终排版文档（`.tex`/`.docx`/`.md`） |

> **登记格式**：在 [`shared_files/MANIFEST.md`](https://github.com/xph111/MathModelSharing/blob/main/shared_files/MANIFEST.md) 末尾追加：
> `| 路径 | 分类 | 作者/模型 | 大小 | 核心用途与摘要(30字内) | 依赖关系 |`

---

## 🖐️ 手动在云端网页上传 / 下载方法

- **上传新文件/压缩包**：打开对应分类子文件夹（如 `01_raw_data`） $\rightarrow$ 点击右上角 **`Add file` $\rightarrow$ `Upload files`** 拖拽上传。
- **单个文件下载**：点击文件名 $\rightarrow$ 点击右侧 **`Download raw file`** 图标。
- **整库打包下载**：直接访问 https://github.com/xph111/MathModelSharing/archive/refs/heads/main.zip 。

---

## 🤖 给各家大模型 / Agent 的配置指令

将以下指令复制给 **Codex / DeepSeek / Devin / ChatGPT**：

> “你已接入团队云端共享库 `https://github.com/xph111/MathModelSharing.git`：
> 1. **阅读约束**：绝不要自动遍历通读整个仓库。当需要了解共享文件时，**优先只读取 `shared_files/MANIFEST.md` 清单**，确认目标文件后再按需拉取具体文件，严格控制 Token 消耗。
> 2. **写入约束**：生成重要代码、数据或成果时，必须将文件分类存放至 `shared_files/` 的对应子目录（`01_raw_data/` ~ `05_paper_docs/`），并在 `shared_files/MANIFEST.md` 中追加一行说明该文件的核心用途与摘要。”

## Codex 按需调用

在仓库的 GitHub **Issues** 中新建或打开一个任务 Issue，然后发表评论：

```text
/codex 请按需读取 shared_files/MANIFEST.md 中对应的文件，并总结主要结论。
```

工作流只响应有仓库写入权限的成员在普通 Issue 中发出的 `/codex ` 指令。Codex 会先读取 `shared_files/MANIFEST.md`，再按任务读取相关文件；默认只读分析，并将结果回复在同一 Issue。上传文件本身不会触发模型调用，也不会自动改写或提交文件。

首次启用前，请在 GitHub 仓库 **Settings → Secrets and variables → Actions** 中添加名为 `OPENAI_API_KEY` 的 Repository secret。该工作流通过 OpenAI API 调用 Codex；API 用量与 ChatGPT 订阅分别计费。
