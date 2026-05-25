# Setup: Daily AI News

Guide the user through configuring their daily AI news delivery. Update config.json automatically — no manual editing required.

## Step 1 — Check Current Config

Read the file `config.json` from the repo root (search for it starting from the current directory, then parent directories).

Check if BOTH these fields are already filled (not placeholder values):
- `email` is set and not "your@gmail.com"
- `gmail_app_password` is set and not "xxxx xxxx xxxx xxxx"

If BOTH are already filled → skip to Step 4.

## Step 2 — Ask for Details

Ask the user in a single message:

> "כדי להגדיר את המשלוח היומי, אני צריך שני פרטים:
> 1. מה כתובת המייל שלך?
> 2. באיזו שעה לשלוח כל יום? (לדוגמה: 08:00)"

Wait for their answer before continuing.

## Step 3 — Ask for Gmail App Password

After getting email and time, explain:

> "עכשיו צריך סיסמת אפליקציה של Gmail (App Password).
>
> איך מקבלים:
> 1. כנס ל-myaccount.google.com/security
> 2. חפש "App Passwords" (צריך שה-2FA מופעל)
> 3. צור סיסמה חדשה וקבל קוד של 16 תווים
>
> הדבק את הקוד כאן:"

Wait for the app password.

## Step 4 — Write to config.json

Update config.json with the collected values.

Read the current config.json, then write it back with:
- `email` → the email the user provided
- `gmail_app_password` → the app password the user provided
- `schedule_time` → the time the user provided (format: "HH:MM")
- `output_dir` → keep existing value

## Step 5 — Confirm & Next Step

After saving, reply:

> "✓ ההגדרות נשמרו.
>
> כדי להפעיל את הרוטין היומי הרץ:
> `/schedule`
>
> ואמור לו: 'הרץ את /daily-ai-news כל יום בשעה [TIME]'"

## Rules

- Never print the app password back to the user after they paste it
- If the user makes a mistake (e.g. wrong email format), ask again
- Keep the entire conversation in Hebrew
