[CmdletBinding()]
param(
    [string] $arg_action,
    [string] $arg_env,
    [string[]] $arg_params
)

$current_location = Get-Location

. "$current_location\scripts\docker\win\commons\Bootstrap.ps1"

Run-Bootstrap `
    -arg_root_dir $current_location `
    -arg_param_action $arg_action `
    -arg_param_env $arg_env `
    -arg_params $arg_params `
