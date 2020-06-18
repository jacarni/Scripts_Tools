#Message and imputvsubnet var
$Sebnet = Read-Host  'Please Insert 3 octed of the Subnet, Example 192.168.9'
$Start  = Read-Host  'Scan Start on IP_Host'
$End  = Read-Host  'Scan End on IP_Host'


# Crete directory if this no exist
if(!(Test-Path -path "c:\Scan_Net" )) {  New-Item -ItemType directory -Path "c:\Scan_Net"}


 #Result File Name, it just save that are online
 $Datetime = Get-Date -UFormat "%y-%m-%d-%H-%l-%S"
 $fileName = "Scan_Result_$Datetime.csv"
 $log ="C:\Scan_Net\$fileName"
#confirm si file exist
if(!(Test-Path -path "$log" )) {  New-Item "$log" -ItemType File 
Set-Content $log 'Host_IP,Status'
}

#set var as object  to simplify
$ping = New-Object System.Net.NetworkInformation.Ping
  
 #code 
 $Start..$End | % { If ($ping.Send("$Sebnet.$_").Status -eq 'Success') 
    {Write-Host -Message "$Sebnet.$_ Success" -ForegroundColor Green 
     Add-Content -LiteralPath  $log  -Value "$Sebnet.$_,Success" }
    ElseIf ($ping.Send("$Sebnet.$_").Status -eq 'TimeOut')
    {Write-Host -Message "$Sebnet.$_ Timed out" -ForegroundColor Red
    Add-Content -LiteralPath  $log  -Value "$Sebnet.$_,Timed ou" }
    Else{Write-Warning -Message "$Sebnet.$_ host unreachable or  doesn't  not exist"
    Add-Content -LiteralPath  $log  -Value "$Sebnet.$_, host unreachable or  doesn't  not exist" }
}
