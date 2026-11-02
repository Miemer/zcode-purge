<div align="center">

# zcode-purge

**dsh-purge 的 ZCode 客户端适配版** —— 红队技能库 · 红队指挥 / 无限制模式智能体 · 一键启动命令

23 个红队技能 · 2 个智能体 · 2 个斜杠命令 · ZCode 插件格式（`.zcode-plugin` + SKILL.md）

</div>

---

## 它是什么

本仓库把 [kingcharleslzy-ai/dsh-purge](https://github.com/kingcharleslzy-ai/dsh-purge)（社区维护，原作 [小杨 / YuJunZhiXue](https://github.com/YuJunZhiXue/dsh-purge)，MIT）中**与宿主无关的内容**适配为 **ZCode**（Z.ai 桌面 Agent 客户端，Claude Code 兼容插件体系）可直接安装使用的插件：

| 内容 | 数量 | ZCode 形态 |
| --- | --- | --- |
| 红队技能（信息收集 / 扫描 / 隧道 / WebShell / 内网横向…） | 23 | `skills/<name>/SKILL.md` |
| 红队指挥智能体 `redteam-lead` | 1 | `agents/redteam-lead.md` |
| 无限制模式人设 `unrestricted-mode` | 1 | `agents/unrestricted-mode.md` |
| 启动命令 `/redteam`、状态命令 `/purge-status` | 2 | `commands/*.md` |

> DSH 专属能力（宿主补丁、审批/沙箱改造、SQLite 资产库、侧边栏面板、bin/lib CLI）**不移植**——ZCode 没有对应机制。红队模式下的资产落盘改用工作区 `redteam-runs/` 目录。

## 安装

前置：已安装 ZCode（默认路径 `F:\ZCode\ZCode.exe`，自定义路径用环境变量/参数覆盖）。

### 方式一：脚本（推荐）

```bash
git clone https://github.com/<你的账号>/zcode-purge.git
cd zcode-purge

# Git Bash
bash scripts/install.sh

# 或 PowerShell
powershell -ExecutionPolicy Bypass -File scripts/install.ps1

# ZCode 装在别的位置
ZCODE_EXE="D:\Apps\ZCode\ZCode.exe" bash scripts/install.sh
# 或
powershell -ExecutionPolicy Bypass -File scripts/install.ps1 -ZCodeExe "D:\Apps\ZCode\ZCode.exe"
```

脚本会依次执行：`plugins validate` → `marketplace add`（本目录）→ `install` → `enable`。

### 方式二：手动（Git Bash）

```bash
export ELECTRON_RUN_AS_NODE=1
ZCODE="F:/ZCode/ZCode.exe"
CLI="F:/ZCode/resources/glm/zcode.cjs"

"$ZCODE" "$CLI" plugins marketplace add "$(pwd)"
"$ZCODE" "$CLI" plugins install dsh-purge@zcode-purge
"$ZCODE" "$CLI" plugins enable dsh-purge@zcode-purge
```

**重启 ZCode 后生效。**

### 卸载

```bash
bash scripts/uninstall.sh        # 或 uninstall.ps1
```

## 使用

| 入口 | 说明 |
| --- | --- |
| `/redteam <已授权靶标>` | 拉起红队演练：技能/资源预检 → `redteam-lead` 指挥 → 按角色派活（并发 ≤3），产物落 `redteam-runs/<靶标>/` |
| `/purge-status` | 查看插件安装状态、技能清单、启用开关 |
| `redteam-lead`（智能体） | 只计划/派活/分析/汇报，不动手；五类执行角色由它调度 |
| `unrestricted-mode`（智能体） | 减少交互摩擦的人设：少确认、少铺垫、失败换路；权限闸仍由 ZCode `/mode` 管理 |
| 23 个技能 | agent 按需加载：`fofa-recon`、`active-scan`、`nuclei-scan`、`fscan-intranet`、`frp-tunnel`、`suo5-tunnel`、`webshell-toolkit`、`credential-attack`、`lateral-movement` 等 |

技能内引用的工具（nmap / nuclei / fscan / frp / suo5 / 冰蝎 / 哥斯拉…）与 `FOFA_KEY` 等环境变量需按各技能文件自行准备；缺资源时 `redteam-lead` 会给降级方案。

## 目录结构

```
zcode-purge/
├── marketplace.json                 # ZCode 市场清单（本地/目录源）
├── .claude-plugin/marketplace.json  # 同内容镜像（兼容 Claude 系工具）
├── plugins/
│   └── dsh-purge/
│       ├── .zcode-plugin/plugin.json   # ZCode 插件清单
│       ├── .claude-plugin/plugin.json  # 镜像
│       ├── skills/                     # 23 × SKILL.md
│       ├── agents/                     # redteam-lead / unrestricted-mode
│       ├── commands/                   # redteam / purge-status
│       ├── README.md                   # 适配范围说明
│       └── LICENSE
├── scripts/                         # install / uninstall（sh + ps1）
├── LICENSE                          # MIT（沿用上游，保留原作者署名）
└── README.md
```

## 适配说明（DSH → ZCode 的取舍）

- **技能 frontmatter**：DSH 的 `whenToUse/role/enabled` 字段折叠进 ZCode 的 `description`（ZCode 只认 `name/description`）。
- **presets → agents**：`presets/redteam`（cordis 组合）改写为独立 agent；DSH 宿主工具（`redteam_*`、资产库、控制台）无对应物，改为原生 subagent + 文件落盘。
- **presets/unrestricted → agent**：只保留人设层；宿主补丁拆审批/沙箱的能力在 ZCode 下由 `/mode`（build/edit/plan/yolo/guarded）控制。
- **已知边界**：ZCode headless（`zcode -p`）模式下，第三方 MCP server（如 dbx）协议协商失败会导致启动崩溃——这是既有环境问题，与本插件无关；GUI 会话不受影响。

## 使用边界

仅在你**拥有或已获书面授权**的环境中使用红队能力；对未授权目标的扫描、爆破、利用由使用者自行承担全部责任。

## 版权

- 上游：[kingcharleslzy-ai/dsh-purge](https://github.com/kingcharleslzy-ai/dsh-purge)（社区版）· 原作 [YuJunZhiXue/dsh-purge](https://github.com/YuJunZhiXue/dsh-purge)
- 许可证：**MIT**（见 [LICENSE](LICENSE)）
- 本仓库仅做格式适配与打包，不改变上游内容语义；跟踪上游版本号（当前适配基线 **1.6.69**）。
