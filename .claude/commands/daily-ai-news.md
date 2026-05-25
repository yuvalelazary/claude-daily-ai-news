# Daily AI News Generator

Generate a daily AI news document with a fresh How To tip and skill — no repeats across days. Then send by email.

## Step 1 — Load Config

Find the repo root (the directory containing `config.json`).
Read `config.json` using the Read tool.

Extract:
- `email` — recipient email address
- `output_dir` — where to save the PDF (expand ~ to home directory)

## Step 2 — Read Memory

Read `~/.claude/ai-news-memory.json`.

Extract:
- `used_howto` — already-shown How To topics
- `used_skills` — already-shown skills
- `howto_pool` — all available How To topics
- `skills_pool` — all available skills

If the file doesn't exist, create it with empty used lists and the default pools below.

**Default howto_pool:**
["CLAUDE.md","Hooks","Agents","compact","Parallel tool calls","Memory system","Worktrees","MCP servers","Permission management","init"]

**Default skills_pool:**
["/simplify","/review","/security-review","/verify","/run","/init","/session:handoff"]

## Step 3 — Pick Fresh Content

Select ONE topic from `howto_pool` NOT in `used_howto`.
Select ONE skill from `skills_pool` NOT in `used_skills`.

If all items in a pool are used → reset that pool's used list to [] and start over.

**How To topics guide:**
- `Hooks` — automatic commands that run before/after every tool Claude uses
- `Agents` — sending sub-tasks to a separate agent to protect main context
- `compact` — the /compact command that compresses context when it grows too large
- `Parallel tool calls` — running multiple tools simultaneously to save time
- `Memory system` — the ~/.claude/memory/ folder that persists info across sessions
- `Worktrees` — working on multiple git branches simultaneously without switching
- `MCP servers` — connecting external tools (Slack, GitHub, databases) to Claude Code
- `Permission management` — pre-approving safe commands so Claude doesn't ask every time
- `init` — the /init command that auto-generates a CLAUDE.md from an existing project

**Skills guide:**
- `/review` — full code review of current branch before opening a PR
- `/security-review` — security audit of all changes on the branch
- `/verify` — runs the app and visually confirms a change works
- `/run` — launches the project and observes real behavior
- `/init` — creates CLAUDE.md automatically from the existing project structure

## Step 4 — Search Today's News

Use WebSearch with these queries:
- `AI news today [insert current date]`
- `site:the-decoder.com AI [insert current date]`

Pick the 5 most important stories from TODAY only. No old news.

## Step 5 — Write the Document

Today's date → filename: `AI_Daily_DD_MM_YYYY.md`
Save to the `output_dir` from config.

```
<style>
  body { direction: rtl; text-align: right; font-family: 'Segoe UI', Arial, sans-serif; line-height: 1.8; }
  h1, h2, h3, p, li, blockquote, td, th { direction: rtl; text-align: right; }
  pre, code { direction: ltr; text-align: left; }
  table { width: 100%; }
</style>

<div dir="rtl">

# עדכון AI יומי — [DATE IN HEBREW]

> מקורות: [The Decoder](https://the-decoder.com) · [Build Fast With AI](https://www.buildfastwithai.com)

---

## חדשות היום

### [Headline 1]
[2-3 sentences in Hebrew]

[... 4 more stories ...]

---

## How To — Claude Code

### [SELECTED HOWTO TOPIC]

[Detailed explanation in Hebrew — minimum 150 words.
Cover: what problem it solves, step-by-step how to use it, code example if relevant, what you gain.]

---

## סקיל שכדאי להכיר

### [SELECTED SKILL]

[Explanation in Hebrew — minimum 100 words.
Cover: what it does, when to use it, exact command, what the output looks like.]

---

*עודכן: [DATE]*

</div>
```

## Step 6 — Convert to PDF

```bash
cd "[output_dir]" && md-to-pdf AI_Daily_[DATE].md
```

## Step 7 — Send Email

```bash
python "[repo_root]/scripts/send-email.py"
```

## Step 8 — Update Memory

Add selected howto topic to `used_howto`.
Add selected skill to `used_skills`.
Update `last_generated` to today's date.
Write back to `~/.claude/ai-news-memory.json`.

## Rules

- All document text in Hebrew (except code blocks and tool names)
- Never repeat a topic/skill already in used lists
- Always update memory after generating
- News must be from TODAY only
