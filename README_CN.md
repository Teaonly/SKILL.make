# SKILL.make：Makefile 风格的 Skill 文件规范

Makefile 风格的 Agent Skill 声明式规范与参考实现。

[English](./README.md) | 中文

---

## 是什么？

SKILL.make 将 Makefile 的**声明式依赖图**思想引入 Agent Skills 格式。用结构化逻辑替代模糊的自然语言描述，把 SKILL.md 变成一份**可复用的执行图谱**。

简单说：以前写 Skill 用一大段文字描述流程，LLM 自己猜下一步做什么；现在用 Makefile 语法明确定义"谁依赖谁"，系统自动按依赖顺序执行，不会跳步、不会乱序。

---

## 核心优势

**① Token 节省 15%（实测数据）**

将 `mattpocock/skills` 仓库中的 20 个 Skill 全部转为 SKILL.make 格式后，文件总体积从 66,394 压缩到 56,387，减少 **15%**。部分场景最高压缩 52%（migrate-to-shoehorn）。

**② DAG 依赖自动解析，执行顺序不再靠 LLM 猜**

```makefile
review: lint test summary
```

`review` 依赖 `lint`、`test`、`summary`，系统按 DAG 拓扑顺序自动执行，确保每个步骤在前置依赖完成后才运行。

**③ 高度可组合**

可以在不同 Skill 文件之间相互调用 target，像专业构建系统一样复用逻辑，不需要在每个 Skill 里重复写相同步骤。

**④ 可审计、可演进**

Makefile 语法天然适合 Git 版本追踪、调用统计，为"演进工程"（Evolution Engineering）打下基础。

---

## 语法规则

| 前缀 | 类型 | 说明 |
|:---|:---|:---|
| `VAR = val` | 变量 | 定义常量，减少重复 |
| `@ cmd` | Shell 命令 | 直接在终端执行命令 |
| `$ tool` | 工具调用 | 显式调用 Agent 已定义的工具或函数 |
| `? prompt` | 推理 | 自由推理，Agent 自行决定下一步动作 |
| `ifeq` | 条件判断 | 基于状态或环境变量执行分支逻辑 |
| 多行字符串 | 代码片段 | 在 Makefile 语法中复用代码模板 |

---

## 示例：一个代码审查 Skill

````markdown
---
name: code-review
description: 完整的代码审查工作流。
---

```makefile
# 变量定义
CODE_DIR = src/

# Target: review 依赖 lint、test、summary
review: lint test summary

lint:
	@ cd $(CODE_DIR) && eslint . --format json

test:
	@ cd $(CODE_DIR) && npm test

summary: lint test
	? 基于 lint 错误和测试失败，撰写一份代码审查总结。
```
````

---

## 格式对比数据

| 文件 | 原 SKILL.md | SKILL.make | 压缩率 |
|:---|---:|---:|:---:|
| caveman | 1,916 | 1,714 | -10% |
| design-an-interface | 3,366 | 2,789 | -17% |
| migrate-to-shoehorn | 2,795 | 1,328 | **-52%** |
| scaffold-exercises | 3,589 | 2,744 | -23% |
| tdd | 4,211 | 3,212 | -23% |
| to-issues | 2,737 | 2,027 | -25% |
| **合计** | **66,394** | **56,387** | **-15%** |

> 数据来源：`mattpocock/skills`（"Skills for Real Engineers"）全部 20 个 Skill 转换实测。

---

## 与现有 Skill 格式的关系

SKILL.make 是**兼容层**，不是替代品：

- 兼容大多数 Agent Harness 实现（包括 OpenClaw）
- 渐进迁移：新 Skill 先用，存量 Skill 逐步改写
- 提供 `convert.sh` 脚本，一键转换现有 SKILL.md

---

## 技术栈

- 主语言：Shell
- 规范文件：Markdown + Makefile 语法嵌入块
- 依赖：标准 Unix 工具，无需额外安装

---

## 如何参与

1. **Fork** 本仓库
2. 用 `convert.sh` 体验格式转换
3. 提交 Issue 分享使用反馈
4. 提交 PR 贡献更多示例 Skill 或语言翻译

---

## 状态

目前为 **Proof of Concept（概念验证阶段）**，欢迎测试和反馈。

## 许可证

MIT License
