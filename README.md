# עדכון AI יומי — Claude Code Daily Briefing

קבל סיכום יומי של **חדשות AI** + **טיפ על Claude Code** + **סקיל** — ישירות למייל, כל בוקר ב-8:00.

כל משתמש מתחיל עם זיכרון נקי — לא משנה מתי הצטרפת.

---

## מה צריך

| כלי | שימוש | חינם? |
|-----|-------|-------|
| [Claude Code](https://claude.ai/download) | ליצור ולנהל את הרוטין | ✓ |
| [GitHub](https://github.com) | לאחסן סיכומים ולהפעיל שליחת מייל | ✓ |
| [Resend](https://resend.com) | לשלוח מיילים | ✓ (100/יום) |

---

## הגדרה (10 דקות)

### 1. התקן Claude Code
כנס ל-[claude.ai/code/routines](https://claude.ai/code/routines) (אפשר בדפדפן בלי התקנה, או הורד את [Claude Code](https://claude.ai/download) ל-Mac/Windows)

### 2. צור Resend API Key
1. הירשם ב-[resend.com](https://resend.com)
2. לחץ **API Keys** → **Create API Key**
3. העתק את המפתח

### 3. צור GitHub Personal Access Token
1. כנס ל-[github.com/settings/tokens/new](https://github.com/settings/tokens/new)
2. **Note:** `claude-daily-routine`
3. **Expiration:** `No expiration`
4. סמן ✓ **repo**
5. לחץ **Generate token** והעתק (מופיע פעם אחת בלבד!)

### 4. צור את הרוטין
כנס ל-[claude.ai/code/routines](https://claude.ai/code/routines) → **New Routine**

**הגדרות:**
- **Schedule:** `0 5 * * *`
- **Repo:** `https://github.com/yuvalelazary/claude-daily-ai-news`
- **Model:** `claude-sonnet-4-6`

**פרומפט** — העתק והחלף 4 פרטים:

```
Generate today's daily AI news document for user: YOUR_EMAIL

Follow these steps exactly:

## Step 1 — Read Memory
The memory file for this user is: .claude/memory/YOUR_NAME.json

If the file does NOT exist, create it with this content and save it:
{
  "used_howto": [],
  "used_skills": [],
  "howto_pool": ["Hooks", "Agents", "compact", "Parallel tool calls", "Memory system", "Worktrees", "MCP servers", "Permission management", "init"],
  "skills_pool": ["/review", "/security-review", "/verify", "/run", "/init"],
  "last_generated": ""
}

If it exists, read it and extract: used_howto, used_skills, howto_pool, skills_pool.

## Step 2 — Pick Fresh Content
Select ONE topic from howto_pool NOT in used_howto.
Select ONE skill from skills_pool NOT in used_skills.
If all items in a pool are used, reset that pool's used list to [] and start over.

How To topics guide:
- Hooks: automatic commands that run before/after every tool Claude uses
- Agents: sending sub-tasks to a separate agent to protect main context
- compact: the /compact command that compresses context when it grows too large
- Parallel tool calls: running multiple tools simultaneously to save time
- Memory system: the ~/.claude/memory/ folder that persists info across sessions
- Worktrees: working on multiple git branches simultaneously without switching
- MCP servers: connecting external tools (Slack, GitHub, databases) to Claude Code
- Permission management: pre-approving safe commands so Claude doesn't ask every time
- init: the /init command that auto-generates a CLAUDE.md from an existing project

Skills guide:
- /review: full code review of current branch before opening a PR
- /security-review: security audit of all changes on the branch
- /verify: runs the app and visually confirms a feature works
- /run: launches the project and observes real behavior
- /init: creates CLAUDE.md automatically from the existing project structure

## Step 3 — Search Today's News
Use WebSearch for: 'AI news today [current date]' and 'site:the-decoder.com AI [current date]'.
Pick 5 important stories from TODAY only.

## Step 4 — Write the Document
Compute today's date. Save the file to: docs/YOUR_NAME/AI_Daily_DD_MM_YYYY.md
Create the docs/YOUR_NAME/ directory if it doesn't exist.

Write the file with this exact structure:

# עדכון AI יומי — [DATE IN HEBREW]

> מקורות: [The Decoder](https://the-decoder.com) · [Build Fast With AI](https://www.buildfastwithai.com)

---

## חדשות היום

[5 news stories — headline + 2-3 sentences each in Hebrew]

---

## How To — Claude Code

### [SELECTED HOWTO TOPIC IN HEBREW]

[Detailed explanation in Hebrew — minimum 150 words.]

---

## סקיל שכדאי להכיר

### [SELECTED SKILL]

[Explanation in Hebrew — minimum 100 words.]

---

*עודכן: [DATE]*

## Step 5 — Update Memory
Add selected howto topic to used_howto.
Add selected skill to used_skills.
Update last_generated to today's date.
Write back to .claude/memory/YOUR_NAME.json

## Step 6 — Commit and Push
Run:
git config user.email 'routine@claude.ai'
git config user.name 'Claude Daily Routine'
git remote set-url origin https://YOUR_GITHUB_PAT@github.com/yuvalelazary/claude-daily-ai-news
git add -A
git commit -m 'Daily AI news: YOUR_NAME [DATE]'
git push origin master

## Rules
- All document text in Hebrew (except code blocks and tool names)
- Never repeat a topic or skill already in this user's used lists
- Always commit and push — this triggers the GitHub Action that sends the email
- News must be from TODAY only
```

**3 פרטים להחליף:**

| מה | במה להחליף | איפה מופיע |
|-----|---------------|------------|
| `YOUR_EMAIL` | המייל שלך (`david@gmail.com`) | שורה ראשונה של הפרומפט |
| `YOUR_NAME` | שם קצר באנגלית ללא רווחים (`david`) | נתיב הזיכרון, תיקיית הפלט, הקומיט |
| `YOUR_GITHUB_PAT` | ה-Token מ-GitHub | שורת `git remote set-url` |

> **הרשאות:** ה-repo כבר כולל `.claude/settings.json` עם הרשאות מלאות לרוטין — אין צורך להגדיר כלום נוסף.

### 5. סמן "Not Spam"
המייל הראשון יגיע לספאם — סמן אותו **Not spam** ומהמייל השני יגיע לתיבה הראשית.

---

## איך זה עובד

```
Claude Routine (08:00) → כותב סיכום → דוחף ל-GitHub → GitHub Action → Resend → המייל שלך
```
