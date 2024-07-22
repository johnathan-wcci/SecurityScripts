Get-NetTCPConnection -AppliedSetting Internet | SELECT remote*,state,@{
    Name="Process";Expression={
        (Get-Process -Id $_.OwningProcess).ProcessName
    }},
    @{Name="WhoIs";Expression={
        Start-Sleep 2 # Rate Throttling
        $metadata = @{}
        $data = ((Invoke-WebRequest -Uri "http://ip-api.com/json/$($_.RemoteAddress)").Content | ConvertFrom-Json)
        $metadata.add( "Owner", $data.org )
        $metadata.add( "ISP", $data.isp )
        $metadata.add( "City", $data.city )
        $metadata.add( "State", $data.regionName )
        $metadata.add( "Country", $data.country )
        $metadata | ConvertTo-Json
    }},
    @{Name="VirusTotalScore";Expression={
        Start-Sleep 2 # Rate Throttling
        ((Invoke-WebRequest -Uri "https://www.virustotal.com/api/v3/ip_addresses/$($_.RemoteAddress)" -Headers @{'x-apikey' = $Env:VTApiKey}).Content | ConvertFrom-Json).data.attributes.reputation
    }}| Out-Gridview -Title Connections
