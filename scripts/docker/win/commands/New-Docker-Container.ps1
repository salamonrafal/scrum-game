function New-Docker-Container
{
<#
.SYNOPSIS
Command create new docker container

.DESCRIPTION

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    param(
        [string] $arg_env
    )

    $ports = Get-Application-Ports
    $image_name = Set-Image-Name -arg_env $arg_env
    $container_name = Get-Container-Name -arg_env $arg_env
    $cmdTemplate = "docker container create -p {ports} --name {name} {image}"

    $cmd = Join-Command-Action-Parameter `
        -arg_cmd_template $cmdTemplate `
        -arg_params_name `
            "ports",`
            "image",`
            "name" `
        -arg_param_value `
            "$($ports.host):$($ports.container)",`
            $image_name, `
            $container_name

    Write-Verbose -Message "Run command: $cmd"
    Invoke-Expression $cmd
}
