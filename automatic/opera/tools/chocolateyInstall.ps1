﻿$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/56.0.3051.104/win/Opera_56.0.3051.104_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/56.0.3051.104/win/Opera_56.0.3051.104_Setup_x64.exe'
  checksum       = '071c6c37137fb454418ce02e1b94060b6dc193e8803c8a6e79259c0fc2808507'
  checksum64     = '70d5f4de522f07aa1bb221efa7cb3a033016f7ac4eee5ccec2387cb703e653f4'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '56.0.3051.104'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
