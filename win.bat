@Rem 20180116 ���֡����ò���ȷ����WSUS���������ò���Ч����Ӳ���ע������ã�������������Ч������������ﻹ����ʾδ���ã���δ�ҵ�ԭ��
@Rem 20180122 �ڡ���ȷ����WSUS������������һ�����ã��������ѵ�¼�û��ļ�������ƻ����Զ����°�װ��ִ������������
@Rem 20180208 ���¹�������Բ���ʾ�Զ�����������õĽ��ͣ�����Ե��޸Ľ���ᱣ���������ط���1. ע���  2. �������ʷ�ļ���C:\WINDOWS\system32\GroupPolicy\Machine\Registry)ע�����Ľ���Ǹ�Ӧ�ö����ȡ����Ч�ģ��������ʷ�ļ�������Զ�ȡ�ģ�ֻ������Ե�״̬��¼���������������ʾ��δ���á���
@Rem 20180614 ע�͡�����DHCP Client���񡱣�Server 2012��Network Location Awareness�����DHCP Client���������ϵ������DHCP����ᵼ����������ʧЧ
@Rem 20190711 ���ò������룬���NTP����

@echo off
title Windows ��ȫ�ӹ̽ű�

echo [Unicode]>win.inf
echo Unicode=yes>>win.inf
echo [System Access]>>win.inf

for /f "delims=" %%i in ('type "win.ini"^| find /i "="') do set %%i

@Rem �������븴�ӶȲ���
echo **** �������븴�ӶȲ���
echo PasswordComplexity = 1 >>win.inf

@Rem �������볤����СֵΪminlen
echo **** �������볤����СֵΪminlen
echo MinimumPasswordLength = %minlen% >>win.inf

@Rem ���Ĺ���Ա�˻�����Ϊadmin
echo **** ���Ĺ���Ա�ʻ�����Ϊadmin_name
echo NewAdministratorName = "%admin_name%" >>win.inf

@Rem �����ʻ�������ֵΪdeny
echo **** �����ʻ�������ֵΪdeny
echo LockoutBadCount = %deny%>>win.inf

@Rem ���á�ǿ��������ʷ��
echo **** ��סN����ʹ�õ�����
echo PasswordHistorySize = %remember% >>win.inf
echo=

@Rem ɾ������ø�Σ�˻�
echo **** ����Guest�û�
echo EnableGuestAccount = 0 >>win.inf
echo=

@Rem ���á���λ�ʻ�������������ʱ��
echo **** 5���Ӻ������ʻ�����������
echo ResetLockoutCount = 5 >>win.inf
echo=

@Rem �����ʻ�����ʱ��
echo **** �����ʻ�����ʱ��Ϊ5����
echo LockoutDuration = 5 >>win.inf
echo=

@Rem ���������ʹ�����ޣ���ѡ,ȱʡ�����ã�
echo **** ����180��������루��ѡ��
echo MaximumPasswordAge = %PASS_MAX_DAYS% >>win.inf
echo=

echo [Event Audit]>>win.inf
@Rem ������־��˲���
echo **** ������־��˲���
echo AuditSystemEvents = 3 >>win.inf
echo AuditLogonEvents = 3 >>win.inf
echo AuditObjectAccess = 3 >>win.inf
echo AuditPrivilegeUse = 3 >>win.inf
echo AuditPolicyChange = 3 >>win.inf
echo AuditAccountManage = 3 >>win.inf
echo AuditProcessTracking = 3 >>win.inf
echo AuditDSAccess = 3 >>win.inf
echo AuditAccountLogon = 3 >>win.inf
echo=

@Rem ��ȷ����Windows��־
echo **** ��ȷ����Windows��־������־�ļ�����128Mʱ���踲���¼���
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\System" /v MaxSize /t REG_DWORD /d 0x8000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\System" /v Retention /t REG_DWORD /d 0x00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Application" /v MaxSize /t REG_DWORD /d 0x8000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Application" /v Retention /t REG_DWORD /d 0x00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security" /v MaxSize /t REG_DWORD /d 0x8000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security" /v Retention /t REG_DWORD /d 0x00000000 /f
echo=

