$name     = "commands"
$commands = "$PSScriptRoot\$name.txt" #create text file
ni -ItemType file $commands -Force
ac $commands "#Paste your each command in a new line"
Start-Process $commands