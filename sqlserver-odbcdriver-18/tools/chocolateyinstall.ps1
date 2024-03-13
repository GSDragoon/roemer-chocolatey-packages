﻿$packageName = 'sqlserver-odbcdriver-18'
$installerType = 'msi'
$silentArgs= '/qn /norestart IACCEPTMSODBCSQLLICENSETERMS=YES'
$url = '{link32}'
$url64 = '{link64}'
$checksumType = 'sha256'
$checksum = '{checksum32}'
$checksum64 = '{checksum64}'

$32DllPath = Join-Path -Path $Env:SystemRoot -ChildPath (Join-Path -Path 'system32' -ChildPath 'msodbcsql18.dll')
$64DllPath = Join-Path -Path $Env:SystemRoot -ChildPath (Join-Path -Path 'syswow64' -ChildPath 'msodbcsql18.dll')
$32BitNeeded = ([Version]$(Get-ItemProperty -Path $32DllPath -ErrorAction:Ignore).VersionInfo.ProductVersion) -lt [Version]$Env:ChocolateyPackageVersion  
$64BitNeeded = ([Version]$(Get-ItemProperty -Path $64DllPath -ErrorAction:Ignore).VersionInfo.ProductVersion) -lt [Version]$Env:ChocolateyPackageVersion

$updateNeeded = ($32BitNeeded -or $64BitNeeded -or $Env:ChocolateyForce)
if ($updateNeeded)
{
    Install-ChocolateyPackage -PackageName "$packageName" `
        -FileType "$installerType" `
        -SilentArgs "$silentArgs" `
        -Url "$url" `
        -Url64bit "$url64" `
        -ValidExitCodes @(0) `
        -Checksum "$checksum" `
        -ChecksumType "$checksumType" `
        -Checksum64 "$checksum64" `
        -ChecksumType64 "$checksumType";
}
