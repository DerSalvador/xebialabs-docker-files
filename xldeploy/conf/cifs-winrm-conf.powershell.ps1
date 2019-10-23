PS C:\Windows\System32> type  .\enableWinRM.ps1
net user administrator /active:yes
Set-SmbServerConfiguration -EnableSMB2Protocol $true
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
Set-ExecutionPolicy Unrestricted
Enable-PSRemoting -SkipNetworkProfileCheck -Force                                                                       
Set-NetConnectionProfile -NetworkCategory Private
Get-NetConnectionProfile
ipconfig
winrm quickconfig
winrm set winrm/config/service/Auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}'
pause

