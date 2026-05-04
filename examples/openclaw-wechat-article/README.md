# OpenClaw × SKILL.make 集成示例

> 证明 SKILL.make 规范可在 OpenClaw Agent 系统中直接使用

## 示例内容

本目录包含一个完整的 `SKILL.make` 格式示例技能：**公众号文章写作**（`openclaw-wechat-article`）。

文件：
- `SKILL.make.md` — 技能本体（Makefile 语法）
- `README.md` — 本说明文件

## 为什么在 OpenClaw 里用 SKILL.make

| 对比项 | 传统 SKILL.md | SKILL.make |
|:---|:---|:---|
| Token 消耗 | 高 | 低（节省 15%+） |
| 执行顺序 | LLM 猜测 | DAG 自动解析 |
| 条件分支 | 靠 prompt 描述 | `ifeq` 显式声明 |
| 多文件组合 | 不支持 | 跨文件调用 target |

## 如何在 OpenClaw 中使用

将 `SKILL.make.md` 放入 OpenClaw workspace 的 `skills/` 目录：

```bash
cp SKILL.make.md ~/.openclaw/workspace/skills/wechat-writer/
```

在 OpenClaw 对话中触发：

```
请用 wechat-writer 技能写一篇《XXX》文章
```

OpenClaw Agent 会读取 SKILL.make.md，按依赖图自动执行各个 target。

## 扩展方向

本示例可进一步扩展为：

- 接入 `wechat-mp-writer` skill（微信公众号草稿发布）
- 接入 `xiaohongshu-viral-copy` skill（小红书文案）
- 接入 `image-bot` skill（封面图生成）

## 关于 SKILL.make

详见主项目：
- 规范说明：[README.md](../../README.md)
- 中文说明：[README_CN.md](../../README_CN.md)（由社区贡献）

---

本示例由社区贡献，证明 SKILL.make 可在 OpenClaw 中无缝运行。
