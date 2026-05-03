# mattpocock/skills 转换示例集

> 将 `mattpocock/skills`（MIT License）中的精选技能转换为 SKILL.make 格式

## 来源说明

[mattpocock/skills](https://github.com/mattpocock/skills) 是 Matt Pocock（TypeScript 讲师）的 Claude Code 工作流技能库，MIT 许可证。本目录将其中的精选技能转换为 SKILL.make 格式，证明 SKILL.make 规范可完整保留原技能的逻辑与功能。

## 包含技能

| 技能 | 原作者 | 来源 | 说明 |
|:---|:---|:---|:---|
| `grill-me` | Matt Pocock | `productivity/` | 需求审问工作流，逐层追问达成共识 |
| `caveman` | Matt Pocock | `productivity/` | 极简压缩沟通，Token 节省 ~75% |
| `write-a-skill` | Matt Pocock | `productivity/` | 从零构建 Skill 的完整流程 |

## 转换原则

- 保留原技能的描述与工作流逻辑
- 用 Makefile DAG 建模依赖关系
- Shell 命令用 `@`，推理步骤用 `?`
- 变量用 `VAR ?= value`，调用时可覆盖

## 使用方式

```bash
# 在 OpenClaw / Claude Code 中触发
make grill        # 启动审问流程
make caveman     # 激活极简模式
make skill SKILL_NAME=my-skill  # 创建新技能
```

## 许可证

各技能均保持其原始许可证（MIT）。SKILL.make 格式转换本身无额外版权要求。
