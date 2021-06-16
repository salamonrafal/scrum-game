Write-Output "1.) STOP CONTAINER"
nestjs-docker -arg_action stop -arg_env development
Write-Output "2.) DELETE CONTAINER"
nestjs-docker -arg_action delete_container -arg_env development
Write-Output "3.) BUILD IMAGE"
nestjs-docker -arg_action build -arg_env development
Write-Output "4.) CREATE CONTAINER"
nestjs-docker -arg_action create_container -arg_env development

[console]::beep(500,300)