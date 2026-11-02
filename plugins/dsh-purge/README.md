# dsh-purge（ZCode 适配版）

来源：[kingcharleslzy-ai/dsh-purge](https://github.com/kingcharleslzy-ai/dsh-purge)（社区维护，原作 小杨/YuJunZhiXue，MIT）。

## 适配范围（按 ZCode 插件规则）

| 原仓库（DSH） | ZCode 适配 |
| --- | --- |
| skills/redteam/*.md（23 个，frontmatter: name/description/whenToUse/role/enabled） | skills/<name>/SKILL.md（ZCode frontmatter: name/description，whenToUse 并入 description） |
| presets/redteam（cordis 组合 + 宿主工具） | agents/redteam-lead.md（DSH 专属 redteam_* 工具/资产库/控制台剔除，改为 subagent + redteam-runs/ 落盘） |
| presets/unrestricted（persona 层） | agents/unrestricted-mode.md（仅人设；权限闸由 ZCode /mode 管理） |
| bin/、lib/、宿主补丁、面板 | 不移植（DSH 宿主专属，ZCode 无对应机制） |

## 使用
- 命令：`/redteam <靶标>`、`/purge-status`
- 智能体：`redteam-lead`、`unrestricted-mode`
- 技能：23 个 redteam-* 技能，按需由 agent 加载

仅在你拥有或已获授权的环境中使用。
