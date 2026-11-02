# dsh-purge -> ZCode install script (PowerShell 5.1+)
# usage: powershell -ExecutionPolicy Bypass -File scripts/install.ps1 [-ZCodeExe F:\ZCode\ZCode.exe]
param([string]$ZCodeExe = "F:\ZCode\ZCode.exe")
$ErrorActionPreference = "Stop"
$env:ELECTRON_RUN_AS_NODE = "1"
$cli = Join-Path (Split-Path $ZCodeExe) "resources\glm\zcode.cjs"
$here = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path $cli)) { Write-Error "ZCode CLI not found: $cli (pass -ZCodeExe)" }
& $ZCodeExe $cli plugins validate "$here\plugins\dsh-purge"
& $ZCodeExe $cli plugins marketplace add $here
& $ZCodeExe $cli plugins install dsh-purge@zcode-purge
& $ZCodeExe $cli plugins enable dsh-purge@zcode-purge
& $ZCodeExe $cli plugins list | Select-String -Pattern "dsh-purge@" -Context 0,2
Write-Host "Done. Restart ZCode to take effect."