echo [Privilege Rights]>>win.inf
@Rem ���ƿɹر�ϵͳ���ʻ�����
echo **** ���ý���Administrators���û���ɹر�ϵͳ
echo SeShutdownPrivilege = *S-1-5-32-544 >>win.inf
echo=

@Rem ���ƿɴ�Զ�˹ر�ϵͳ���ʻ�����
echo **** ���ý���Administrators���û���ɴ�Զ�˹ر�ϵͳ
echo SeRemoteShutdownPrivilege = *S-1-5-32-544 >>win.inf
echo=

@Rem ���ơ�ȡ���ļ����������������Ȩ�����ʻ�����
echo **** ���ý���Administrators���û����ȡ���ļ����������������Ȩ
echo SeTakeOwnershipPrivilege = *S-1-5-32-544 >>win.inf
echo=

@Rem ���á������ص�¼������
echo **** ���ý���Administrators���͡�Users���û���ɱ��ص�¼
echo SeInteractiveLogonRight = *S-1-5-32-544,*S-1-5-32-545 >>win.inf
echo=

@Rem ���á���������ʴ˼����������
echo **** ���ý���Administrators���͡�Users���û���ɴ�������ʴ˼����
echo SeNetworkLogonRight = *S-1-5-32-544,*S-1-5-32-545 >>win.inf
echo=

@Rem ɾ�����������ʵĹ���������ܵ�
echo **** �����������: ���������ʵĹ��������������: ���������ʵ������ܵ���������Ϊ��
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v NullSessionShares /t REG_MULTI_SZ /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v NullSessionPipes /t REG_MULTI_SZ /f
echo=

@Rem ���������û�����
echo **** �����������: ������ SAM �ʻ��͹��������ö�١������������: ������ SAM �ʻ�������ö�١�������Ϊ�����á�
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymoussam /t REG_DWORD /d 0x00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymous /t REG_DWORD /d 0x00000001 /f
echo=

@Rem ����SNMP�����Ĭ��public���壨���Ȱ�װSNMP�����Զ���password��IP��
echo **** �޸�SNMP������Ϊ��SNMP_password��ָ�������SNMP_IP
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" /v %SNMP_password% /t REG_DWORD /d 0x00000004 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" /v 1 /t REG_SZ /d %SNMP_ip% /f
echo=

@Rem �ر�Windows�Զ�����
echo **** ���á��ر��Զ����Ų��ԡ��Ҷ�������������Ч
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 0x000000ff /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 0x000000ff /f
echo=

@Rem ��ֹWindows�Զ���¼
echo **** ��ֹWindows�Զ���¼
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f
echo=

@Rem ��ȷ���á������Ựʱ��ʾ�û���Ϣ������
echo **** ���������Ựʱ����ʾ�û���Ϣ
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DontDisplayLockedUserId /t REG_DWORD /d 0x00000003 /f
echo=

@Rem ��ȷ���á���ʾ�û����������֮ǰ���и��ġ�����
echo **** �������������ǰ14����ʾ��������
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v PasswordExpiryWarning /t REG_DWORD /d 0x0000000e /f
echo=

@Rem ����Windows����Ĭ�Ϲ���
echo **** ɾ��������Windows����Ĭ�Ϲ���
for /f "tokens=1 delims= " %%i in ('net share') do (
net share %%i /del ) >nul 2>nul
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters" /v AutoShareServer /t REG_DWORD /d 0x00000000 /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters" /v AutoShareWks /t REG_DWORD /d 0x00000000 /f
echo=

@Rem �����ļ��е�Ȩ�����ã�����ά��Ա�ο���
echo **** �������ļ����С�Everyone(�κ���)��Ȩ��ɾ��
for /f "tokens=2" %%i in ('net share') do (
cacls %%i /r "everyone" /e ) >nul 2>nul
echo=

@Rem ����Windows����ִ�б���(DEP)
echo **** ���ý�Ϊ����Windows����ͷ�������DEP
@Rem Server 2008:
bcdedit /set nx OptIn
@Rem Server 2003:
@Rem /noexecute=optin
echo=

@Rem ���á�����ʾ����û���������
echo **** ���õ�¼��Ļ�ϲ�Ҫ��ʾ�ϴε�¼���û���
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Currentversion\Policies\System" /v DontDisplayLastUserName /t REG_DWORD /d 0x00000001 /f
echo=

