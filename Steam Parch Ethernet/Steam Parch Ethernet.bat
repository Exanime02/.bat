:: By exanime.site
@echo off
net session >nul 2>&1
if %errorlevel%==0 goto main

powershell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('Run as Administrator!','SteamBlocker',[System.Windows.MessageBoxButton]::OK,[System.Windows.MessageBoxImage]::Error)"
exit

:main
taskkill /F /IM steam.exe >nul 2>&1
taskkill /F /IM steamwebhelper.exe >nul 2>&1

netsh advfirewall firewall show rule name="Block Steam" >nul 2>&1
if %errorlevel%==0 (
    netsh advfirewall firewall delete rule name="Block Steam" >nul 2>&1
    netsh advfirewall firewall delete rule name="Block SteamWeb" >nul 2>&1
) else (
    netsh advfirewall firewall add rule name="Block Steam" dir=out action=block program="C:\Program Files (x86)\Steam\steam.exe" >nul 2>&1
    netsh advfirewall firewall add rule name="Block SteamWeb" dir=out action=block program="C:\Program Files (x86)\Steam\steamwebhelper.exe" >nul 2>&1
)

start "" "C:\Program Files (x86)\Steam\steam.exe"
