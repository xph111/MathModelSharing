@echo off
chcp 65001 >nul
title 云端共享文件夹实时双向自动同步 (AutoSync)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\sync_helper.ps1" -Action watch
pause