@Rem ���ò���ȷ����WSUS���Զ���WSUS��ַ��
echo **** ���ò���ȷ����WSUS���Զ����ز�֪ͨ��װ��
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 0x00000003 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 0x00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0x00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v ScheduledInstallDay /t REG_DWORD /d 0x00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v ScheduledInstallTime /t REG_DWORD /d 0x00000003 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v UseWUServer /t REG_DWORD /d 0x00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v WUServer /t REG_SZ /d %WSUS_ip% /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v WUStatusServer /t REG_SZ /d %WSUS_ip% /f
echo=

@Rem ���ò���ȷ����NTP���Զ���NTP��ַ��
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\Parameters" /v NtpServer /t REG_SZ /d %NTP_ip%,0x9 /f
w32tm /config /manualpeerlist:"%NTP_ip%" /syncfromflags:manual /update
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\TimeProviders\NtpServer" /v Enabled /t REG_DWORD /d 0x00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\Config" /v AnnounceFlags /t REG_DWORD /d 0x00000005 /f
sc config "W32Time" start= delayed-auto >nul 2>nul
netsh firewall add portopening protocol = UDP port =123 name = NTPSERVER >nul 2>nul
net start w32time >nul 2>nul || net stop w32time >nul 2>nul && net start w32time >nul 2>nul && w32tm /resync >nul 2>nul
w32tm /resync >nul 2>nul
echo=

@Rem ���ò���ȷ������Ļ��������
echo **** ������Ļ�������򣬵ȴ�ʱ��Ϊ10���ӣ��������ڻָ�ʱ��Ҫ���뱣��
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d C:\Windows\system32\scrnsave.scr /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverIsSecure /t REG_SZ /d 1 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveTimeOut /t REG_SZ /d %TMOUT% /f
echo=

@Rem ���á���¼ʱ���밴 Ctrl+Alt+Del������
echo **** ������ʽ��¼: ����(����Ҫ)�� Ctrl+Alt+Del��������Ϊ���ѽ���(ͣ��)��
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Currentversion\Policies\System" /v disablecad /t REG_DWORD /d 0x00000000 /f
echo=

@Rem ���ò���Ҫ�ķ���
echo **** �������·���Windows Internet Name Service (WINS)��Remote Access Connection Manager��Simple TCP/IP Services��Simple Mail Transport Protocol (SMTP) ��DHCP Client��DHCP Server��Message Queuing
wmic service where name="SimpTcp" call stopservice >nul 2>nul
sc config "SimpTcp" start= disabled >nul 2>nul
wmic service where name="SMTPSVC" call stopservice >nul 2>nul
sc config "SMTPSVC" start= disabled >nul 2>nul
wmic service where name="WINS" call stopservice >nul 2>nul
sc config "WINS" start= disabled >nul 2>nul
wmic service where name="RasMan" call stopservice >nul 2>nul
sc config "RasMan" start= disabled >nul 2>nul
wmic service where name="DHCPServer" call stopservice >nul 2>nul
sc config "DHCPServer" start= disabled >nul 2>nul
@Rem wmic service where name="DHCP" call stopservice >nul 2>nul
@Rem sc config "DHCP" start= disabled >nul 2>nul
wmic service where name="MSMQ" call stopservice >nul 2>nul
sc config "MSMQ" start= disabled >nul 2>nul
echo=

@Rem ��װ���²������Ͳ���
echo **** ����Ƿ�װ����
wmic qfe get hotfixid >nul 2>nul || echo ��δ��װ�������밲װ��
echo=

@Rem ���á��û��´ε�¼ʱ��������롱
echo **** ����administrator��admin���û��´ε�¼�����������
net user Administrator /logonpasswordchg:yes >nul 2>nul
net user %admin_name% /logonpasswordchg:yes >nul 2>nul
echo=

echo [Version]>>win.inf
echo signature="$CHICAGO$">>win.inf
echo Revision=1 >>win.inf

secedit /configure /db win.sdb /cfg win.inf
del win.inf /q
del win.sdb /q

echo=
echo=
echo=
echo=
echo ��������ɣ�������������ϵͳ����Ч��
echo=
echo=
echo=
echo=
echo ��������˳�
pause
goto exit