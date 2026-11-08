@echo off
chcp 65001 >nul
title 绑定云端 Git 共享仓库
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\sync_helper.ps1" -Action bind
echo.
pause
