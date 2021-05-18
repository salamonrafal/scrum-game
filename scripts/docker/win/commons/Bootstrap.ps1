function Run-Bootstrap
{
<#
.SYNOPSIS
Bootstrap function

.DESCRIPTION
Inizilize and setup script

.PARAMETER $arg_root_dir
Relative path to main directory contain docker script

.PARAMETER $arg_param_action
Action name to run

.PARAMETER $arg_param_env
Environment

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE
Run-Bootstrap
    -arg_param_action $(Get-Location)
    -arg_param_action "help"
    -arg_param_env "production"
    -arg_params "test","test"

#>
    param (
        [string] $arg_root_dir,
        [string] $arg_param_action,
        [string] $arg_param_env,
        [string[]] $arg_params
    )

    $root_dir_script = "$($arg_root_dir)\scripts\docker\win"
    $root_commands_dir = "$($root_dir_script)\commands"

    . "$($root_dir_script)\commons\Docker-Helpers.ps1"
    . "$($root_dir_script)\commons\Scripts-Functions.ps1"

    $command_files = Get-ChildItem `
        -Path  $root_commands_dir `
        -Name `
        -File

    foreach($command_filename in $command_files) {
        $command_filepath = "$($root_commands_dir)\$($command_filename)"
        . $command_filepath
    }

    Run-Command-Action `
        -arg_action $arg_param_action `
        -arg_env $arg_param_env `
        -arg_params $arg_params
}
