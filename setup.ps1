# claude-daily-ai-news — Setup Script (Windows)

Write-Host "=== claude-daily-ai-news Setup ===" -ForegroundColor Cyan

# 1. Check Node.js
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: Node.js not found. Install from https://nodejs.org" -ForegroundColor Red
    exit 1
}
Write-Host "Node.js: OK" -ForegroundColor Green

# 2. Install md-to-pdf
Write-Host "Installing md-to-pdf..." -ForegroundColor Yellow
npm install -g md-to-pdf
Write-Host "md-to-pdf: OK" -ForegroundColor Green

# 3. Check Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: Python not found. Install from https://python.org" -ForegroundColor Red
    exit 1
}
Write-Host "Python: OK" -ForegroundColor Green

# 4. Copy skill to global Claude commands
$claudeCommandsDir = "$env:USERPROFILE\.claude\commands"
if (-not (Test-Path $claudeCommandsDir)) {
    New-Item -ItemType Directory -Force -Path $claudeCommandsDir | Out-Null
}
Copy-Item ".\.claude\commands\daily-ai-news.md" "$claudeCommandsDir\daily-ai-news.md" -Force
Copy-Item ".\.claude\commands\setup-ai-news.md" "$claudeCommandsDir\setup-ai-news.md" -Force
Write-Host "Skills installed to $claudeCommandsDir" -ForegroundColor Green

# 5. Copy memory template (only if it doesn't already exist)
$memoryFile = "$env:USERPROFILE\.claude\ai-news-memory.json"
if (-not (Test-Path $memoryFile)) {
    Copy-Item ".\.claude\ai-news-memory.json" $memoryFile
    Write-Host "Memory file created at $memoryFile" -ForegroundColor Green
} else {
    Write-Host "Memory file already exists — skipping" -ForegroundColor Yellow
}

# 6. Create output directory from config
$config = Get-Content ".\config.json" | ConvertFrom-Json
$outputDir = $config.output_dir -replace "~", $env:USERPROFILE
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
    Write-Host "Output directory created: $outputDir" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Cyan
Write-Host "Next steps:" -ForegroundColor White
Write-Host "  1. Open Claude Code in this directory" -ForegroundColor White
Write-Host "  2. Run /setup-ai-news — Claude will configure everything for you" -ForegroundColor White
Write-Host "  3. Run /schedule to activate the daily routine" -ForegroundColor White
