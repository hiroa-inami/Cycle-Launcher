$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
$VbsPath = Join-Path -Path $ScriptPath -ChildPath "startup_Cycle-Launcher.vbs"

$taskname = "Startup Cycle Launcher"
$taskdescription = "Start Cycle Launcher on logon with highest privilege"
$action = New-ScheduledTaskAction -Execute $VbsPath
$trigger =  New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -RunLevel Highest
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskname -Description $taskdescription -Principal $principal -User "System"