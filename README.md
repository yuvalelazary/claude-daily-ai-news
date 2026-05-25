# claude-daily-ai-news

A Claude Code skill that generates a daily AI news document in Hebrew — delivered to your inbox every morning.

Every day you get:
- **5 fresh AI news stories** from that day
- **1 How To tip** for Claude Code (no repeats across days)
- **1 useful skill** to know (no repeats across days)

Formatted in RTL Hebrew, converted to PDF, and sent to your email automatically.

---

## Requirements

- [Claude Code](https://claude.ai/code) installed
- [Node.js](https://nodejs.org) (for md-to-pdf)
- [Python 3](https://python.org) (for email sending)
- A Gmail account

---

## Setup (5 minutes)

### Step 1 — Clone the repo

```bash
git clone https://github.com/YOUR_USERNAME/claude-daily-ai-news.git
cd claude-daily-ai-news
```

### Step 2 — Edit config.json

Open `config.json` and fill in your details:

```json
{
  "email": "your@gmail.com",
  "gmail_app_password": "xxxx xxxx xxxx xxxx",
  "schedule_time": "08:00",
  "output_dir": "~/Desktop/ai-news"
}
```

**How to get a Gmail App Password:**
1. Go to [myaccount.google.com/security](https://myaccount.google.com/security)
2. Enable 2-Step Verification if not already on
3. Search for "App Passwords"
4. Create a new app password → copy the 16-character code
5. Paste it into `gmail_app_password` in config.json

### Step 3 — Run setup

**Windows (PowerShell):**
```powershell
.\setup.ps1
```

**Mac/Linux:**
```bash
npm install -g md-to-pdf
cp .claude/commands/daily-ai-news.md ~/.claude/commands/daily-ai-news.md
cp .claude/ai-news-memory.json ~/.claude/ai-news-memory.json
```

### Step 4 — Test it

Open Claude Code in this directory and run:
```
/daily-ai-news
```

You should see a PDF generated in your output folder and an email arrive in your inbox.

### Step 5 — Schedule daily delivery

In Claude Code, run:
```
/schedule
```

Follow the prompts to set your preferred time (e.g. 8:00 AM every day).

---

## How the no-repeat system works

The file `~/.claude/ai-news-memory.json` tracks which How To tips and skills have already appeared. Each day the skill picks one that hasn't been shown yet. After all 10 topics / 7 skills have been used, it resets and cycles again.

---

## Customization

**Add your own How To topics:** Edit `howto_pool` in `~/.claude/ai-news-memory.json`

**Add your own skills:** Edit `skills_pool` in the same file

**Change output language:** Edit the prompt in `.claude/commands/daily-ai-news.md`

---

## Project structure

```
claude-daily-ai-news/
├── README.md
├── config.json                        ← fill in your details
├── setup.ps1                          ← Windows setup script
├── scripts/
│   └── send-email.py                  ← email sender
└── .claude/
    ├── commands/
    │   └── daily-ai-news.md           ← the skill
    └── ai-news-memory.json            ← memory template
```

---

## Credits

Built by [yuvalelazary](https://github.com/yuvalelazary)  
Session handoff skill by [qdhenry](https://github.com/qdhenry/Claude-Command-Suite)
