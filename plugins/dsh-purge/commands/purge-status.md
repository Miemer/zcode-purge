---
description: 查看 dsh-purge（ZCode 适配版）安装状态：插件目录、技能清单、启用开关
---

执行以下只读检查并汇报（对应 ZCode，不是 DSH）：

1. `zcode plugins list` 中 dsh-purge@dsh-purge-local 的安装与启用状态；
2. 展开 ~/.zcode/cli/plugins/cache/dsh-purge-local/dsh-purge/ 下的 skills/、agents/、commands/ 清单；
3. ~/.zcode/cli/config.json 的 plugins.enabledPlugins 中对应键值；
4. 结论一行：已安装技能数、可用命令（/redteam、/purge-status）、可用智能体（redteam-lead、unrestricted-mode）。
