# .\PortScanner.ps1 192.168.4 22
$network = $args[0]
$port = $args[1]
# $range = 1..254
$ErrorActionPreference= 'silentlycontinue'

(1..254|ForEach-Object {
    $ip = "{0}.{1}" -F $network,$_
    Write-Progress "Scanning Network" $ip -PercentComplete (($_/254)*100)
    if(Test-Connection -BufferSize 32 -Count 1 -quiet -ComputerName $ip){ 
        $socket = New-Object System.Net.Sockets.TcpClient($ip, $port)
        if($socket.Connected) { 
            "http://{0}:{1}" -F $ip, $port
            $socket.Close() 
        }
    }
}) | Out-Gridview -Title PortScanner
