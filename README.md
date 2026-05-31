# עדכון AI יומי — Claude Code Daily Briefing

קבל סיכום יומי של **חדשות AI** + **טיפ על Claude Code** + **סקיל** — ישירות למייל, כל בוקר.

כל משתמש מקבל תוכן שונה מדי יום — הרוטין זוכר מה כבר נשלח ולא חוזר על עצמו.

---

## מה צריך

| כלי | שימוש | חינם? |
|-----|-------|-------|
| [GitHub](https://github.com) | לאחסן סיכומים ולהפעיל שליחת מייל | ✓ |
| [Resend](https://resend.com) | לשלוח מיילים | ✓ (100/יום) |
| [claude.ai/code](https://claude.ai/code) | להריץ את הרוטין היומי | ✓ |

---

## הגדרה

### 1. Fork את ה-Repo

לחץ **Fork** בפינה הימנית העליונה של הדף הזה.
זה יוצר עותק שלך בכתובת `https://github.com/YOUR_GITHUB_USERNAME/claude-daily-ai-news`.

---

### 2. צור Resend API Key

1. הירשם ב-[resend.com](https://resend.com)
2. לחץ **API Keys** → **Create API Key**
3. העתק את המפתח

---

### 3. הוסף את המפתח כ-GitHub Secret

ב-repo שלך (לאחר ה-Fork):

1. לחץ **Settings** → **Secrets and variables** → **Actions**
2. לחץ **New repository secret**
3. **Name:** `RESEND_API_KEY`
4. **Secret:** הדבק את המפתח מ-Resend
5. לחץ **Add secret**

---

### 4. הוסף את עצמך ל-EMAIL_MAP

פתח את הקובץ `.github/workflows/send-email.yml` ב-repo שלך ומצא את השורות:

```python
EMAIL_MAP = {
    "yuval": "yuvalelazary@gmail.com",
}
```

החלף בפרטים שלך:

```python
EMAIL_MAP = {
    "YOUR_NAME": "YOUR_EMAIL",
}
```

שמור ודחף.

---

### 5. צור GitHub Personal Access Token

1. כנס ל-[github.com/settings/tokens/new](https://github.com/settings/tokens/new)
2. **Note:** `claude-daily-routine`
3. **Expiration:** `No expiration`
4. סמן ✓ **repo**
5. לחץ **Generate token** והעתק (מופיע פעם אחת בלבד!)

---

### 6. צור את הרוטין ב-Claude Code

כנס ל-[claude.ai/code](https://claude.ai/code) → **Routines** → **New Routine**

**הגדרות:**
- **Schedule:** `0 5 * * *` (08:00 שעון ישראל)
- **Repo:** `https://github.com/YOUR_GITHUB_USERNAME/claude-daily-ai-news`
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
git remote set-url origin https://YOUR_GITHUB_PAT@github.com/YOUR_GITHUB_USERNAME/claude-daily-ai-news
git add -A
git commit -m 'Daily AI news: YOUR_NAME [DATE]'
git push origin master

## Rules
- All document text in Hebrew (except code blocks and tool names)
- Never repeat a topic or skill already in this user's used lists
- Always commit and push — this triggers the GitHub Action that sends the email
- News must be from TODAY only
```

**4 פרטים להחליף:**

| מה | במה להחליף | איפה מופיע |
|-----|---------------|------------|
| `YOUR_EMAIL` | המייל שלך (`david@gmail.com`) | שורה ראשונה + EMAIL_MAP |
| `YOUR_NAME` | שם קצר באנגלית ללא רווחים (`david`) | זיכרון, תיקיית פלט, קומיט, EMAIL_MAP |
| `YOUR_GITHUB_USERNAME` | שם המשתמש שלך ב-GitHub | כתובת ה-repo, שורת `git remote` |
| `YOUR_GITHUB_PAT` | ה-Token מ-GitHub (שלב 5) | שורת `git remote set-url` |

> **הרשאות:** ה-repo כבר כולל `.claude/settings.json` עם כל הרשאות הרוטין — אין צורך להגדיר כלום נוסף.

---

### 7. סמן "Not Spam"

המייל הראשון עשוי להגיע לספאם — סמן **Not spam** וממייל שני יגיע לתיבה הראשית.

---

## איך זה עובד

```
Claude Routine (08:00) → כותב סיכום → דוחף ל-GitHub → GitHub Action → Resend → המייל שלך
```
