' Use Task scheduler to run on login
' Don't forget to check "highest privileges" on creating task's general tab

Set WshShell = CreateObject("WScript.Shell") 
scriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
WshShell.CurrentDirectory = scriptDir

WScript.Sleep 5000 ' ahk script need to wait for registering system try icon
WshShell.Run ".\Cycle-Launcher.ahk"
