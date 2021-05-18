function Get-Action-Help-Message
{
<#
.SYNOPSIS
Command display help message

.DESCRIPTION

.PARAMETER

.NOTES
Author: Rafal Salamon <rasa@salamonrafal.pl>

.EXAMPLE

#>
    $actions =  Get-Action-List

    foreach ($action in $actions.PSObject.Properties)
    {
        $name = $action.Name
        $value = $action.Value
        $params = ""

        "---------------------------------------- "
        ""
        " Action: " + $name
        ""

        "   -arg_action " + $name
        for ($i = 0; $i -lt $value.args.length; $i++)
        {

            if ($i -eq 0)
            {
                "   -arg_env " + $value.args[$i]
            } else {
                $params += $value.args[$i] + ","
            }
        }

        if ($params -ne "")
        {
            "   -arg_params " + $params
        }

        ""
        "---------------------------------------- "
        ""
    }
}
