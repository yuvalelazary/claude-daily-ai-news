import smtplib
import json
import os
import glob
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email import encoders
from datetime import date

# Load config
config_path = os.path.join(os.path.dirname(__file__), '..', 'config.json')
with open(config_path, 'r', encoding='utf-8') as f:
    config = json.load(f)

EMAIL = config['email']
APP_PASSWORD = config['gmail_app_password']
OUTPUT_DIR = os.path.expanduser(config['output_dir'])

# Find today's PDF
today = date.today().strftime('%d_%m_%Y')
pattern = os.path.join(OUTPUT_DIR, f'AI_Daily_{today}.pdf')
matches = glob.glob(pattern)

if not matches:
    # fallback: pick the most recent PDF in the folder
    all_pdfs = glob.glob(os.path.join(OUTPUT_DIR, '*.pdf'))
    if not all_pdfs:
        print("No PDF found to send.")
        exit(1)
    matches = [max(all_pdfs, key=os.path.getmtime)]

pdf_path = matches[0]
pdf_name = os.path.basename(pdf_path)

# Build email
msg = MIMEMultipart()
msg['From'] = EMAIL
msg['To'] = EMAIL
msg['Subject'] = f'עדכון AI יומי — {date.today().strftime("%d.%m.%Y")}'

body = 'מצורף עדכון ה-AI היומי שלך.\n\nנוצר אוטומטית על ידי claude-daily-ai-news.'
msg.attach(MIMEText(body, 'plain', 'utf-8'))

# Attach PDF
with open(pdf_path, 'rb') as f:
    part = MIMEBase('application', 'octet-stream')
    part.set_payload(f.read())
    encoders.encode_base64(part)
    part.add_header('Content-Disposition', f'attachment; filename="{pdf_name}"')
    msg.attach(part)

# Send via Gmail SMTP
with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
    server.login(EMAIL, APP_PASSWORD)
    server.send_message(msg)

print(f"Sent {pdf_name} to {EMAIL}")
