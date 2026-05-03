---
name: write-a-skill
description: >
  从零构建 Agent Skill：收集需求、草稿、审核、提交。
  Use when user wants to create/build/write a new skill, make a SKILL.md, or says "写技能"、"写个skill"。
---

```makefile
# ============================================
# write-a-skill - Skill 编写工作流
# 来源：mattpocock/skills (MIT License)
# 转换为 SKILL.make 格式
# ============================================

SKILL_NAME   ?= my-skill
SKILL_DIR   ?= skills/
OUT_PATH    :=  $(SKILL_DIR)$(SKILL_NAME)/

# ---------- 主流程 ----------

# 用法：make skill SKILL_NAME=xxx
skill: requirements draft review commit
	@ echo "✅ Skill '$(SKILL_NAME)' 创建完成"

# ---------- Step 1: 收集需求 ----------

requirements:
	@ echo "=== Step 1: 收集需求 ==="
	? 向用户提问收集以下信息（一次一个问题）：
	  1. 这个 Skill 覆盖什么任务/领域？
	  2. 它需要处理哪些具体场景？
	  3. 它需要可执行脚本还是只需要指令？
	  4. 需要包含哪些参考资料？
	  等待用户回答完所有问题后再进入下一步。

draft: requirements
	@ echo "=== Step 2: 撰写草稿 ==="
	@ echo "创建目录：$(OUT_PATH)"
	@ mkdir -p $(OUT_PATH)
	? 根据收集到的需求，撰写 SKILL.md：
	  - description：不超过 1024 字符，第三人称，第一句说功能，第二句说触发条件
	  - 主内容：快速开始 / 工作流 / 高级特性
	  - 如果内容超过 100 行，考虑拆成 SKILL.md + REFERENCE.md
	  - 如果有确定性操作（验证/格式化），考虑加 scripts/ 目录
	  输出完整文件内容。

reference:
	@ echo "检查是否需要 REFERENCE.md..."
	? 检查草稿是否超过 100 行：
	  - 超过 → 抽取高级特性到 REFERENCE.md，在主文件加链接
	  - 未超过 → 跳过此步

scripts:
	@ echo "检查是否需要 scripts/..."
	? 检查是否有确定性操作需要脚本：
	  - 有 → 在 scripts/ 下创建对应脚本
	  - 无 → 跳过此步

# ---------- Step 3: 审核 ----------

review: draft reference scripts
	@ echo "=== Step 3: 审核 ==="
	? 向用户呈现完整草稿，逐项确认：
	  1. description 包含触发关键词了吗？
	  2. SKILL.md 在 100 行以内？
	  3. 无时效性信息？
	  4. 术语一致？
	  5. 有具体示例吗？
	  等待用户反馈，如有修改需求则循环修订。

# ---------- Step 4: 提交 ----------

commit: review
	@ echo "=== Step 4: 提交 ==="
	? 将最终文件提交到仓库。格式：
	  - skill-name/
	  │   ├── SKILL.md
	  │   ├── REFERENCE.md  （如有）
	  │   ├── EXAMPLES.md   （如有）
	  │   └── scripts/      （如有）

# ---------- 辅助目标 ----------

template:
	@ echo "=== SKILL.md 标准模板 ==="
	@ echo ""
	@ echo '```markdown'
	@ echo '---'
	@ echo 'name: skill-name'
	@ echo 'description: >'
	@ echo '  功能一句话描述。 Use when [触发关键词]。'
	@ echo '---'
	@ echo ''
	@ echo '# Skill Name'
	@ echo ''
	@ echo '## Quick Start'
	@ echo '[最小可用示例]'
	@ echo ''
	@ echo '## Workflows'
	@ echo '[带检查清单的步骤流程]'
	@ echo ''
	@ echo '## Advanced'
	@ echo 'See [REFERENCE.md](REFERENCE.md)'
	@ echo '```'

checklist:
	@ echo "=== 发布前检查清单 ==="
	@ echo "[ ] description 包含 'Use when...' 触发条件"
	@ @echo "[ ] SKILL.md < 100 行"
	@ echo "[ ] 无时效性信息"
	@ echo "[ ] 术语一致"
	@ echo "[ ] 有具体示例"
	@ echo "[ ] 引用层级不超过 1 层"

.PHONY: skill requirements draft reference scripts review commit template checklist
```
