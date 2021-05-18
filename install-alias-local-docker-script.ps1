[CmdletBinding()]
param()

$name = "nestjs-docker"
$current_location = Get-Location
$aliasInfo = Get-Alias -Name $name


if ($aliasInfo.length -eq 0) {
    Set-Alias `
        -Scope Global `
        -Name $name `
        -Value "$current_location\scripts\docker\win\Docker.ps1" `
        -Description "Alias for script to manage docker for nestjs services"

    Write-Output "Success installed"
} else {
    Remove-Item "Alias:$name"

    Set-Alias `
        -Scope Global `
        -Name $name `
        -Value "$current_location\scripts\docker\win\Docker.ps1" `
        -Description "Alias for script to manage docker for nestjs services"

    Write-Output "Success updated"
}

