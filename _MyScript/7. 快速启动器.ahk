;-------------------------------------------------------------------------------
;~ �������������a
;-------------------------------------------------------------------------------
#SingleInstance FORCE	;�������ű��Ѿ�����ʱ�Ƿ��������ٴ�����,�ǵ���force���������ű�reloadʱ���ӽű�Ҳ�Զ�reload��
SetTitleMatchMode Regex	;���Ľ���ƥ��ģʽΪ����
#Persistent				;�������в��˳�
#NoTrayIcon				;��������ͼ��
SendMode Input			;����Send���ͳһ��������SendInput

#Include d:\Dropbox\Technical_Backup\AHKScript\Functions\Menu - some functions related to AHK menus  ����menu�˵��Ŀ�\Menu.ahk

class MenuClass {
	static wholeMenuList := {}		;����洢���Ƕ��󣬲����ַ���
	indexOfWholeMenuList :=	
	
	__New(hotkeyOfMenu) {		
		MenuClass.wholeMenuList[hotkeyOfMenu] := this
		this.indexOfWholeMenuList := hotkeyOfMenu
	}
	
	checkMenuExist(hotkeyAndNameOfMenu) {				;������̫���� �ຯ�� ���� ʵ��������������
		if ( MenuClass.wholeMenuList[hotkeyAndNameOfMenu] != "" )
			return MenuClass.wholeMenuList[hotkeyAndNameOfMenu]
		else
		{
			newMenu := new MenuClass(hotkeyAndNameOfMenu)
			return newMenu
		}
	}
	
	afterPressHotkeyDoWhat() {
		return new this.popOutMenuORRunSoloDirectly(this)
	}
	
	Class ItemClass {
		whatItemNameShows :=
		calledBeforeConvert :=	
		calledFuncORLabelString :=	
		parent :=	
		
		__New(myParent) {
			this.parent := myParent
			return this
		}
		
		convertCalled() {
			if ( IsFunc(this.calledBeforeConvert) )
			{
				this.calledFuncORLabelString := Func(this.calledBeforeConvert)
			}
			else if ( IsLabel(this.calledBeforeConvert) ) 
			{
				this.calledFuncORLabelString := this.calledBeforeConvert
			}
			else
			{
				this.calledFuncORLabelString := new this.FuncClassConvertFromString(this)  			;���ܴ洢��ûдthis��called��Ϊʲô������������������������
			}
			return this.calledFuncORLabelString
		}
		
		generateItemNameIfNotGiven() {
			if ( this.whatItemNameShows != "" )
				return this.whatItemNameShows
			else
			{
				;~ MsgBox, % this.calledBeforeConvert
				;~ tempArray := StrSplit(this.calledBeforeConvert, "\", A_Space)
				;~ tempMaxIndex := tempArray.MaxIndex()
				;~ this.whatItemNameShows := Array[tempMaxIndex]
				;~ MsgBox, % Array[tempMaxIndex]
				filename := RegExReplace(this.calledBeforeConvert, ".*?\\?([^\\]+)$", "$1")
				;MsgBox, % filename
				return filename
			}
		}
		
		class FuncClassConvertFromString {
			__New(myParent) {
				this.parent := myParent
				return this
			}
			Call() {
				Run, % this.parent.calledBeforeConvert
			}
			__Call(method, args*) {
				if (method = "")  ;��%fn%()��fn.()
					return this.Call(args*)
				if (IsObject(method))  ; ����˺���������Ϊ������ʹ��.
					return this.Call(method, args*)
			}

		}
	}

	Class popOutMenuORRunSoloDirectly {
		__New(myParent) {
			this.parent := myParent
		}
		Call() {
			if ( this.parent.Length() = 1 )					;����д��.Length������һ����������������
			{	if ( IsLabel(this.parent[1].calledBeforeConvert) )
				{
					destination := this.parent[1].calledFuncORLabelString
					gosub %destination%
				}
				else
					this.parent[1].calledFuncORLabelString.call()
			}
			else		;menu���ж��item
			{
				menuName := this.parent.indexOfWholeMenuList
				CoordMode, Menu, Screen
				this.setMenuPosition()
				x := this.x
				y := this.y
				Menu, %menuName%, Show, %x%, %y%
			}
		}
		__Call(method, args*) {
			if (method = "")  								;��%fn%()��fn.()
				return this.Call(args*)
			if (IsObject(method))  							;����˺���������Ϊ������ʹ��.
				return this.Call(method, args*)
		}
		setMenuPosition() {									;�趨menu��ʾ��λ�ã��洢��this.x  this.y��
			this.x := (A_ScreenWidth / 2)
			this.y := (A_ScreenHeight / 2)
		}
		
	}
}

;calledStringֻ֧�ֽ����ַ����������ǵ�����·��������������ǩ��
appStarter(hotkeys, calledString, itemName := "") {
	menu := MenuClass.checkMenuExist(hotkeys)			;���menuʵ���Ƿ���ڡ����ޣ��򴴽������У����ȡ�洢��ַ������menu instance
	
	itemInstance := new menu.ItemClass(menu)
	itemInstance.whatItemNameShows := itemName
	itemInstance.calledBeforeConvert := calledString
	calledOBJorSTR := itemInstance.convertCalled()
	itemName := itemInstance.generateItemNameIfNotGiven()
	menu.Push(itemInstance)
	
	Menu, %hotkeys%, Add, %itemName%, %calledOBJorSTR%
	
	popOutMenuORRunSoloDirectly := menu.afterPressHotkeyDoWhat()		;�����ȼ�������afterPressHotkeyDoWhat()����
	Hotkey, %hotkeys%, %popOutMenuORRunSoloDirectly%, On
}

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
appStarter("#h", "shell:::{ED7BA470-8E54-465E-825C-99712043E01C}", "����վ")
appStarter("#g", "¼��gif")
appStarter("#s", "d:\BaiduYun\Technical_Backup\ProgramFiles\ColorPic 4.1  ��ĻȡɫС��� ��ɫ ɫ�� ��ɫ\#ColorPic.exe")

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
