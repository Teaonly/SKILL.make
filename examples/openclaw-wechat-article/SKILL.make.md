---
name: openclaw-wechat-article
description: 公众号文章写作工作流（SKILL.make 格式 · OpenClaw 兼容）
---

```makefile
# ============================================
# 公众号文章写作技能 - SKILL.make 格式示例
# 兼容 OpenClaw Agent Skill 系统
# 使用说明：https://docs.openclaw.ai
# ============================================

# ---------- 变量定义 ----------
ARTICLE_TYPE  ?= 干货教程
TARGET_AUD    ?= 职场人/科技爱好者
LANG          =  中文
WORD_COUNT    ?= 2000
STYLE         ?= 文艺青年风

# ---------- 目标说明 ----------
#
# article   主目标，生成完整文章
# outline   生成文章大纲
# draft     根据大纲写初稿
# polish    润色优化终稿
# cover     生成封面配图提示词
#
# 使用示例：
#   make article ARTICLE_TYPE=实测报告 WORD_COUNT=3000
#   make outline
#   make draft WORD_COUNT=1500
# ============================================

# ---------- 主工作流 ----------

article: outline draft polish cover
	@ echo "✅ 文章生成完成"
	@ echo "📌 封面提示词见文章末尾"

draft: outline
	? 请根据上面的【大纲】撰写一篇 $(LANG) 文章。
	  要求：
	  - 字数：$(WORD_COUNT) 字左右
	  - 风格：$(STYLE)
	  - 受众：$(TARGET_AUD)
	  - 结尾：有互动感，引导评论
	  - 配图提示词：每节末 + 结尾前各一，HTML注释格式
	  输出完整文章，不缩写。

outline:
	? 请根据主题生成一份 5-8 章的文章大纲。
	  要求：
	  - 逻辑递进，适合 $(TARGET_AUD) 阅读
	  - 每章：标题 + 一句话描述
	  - Markdown 列表格式

polish: draft
	? 请润色上面的文章初稿：
	  - 去除模板化表达
	  - 开头不编故事，用真实共鸣切入
	  - 二级标题不加序号
	  - 结尾有互动感，不加预告/系列回顾
	  直接输出完整文章。

# ---------- 封面配图 ----------

cover:
	? 根据文章主题『$(ARTICLE_TYPE)』生成封面配图提示词。
	  格式：
	  <!-- 封面提示词（16:9）
	  [主体描述]：...
	  [背景]：...
	  [风格]：...
	  [视角/构图]：...
	  -->

# ---------- 调试目标 ----------

test:
	@ echo "ARTICLE_TYPE : $(ARTICLE_TYPE)"
	@ echo "TARGET_AUD   : $(TARGET_AUD)"
	@ echo "WORD_COUNT   : $(WORD_COUNT)"
	@ echo "STYLE        : $(STYLE)"
	@ echo ""
	@ echo "可用目标：article / outline / draft / polish / cover / test"

.PHONY: article outline draft polish cover test
```
