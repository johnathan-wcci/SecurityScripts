# .\NetworkScanner.ps1 192.168.4
## Ping subnet
$Subnet = $args[0]
$ErrorActionPreference= 'silentlycontinue'
1..254|ForEach-Object{
    Write-Progress "Looking for Devices on Network..." "{0}.{1}" -F $SubNet,$_  -PercentComplete (($_/254)*100)
    Start-Process -WindowStyle Hidden ping.exe -Argumentlist "-n 1 -l 0 -f -i 2 -w 1 -4 {0}.{1}" -F $SubNet,$_
}
$Computers =(arp.exe -a | Select-String "$SubNet.*dynam") -replace ' +',','|
  ConvertFrom-Csv -Header ComputerName,IPv4,MAC,x,Vendor,ResponseTime|
                   Select ComputerName,IPv4,MAC,Vendor,ResponseTime

ForEach ($Computer in $Computers){
  Write-Progress "Gathering Network Information..." $Computer.IPv4 -PercentComplete (($Computers.IndexOf($Computer)/$Computers.Count)*100)
  Start-Sleep 2 # Rate Throttling
  $Computer.ResponseTime = (Test-Connection -ComputerName $Computer.IPv4 -count 4 | Measure-Object -Property ResponseTime -Average).Average
  # This Doesn't Work Locally
  # nslookup $Computer.IPv4|Select-String -Pattern "^Name:\s+([^\.]+).*$"|
  #   ForEach-Object{
  #     $Computer.ComputerName = $_.Matches.Groups[1].Value
  #   }
  $vendor = Invoke-WebRequest -Uri "https://api.maclookup.app/v2/macs/$($Computer.MAC)"
  ForEach-Object{
      $Computer.Vendor = ($vendor.Content | ConvertFrom-Json).company
  }
}
$Computers | Out-Gridview