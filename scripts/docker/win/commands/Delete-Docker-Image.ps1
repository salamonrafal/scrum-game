function Delete-Docker-Image
{
<#
.SYNOPSIS
Command delete docker image

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
    $cmdTemplate = "docker image rm {image}"

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
