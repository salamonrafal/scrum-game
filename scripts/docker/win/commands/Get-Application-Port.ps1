function Get-Application-Port
{
<#
.SYNOPSIS
Command display port used to run application

.DESCRIPTION

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    Write-Verbose -Message "Show docker container ports"

    $ports = Get-Application-Ports

    Write-Host ($ports["host"], $ports["container"]) -Separator ":" -ForegroundColor DarkGreen
}
