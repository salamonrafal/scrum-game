[CmdletBinding()]
param()

$name = "nestjs-docker"
$current_location = Get-Location

try {
    $aliasInfo = Get-Alias -Name $name

    Remove-Item "Alias:$name"

    Set-Alias `
        -Scope Global `
        -Name $name `
        -Value "$current_location\scripts\docker\win\Docker.ps1" `
        -Description "Alias for script to manage docker for nestjs services"

    Write-Output "Success updated"
} catch {
    Set-Alias `
        -Scope Global `
        -Name $name `
        -Value "$current_location\scripts\docker\win\Docker.ps1" `
        -Description "Alias for script to manage docker for nestjs services"

    Write-Output "Success installed"
}

