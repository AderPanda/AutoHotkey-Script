;-------------------------------------------------------------------------------
;~ �������������a
;-------------------------------------------------------------------------------
#SingleInstance FORCE	;�������ű��Ѿ�����ʱ�Ƿ��������ٴ�����,�ǵ���force���������ű�reloadʱ���ӽű�Ҳ�Զ�reload��
SetTitleMatchMode Regex	;���Ľ���ƥ��ģʽΪ����
#Persistent				;�������в��˳�
#NoTrayIcon				;��������ͼ��
SendMode Input			;����Send���ͳһ��������SendInput

#Include %A_LineFile%\..\..\Functions\appStarter ����������\appStarter.ahk

appStarter("#c", "cmd")
appStarter("!#c", "cmd")
appStarter("#f", "d:\TechnicalSupport\ProgramFiles\Firefox-pcxFirefox\firefox\firefox.exe")
appStarter("#g", "D:\TechnicalSupport\ProgramFiles\CentBrowser\chrome.exe")
appStarter("#n", "notepad")
appStarter("#z", "d:\TechnicalSupport\ProgramFiles\AutoHotkey\SciTE\SciTE.exe")
appStarter("#e", "D:\TechnicalSupport\ProgramFiles\Evernote\Evernote\Evernote.exe")
appStarter(">!m", "D:\TechnicalSupport\Sandbox\LL\1LongAndTrust\drive\D\TechnicalSupport\Users\LL\AppData\Roaming\Spotify\Spotify.exe")
appStarter("#y", "D:\Dropbox\Technical_Backup\ProgramFiles.Untrust\YodaoDict\YodaoDict.exe")
appStarter("#s", "����pdg")
appStarter("#t", "����TotalCommander")
appStarter("#k", "shell:::{ED7BA470-8E54-465E-825C-99712043E01C}", "�����������")
appStarter("#h", "shell:::{645FF040-5081-101B-9F08-00AA002F954E}", "����վ")
appStarter("#g", "¼��gif")
appStarter("#s", "d:\Dropbox\Technical_Backup\ProgramFiles.Untrust\ColorPic 4.1  ��ĻȡɫС��� ��ɫ ɫ�� ��ɫ\#ColorPic.exe")
appStarter("#j", "D:\Dropbox\Technical_Backup\ProgramFiles.Untrust\HourglassPortable ����ʱС���� ��ʱ�� ʱ��\HourglassPortable ��ʱ�� ����ʱ.exe")
appStarter("#u", "D:\Dropbox\Technical_Backup\ProgramFiles.Trust\UltraEdit v22.20.0.49(x32)\ultraedit.lnk")

return

����pdg:
	Run, "d:\Dropbox\Technical_Backup\ProgramFiles.Trust\#Book Tools\Sx_Renamer\Sx_Renamer.exe"
	Run, "d:\Dropbox\Technical_Backup\ProgramFiles.Trust\#Book Tools\Pdg2Pic\Pdg2Pic.exe"
	return
����TotalCommander:
	if WinExist("ahk_class TTOTAL_CMD") {
		WinClose
	}
	WinWaitClose, ahk_class TTOTAL_CMD, , 2
	Sleep, 500
	Run, "d:\TechnicalSupport\ProgramFiles\Total Commander 8.51a\TOTALCMD.EXE"
	WinWait, ahk_class TNASTYNAGSCREEN				;�Զ���123
	WinGetText, Content, ahk_class TNASTYNAGSCREEN	;��ȡδע����ʾ�����ı���Ϣ
	StringMid, Num, Content, 10, 1					;��ȡ�������
	ControlSend,, %Num%, ahk_class TNASTYNAGSCREEN	;��������ַ��͵�δע����ʾ����
	WinActivate, ahk_class TTOTAL_CMD
	return
¼��gif:
	Run "D:\Dropbox\Technical_Backup\ProgramFiles.Untrust\keycastow ��ʾ����������¼����Ļʱ������\keycastow.exe"
	Run "d:\Dropbox\Technical_Backup\ProgramFiles.Untrust\#Repository\ScreenToGif 1.4.1 ��Ļ¼��gif\$$ScreenToGif 2.5.exe"
	return
