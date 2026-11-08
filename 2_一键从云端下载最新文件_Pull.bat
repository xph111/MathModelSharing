@echo off
chcp 65001 >nul
title 从云端下载最新文件 (Git Pull)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\sync_helper.ps1" -Action pull
echo.
pause
