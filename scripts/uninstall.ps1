param([string]$ZCodeExe = "F:\ZCode\ZCode.exe")
$ErrorActionPreference = "Continue"
$env:ELECTRON_RUN_AS_NODE = "1"
$cli = Join-Path (Split-Path $ZCodeExe) "resources\glm\zcode.cjs"
& $ZCodeExe $cli plugins uninstall dsh-purge@zcode-purge --force
& $ZCodeExe $cli plugins marketplace remove zcode-purge
Write-Host "Uninstalled."