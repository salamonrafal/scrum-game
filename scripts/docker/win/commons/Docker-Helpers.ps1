function Get-Package-JSON
{
<#
.SYNOPSIS
Load & return object from package.json project

.DESCRIPTION


.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    return Get-Content -Path "$current_location\package.json" -Raw | ConvertFrom-Json
}

function Get-Application-Ports
{
<#
.SYNOPSIS
Get application ports

.DESCRIPTION

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    $json = Get-Package-JSON
    $ports = @{host = $json.docker.ports[0]; container = $json.docker.ports[1]}

    return $ports
}

function Get-Container-Name
{
<#
.SYNOPSIS
Get container name deepend on emvironment

.DESCRIPTION

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    param (
        [string] $arg_env
    )

    $json = Get-Package-JSON

    return "$($json.docker.containerName)-$($arg_env)"
}

function Get-Application-Version
{
<#
.SYNOPSIS
Get application version from package.json

.DESCRIPTION

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    $json = Get-Package-JSON

    return $json.version
}

function Get-Application-Name
{
<#
.SYNOPSIS
Get application name from package.json

.DESCRIPTION

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    $json = Get-Package-JSON

    return $json.name
}

function Set-Image-Name
{
<#
.SYNOPSIS
Create image name deepend on environment

.DESCRIPTION


.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    param (
        [string] $arg_env
    )

    $service_name = Get-Application-Name
    $service_version = Get-Application-Version

    return $service_name + "-" + $arg_env + ":" + $service_version
}
