---
name: grill-me
description: >
  需求审问工作流——逐层追问直到达成共识，防止方向跑偏。
  Use when user says "grill me", "追问", "压力测试", "确认需求" 或想审问计划。
---

```makefile
# ============================================
# grill-me - 需求审问工作流
# 来源：mattpocock/skills (MIT License)
# 转换为 SKILL.make 格式
# ============================================

# ---------- 主目标 ----------

# 用法：make grill
grill: greet question_loop
	@ echo "✅ 审问完成，已达成共识。"

# ---------- 流程 ----------

greet:
	@ echo "好的，开始审问环节。"

question_loop:
	? 追问用户计划的每一个方面，直到达成共识。
	  逐层深入决策树，逐个解决依赖。
	  每个问题给出你的推荐答案。
	  一次只问一个问题，等待用户回答后再继续下一个。
	  如果问题可以通过探索代码库回答，就去探索。
	  直到所有关键决策点都被覆盖。

.PHONY: grill greet question_loop
```
