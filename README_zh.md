# SKILL.mk 一种 Makefile 格式的 SKILL 文档

本项目提出一种 Makeifile 格式的 SKILL 文档规范，这种文档具备逻辑链清晰、Token消耗少（按需加载）、可检验、可审计等优点。

## 为什么采用 Makefile 格式

Makefile 格式的 SKILL 文档，具有以下的优点，非常适合应用到 Agent 框架中。

- **内置逻辑链 DAG** : 大多数的 SKILL 都隐含一个逻辑 DAG，这个逻辑 DAG 实际上就是一种 Plan Mode，直接用显示的 DAG 描述，不仅仅可以降低描述说明的 Token 成本，同时可以提供 Agent 执行准确性，降低错误率。

- **按需加载的能力** : 在 SKILL.mk 的 meta 信息，提供关键词列表，这些关键词直接对应 Makefile 中的 target，因此通过专门的 SKILL.mk 加载工具，实现按需加载对应的 Recipe 上下文。在 Agent 运行时，可以有效的降低 Token 成本。

- **强大的可检验性**： SKILL.mk 本身是可检验、可运行的，同时具备可审计性（git跟踪，调用统计等），非常适合自演化，特别是 Recipe 可以单独优化。

- **支持简单**: Makefile 是一种久经考验的工具，很容易找到 Makefile 解析工具，并且集成到现有的 Agent 框架里面。

## 以Web Search 使用SKILL为例子

这里以Web Search SKILL，展示一个两种格式的对比，Web Search SKILL 使用非常频繁，足够典型。

### 标准的 SKILL.md 格式

````markdown
---
name: brave-search
description: Web search and content extraction via Brave Search API. Use for searching documentation, facts, or any web content. Lightweight, no browser required.
---

# Brave Search

Web search and content extraction using the official Brave Search API. No browser required.

## Setup

