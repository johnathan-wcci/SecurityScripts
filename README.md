# SecurityScripts
Just some PowerShell and Bash Security Scripts

## Script: FileIntegrity
### Decription: 
Validates the checksum has of a given file. 
### How To Run:
`.\FileIntegrity.ps1 <CheckSum Algorithm> <File Checksum> <File Path>`

## Script: GetConnections
### Decription: 
Provides additional metadata for all Network Connections.
### How To Run:
`.\GetConnections.ps1`
### Additional Information:
This script requires you have a VirusTotal API key and it should be set in your Environment Variables as `VTApiKey`

## Script: NetworkScanner
### Decription:
Gathers Online IP Addresses on Local Network and provides information to identify them.
### How To Run:
`.\NetworkScanner.ps1 <IP Address excluding Host ID>`

**Example**: `.\NetworkScanner.ps1 192.168.1`

## Script: PortScanner
### Decription:
Find specified open ports on a Local network
### How To Run:
`.\PortScanner.ps1 <IP Address excluding Host ID> <Port>`

**Example**: `.\PortScanner.ps1 192.168.1 22`

## Notes:
I have not signed these scripts. You will need to modify your PowerShell Execution Policy to run them. [More Information Here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.4)

Set Local Machine Execution Policy To Unrestricted: `Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine`

Set Local Machine Execution Policy Back To Restricted: `Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope LocalMachine`

**Please Set Your Execution Policy Back To Undefined or Restricted When Finished Running Scripts**
