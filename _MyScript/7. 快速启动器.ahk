;-------------------------------------------------------------------------------
;~ �������������
;-------------------------------------------------------------------------------
#SingleInstance FORCE	;�������ű��Ѿ�����ʱ�Ƿ��������ٴ�����,�ǵ���force���������ű�reloadʱ���ӽű�Ҳ�Զ�reload��
SetTitleMatchMode Regex	;���Ľ���ƥ��ģʽΪ����
#Persistent				;�������в��˳�
;~ #NoTrayIcon				;��������ͼ��
SendMode Input			;����Send���ͳһ��������SendInput

#Include d:\Dropbox\Technical_Backup\AHKScript\Functions\Menu - some functions related to AHK menus  ����menu�˵��Ŀ�\Menu.ahk

class _Menu {
	static wholeMenuList := {}
	nameIndex :=			;��wholeMenuList�е�key     _Menu.wholeMenuList[nameIndex]����menuʵ���Ķ�������
	child := []				;��item����������
	
	;ʵ������
	
	;����
	__New(chars) {		
		_Menu.wholeMenuList[chars] := this			;todo ���������ˣ�ֱ�Ӵ洢������
		this.nameIndex := chars
	}
	
	;���˵��Ƿ���ڣ������½�
	checkMenuExist(chars) {							;������̫���� �ຯ�� ���� ʵ��������������
		if ( _Menu.wholeMenuList[chars] != "" )
			return _Menu.wholeMenuList[chars]		;���ص���menuʵ������
		else
		{
			newMenu := new _Menu(chars)
			return newMenu
		}
	}
	
	;���غ���������Ϊ�ǵ���menu
	afterPressHotkey() {
		return new this.popOutMenu(this)
	}
	
	Class _Item {
		;ʵ������
		name :=				;��ʾ������
		called :=			;exe·���ַ���
		calledObj :=		;call�ַ���ת�ɵĺ�������
		parent :=			;��menuʵ��
		
		
		;����
		__New(myParent) {
			this.parent := myParent
			return this
		}
		
		transferCalled() {
			if ( !IsFunc(called) && !IsLabel(called) )
			{
				this.calledObj := new this.str2Func(this)  					;�洢��������this.called   ע�ⲻ�ܴ洢��ûдthis��called��Ϊʲô������������������������
				;~ calledObj.Call("C:\Windows\System32\calc.exe")
			}
			;~ return this.calledObj
		}
		
		class str2Func {					;��������д��������μ�https://autohotkey.com/docs/objects/Functor.htm
			__New(myParent) {
				this.parent := myParent
				return this
			}
			Call() {		;ע�⺯�����󣬴������ķ���
				;MsgBox % this.parent.called
				Run, % this.parent.called
			}
			__Call(method, args*) {
				if (method = "")  ;��%fn%()��fn.()
					return this.Call(args*)
				if (IsObject(method))  ; ����˺���������Ϊ������ʹ��.
					return this.Call(method, args*)
			}

		}
	}

	Class popOutMenu {
		__New(myParent) {
			this.parent := myParent
		}
		Call() {
			menuName := this.parent.nameIndex
			CoordMode, Menu, Screen
			this.setMenuPosition()
			x := this.x
			y := this.y
			Menu, %menuName%, Show, %x%, %y%
			;~ Menu, %menuName%, Show, 127, Center
		}
		__Call(method, args*) {
			if (method = "")  ;��%fn%()��fn.()
				return this.Call(args*)
			if (IsObject(method))  ; ����˺���������Ϊ������ʹ��.
				return this.Call(method, args*)
		}
		setMenuPosition() {					;�趨menu��ʾ��λ�ã��洢��this.x  this.y��
			this.x := (A_ScreenWidth / 2)
			this.y := (A_ScreenHeight / 2)
		}
		
	}
}

;called֧�ֵ������򡢶�����򡢺���
appStarter(chars, itemName, called) {
	;���menuʵ���Ƿ���ڡ����ޣ��򴴽������У����ȡ�洢��ַ������menu instance
	menu := _Menu.checkMenuExist(chars)
	
	;����called����������ֱ����ӣ������½�
	item := new menu._Item(menu)
	item.name := itemName
	item.called := called
	item.transferCalled()
	menu.Push(item)		;��������instance
	
	;�˵������menuName��called������
	;Menu, %menu.name%, Add, %item%.name, item.called
	called := item.calledObj
	Menu, %chars%, Add, %itemName%, %called%
	;~ called.call()
	
	popoutMenu := menu.afterPressHotkey()
	;�����ȼ�������afterPressHotkey()����
	Hotkey, %chars%, %popoutMenu%, On

}

appStarter("Numpad0 & q", "test2test2test2test2test2test2test2test2test2test2", "C:\Windows\System32\cmd.exe")
appStarter("Numpad0 & q", "test1", "C:\Windows\System32\calc.exe")
appStarter("^+z", "test2", "C:\Windows\System32\cmd.exe")
