@echo off
chcp 65001 >nul
title 上传本地文件到云端 (Git Push)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\sync_helper.ps1" -Action push
echo.
pause
