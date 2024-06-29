# Vars

. ".\.vscode\Global.ps1"

# intunewin
[string]$Uri = "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/raw/master"
[string]$Exe = "IntuneWinAppUtil.exe"

# Source content prep tool
if (-not(Test-Path -Path "$env:ProgramData\$exe")){
	Invoke-WebRequest -Uri "$Uri/$Exe" -OutFile "$env:ProgramData\$Exe"
}

# Execute content prep tool
$processOptions = @{
	FilePath = "$env:ProgramData\$Exe"
	ArgumentList = "-c ""$Cache"" -s ""$Cache\Deploy-Application.exe"" -o ""C:\temp"" -q"
	WindowStyle = "Maximized"
	Wait = $true
}
Start-Process @processOptions

# Rename and prepare for upload
Move-Item -Path 'C:\temp\DeployApplication.intunewin' -Destination "$Desktop\$Application.intunewin" -Force -Verbose
explorer $Desktop
