$current_location = Get-Location

function Get-Script-Config-JSON
{
<#
.SYNOPSIS
Get configuration for docker script

.DESCRIPTION
This function load content JSON file and serilized output to PSObject.

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE
$config = Get-Script-Config-JSON
$config.actions

#>
    return Get-Content -Path "$current_location\scripts\docker\win\config.json" -Raw | ConvertFrom-Json
}

function Get-Action-List
{
<#
.SYNOPSIS
Get list of actions avalible for manage application

.DESCRIPTION
This function return PSObject with all actions avalible for docker script managment

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE
$actions = Get-Action-List
$actions.PSObject.Properties

#>
    $json = Get-Script-Config-JSON

    return $json.actions
}

function Get-Default-Action
{
<#
.SYNOPSIS
Get default action

.DESCRIPTION
This function return string wich represents default action

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE
$defaultActions = Get-Default-Action
$defaultActions

#>
    $json = Get-Script-Config-JSON

    return $json.defaultAction
}

function Get-Action-Config
{
<#
.SYNOPSIS
Get configurationfor specific action

.DESCRIPTION
This function return PSObject with configuration for action.

.PARAMETER $arg_action
Name of action

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE
$action = Get-Action-Config -arg_action help
$action.script

#>
    param(
        [string] $arg_action
    )

    $actions = Get-Action-List

    foreach ($obj in $actions.PSObject.Properties)
    {
        if ($obj.Name -eq $arg_action) {
            return $obj.Value
        }
    }

    return $FALSE
}

function Join-Command-Action-Parameter
{
<#
.SYNOPSIS
Create executable command

.DESCRIPTION
This function return string which represents command to execute

.PARAMETER $arg_cmd_template
Command template

.PARAMETER $arg_params_name
List of names of variables

.PARAMETER $arg_param_value
List of values

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE
$command = Join-Command-Action-Parameter
    -arg_cmd_template "New-Docker-Image -arg_env {arg_env}"
    -arg_params_name "arg_env"
    -arg_param_value "production"

$command

#>
    param (
        [string] $arg_cmd_template,
        [string[]] $arg_params_name,
        [string[]] $arg_param_value
    )

    $cmd = $arg_cmd_template

    for ($i= 0; $i -lt $arg_params_name.length; $i++) {
        $name = "{" + $arg_params_name[$i] + "}"
        $value = $arg_param_value[$i]
        $value = $value -replace """",""""""
        $cmd = $cmd -replace $name,$value
    }

    return $cmd
}

function Run-Command-Action
{
<#
.SYNOPSIS
Run action command

.DESCRIPTION
This function execute comand base on config.json

.PARAMETER $arg_action
Action name

.PARAMETER $arg_env
Environment

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE
Run-Command-Action
    -arg_action "help"
    -arg_env "production"

#>
    param (
        [string] $arg_action,
        [string] $arg_env,
        [string[]] $arg_params
    )

    $action = Get-Action-Config -arg_action $arg_action


    if ($action -eq $FALSE) {
        $defaultAction = Get-Default-Action
        $action = Get-Action-Config -arg_action $defaultAction
        $command = Join-Command-Action-Parameter -arg_cmd_template $action.script
    } else {
        $paramsValues = [System.Collections.ArrayList]::new()
        $in = $paramsValues.Add($arg_env)

        for ($i= 0; $i -lt $arg_params.length; $i++) {
            $in = $paramsValues.Add($arg_params[$i])
        }

        $command = Join-Command-Action-Parameter -arg_cmd_template $action.script -arg_params_name $action.args -arg_param_value $paramsValues
    }

    Write-Verbose -Message "Run command: $command"
    Invoke-Expression $command
}