Requires a Brave Search API account with a free subscription. A credit card is required to create the free subscription (you won't be charged).

1. Create an account at https://api-dashboard.search.brave.com/register
2. Create a "Free AI" subscription
3. Create an API key for the subscription
4. Add to your shell profile (`~/.profile` or `~/.zprofile` for zsh):
   ```bash
   export BRAVE_API_KEY="your-api-key-here"
   ```
5. Install dependencies (run once):
   ```bash
   cd {baseDir}
   npm install
   ```

## Search

```bash
{baseDir}/search.js "query"                         # Basic search (5 results)
{baseDir}/search.js "query" -n 10                   # More results (max 20)
{baseDir}/search.js "query" --content               # Include page content as markdown
{baseDir}/search.js "query" --freshness pw          # Results from last week
{baseDir}/search.js "query" --freshness 2024-01-01to2024-06-30  # Date range
{baseDir}/search.js "query" --country DE            # Results from Germany
{baseDir}/search.js "query" -n 3 --content          # Combined options
```

### Options

- `-n <num>` - Number of results (default: 5, max: 20)
- `--content` - Fetch and include page content as markdown
- `--country <code>` - Two-letter country code (default: US)
- `--freshness <period>` - Filter by time:
- `pd` - Past day (24 hours)
- `pw` - Past week
- `pm` - Past month
- `py` - Past year
- `YYYY-MM-DDtoYYYY-MM-DD` - Custom date range

## Extract Page Content

```bash
{baseDir}/content.js https://example.com/article
```

Fetches a URL and extracts readable content as markdown.

## Output Format

```
--- Result 1 ---
Title: Page Title
Link: https://example.com/page
Age: 2 days ago
Snippet: Description from search results
Content: (if --content flag used)
  Markdown content extracted from the page...

--- Result 2 ---
...
```

## When to Use

- Searching for documentation or API references
- Looking up facts or current information
- Fetching content from specific URLs
- Any task requiring web search without interactive browsing

````

### SKILL.mk 格式

````makefile
---
name: brave-search
description: Web search and content extraction via Brave Search API. Use for searching documentation, facts, or any web content. Lightweight, no browser required.
target: when-to-use setup query
---

when-to-use:
    Web search and content extraction using the official Brave Search API. No browser required. 
    - Searching for documentation or API references
    - Looking up facts or current information
    - Fetching content from specific URLs
    - Any task requiring web search without interactive browsing   

setup: when-to-use
    Requires a Brave Search API account with a free subscription. A credit card is required to create the free subscription (you won't be charged).
    1. Create an account at https://api-dashboard.search.brave.com/register
    2. Create a "Free AI" subscription
    3. Create an API key for the subscription

    4. Add to your shell profile (`~/.profile` or `~/.zprofile` for zsh):
    @export BRAVE_API_KEY="your-api-key-here"
    
    5. Install dependencies (run once):
    @cd {baseDir}
    @npm install


query: when-to-use setup options output_format
    @{baseDir}/search.js "query"                         # Basic search (5 results)
    @{baseDir}/search.js "query" -n 10                   # More results (max 20)
    @{baseDir}/search.js "query" --content               # Include page content as markdown
    @{baseDir}/search.js "query" --freshness pw          # Results from last week
    @{baseDir}/search.js "query" --freshness 2024-01-01to2024-06-30  # Date range
    @{baseDir}/search.js "query" --country DE            # Results from Germany
    @{baseDir}/search.js "query" -n 3 --content          # Combined options
    @{baseDir}/content.js https://example.com/article    # Fetches a URL and extracts readable content as markdown.

options:
    `-n <num>` - Number of results (default: 5, max: 20)
    `--content` - Fetch and include page content as markdown
    `--country <code>` - Two-letter country code (default: US)
    `--freshness <period>` - Filter by time:
    - `pd` - Past day (24 hours)
    - `pw` - Past week
    - `pm` - Past month
    - `py` - Past year
    `YYYY-MM-DDtoYYYY-MM-DD` - Custom date range

output_format:
    --- Result 1 ---
    Title: Page Title
    Link: https://example.com/page
    Age: 2 days ago
    Snippet: Description from search results
    Content: (if --content flag used)
    Markdown content extracted from the page...
    --- Result 2 ---
    ...
````

### 两种格式比较

| 比较项目 | SKILL.md | SKILL.mk |
| -------- | -------- | -------- |
| 全加载 | 一次性完整加载，2165 个字符 | 一次完全加载，只需要 2014，减少 7% |
| 动态加载 * | 不支持 | 仅仅试探加载 readme，只需要 313 个字符，减少 85%   |
| 可审计 * | 整体文件为单位，无法分拆 | 以 recipe 为调用单位，可跟踪单独调用成功率 |

"*" 需要专门的Agent 工具，如没有专门的工具支持，也可平替SKILL.md 文件

## 1.0 规范定义

| 编号 | 规则 | 规则说明 |
| -------- | -------- | -------- |
| 1 | 按需加载 | 参数 target = [] 表示全加载，target =['readme'] 表示仅加载 readme 以及依赖 |
| 2 | recipe 定义| 整个 recipe 为多行文本，每行以\t开头，target 名字必须为不包含空格的字符串 |
| 3 | recipe 加载| 完整的加载形式：name:[dep1 dep2]\n\tline1\n\tline2\n, recipe 按定义顺序|
| 4 | 其他 | 除了 recipe 加载之外，SKILL.mk文件其他内容不加载 |

## 格式对比

We tested a complete SKILL collection (from the well-known "Skills for Real Engineers" — https://github.com/mattpocock/skills) using the Makefile format. It not only improves logical structure and readability, but more importantly, these SKILL.make files are well-suited for auditing (git tracking, invocation statistics) and lay a solid foundation for Evolution Engineering.

You can use `convert.sh` to reproduce this conversion. The comparison statistics are as follows:

```txt
File                                       SKILL.md   SKILL.mk   Change
---------------------------------------- ---------- ---------- --------
caveman                                        1916       1982      +3%
design-an-interface                            3366       2681     -20%
domain-model                                   3512       2902     -17%
edit-article                                    721        660      -8%
git-guardrails-claude-code                     2312       2162      -6%
github-triage                                 10089       9299      -7%
improve-codebase-architecture                  5509       4232     -23%
migrate-to-shoehorn                            2795       1279     -54%
obsidian-vault                                 1511       1423      -5%
qa                                             4965       4686      -5%
request-refactor-plan                          2711       2806      +3%
scaffold-exercises                             3589       2768     -22%
setup-pre-commit                               2261       2599     +14%
tdd                                            4211       3006     -28%
to-issues                                      2737       2536      -7%
to-prd                                         2460       2417      -1%
triage-issue                                   3783       3738      -1%
ubiquitous-language                            4890       2515     -48%
write-a-skill                                  3056       2760      -9%

TOTAL                                         66394      56451     -14%
```

## Status

This is a **proof-of-concept** specification. This specification is designed to be compatible with most Agent Harness implementations.

## License

[MIT](LICENSE)
