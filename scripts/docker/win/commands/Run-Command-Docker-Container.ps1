function Run-Command-Docker-Container
{
<#
.SYNOPSIS
Command create execute bash command on container

.DESCRIPTION

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    param(
        [Parameter(Mandatory=$true)][string] $arg_env,
        [Parameter(Mandatory=$false)][string] $arg_command
    )

    $ports = Get-Application-Ports
    $image_name = Set-Image-Name -arg_env $arg_env
    $container_name = Get-Container-Name -arg_env $arg_env
    $cmdTemplate = "docker exec -it -d {name} {command}"

    $cmd = Join-Command-Action-Parameter `
        -arg_cmd_template $cmdTemplate `
        -arg_params_name `
            "ports",`
            "image",`
            "name", `
            "command" `
        -arg_param_value `
            "$($ports.host):$($ports.container)",`
            $image_name, `
            $container_name, `
            $arg_command `

    $cmd

    Write-Verbose -Message "Run command: $cmd"
    Invoke-Expression $cmd
}
