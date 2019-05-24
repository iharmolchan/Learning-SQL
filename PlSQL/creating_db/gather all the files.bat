@echo off
echo.>"%~dp0all.sql"
for %%i in ("%~dp0"*.sql) do echo @"%%~fi" >> "%~dp0all.sql"