---
description: 拉起红队演练流程：预检技能与资源 → 派 redteam-lead 指挥 → 按角色派活
argument-hint: <已授权靶标：单位名/域名/CIDR>
---

对靶标「$ARGUMENTS」启动红队演练（仅限用户已声明授权的目标）：

1. 用 skill 工具加载 redteam-setup 与 recon-pipeline，做技能/资源预检（FOFA_KEY、扫描器、隧道、VPS），缺口一次性列清向用户要；
2. 派 redteam-lead 智能体接管指挥（计划→派活→分析→汇报），并发不超过 3；
3. 所有产物落到 redteam-runs/$ARGUMENTS/ 目录。
