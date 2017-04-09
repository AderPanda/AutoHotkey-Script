;-------------------------------------------------------------------------------
;~ �������������
;-------------------------------------------------------------------------------


class _Menu {
	;�����
	static wholeMenuList := {}
	
	;ʵ������
	nameIndex :=			;��wholeMenuList�е�key     _Menu.wholeMenuList[nameIndex]����menuʵ���Ķ�������
	child := []				;��item����������
	
	;����
	__New(chars) {
		_Menu.wholeMenuList[chars] := this
		this.nameIndex := chars
	}
	;~ �����ȼ�ʱ��ִ�е��жϺ��������ֻ��һ������ֱ��ִ�У�����ж��������ʾ�˵�
	checkMenuExist(chars) {							;������̫���� �ຯ�� ���� ʵ��������������
		if ( _Menu.wholeMenuList[chars] != "" )
			return _Menu.wholeMenuList[chars]		;���ص���menuʵ������
		else
		{
			newMenu := new _Menu(chars)
			return newMenu
		}
	}
	
	Class _Item {
		;ʵ������
		name :=				;��ʾ������
		called :=			;��call�ĺ������ַ���
		parent :=			;��menuʵ��
		
		;����
		__New(myParent) {
			this.parent := myParent
			return this
		}
		
		transferCalled() {
			if ( !IsFunc(called) && !IsLabel(called) )
			{
				funcCalled := new _Item.str2Func(called)
				return funcCalled
			}
			else
				return called
		}
		
		class str2Func {					;��������д��������μ�https://autohotkey.com/docs/objects/Functor.htm
			__Call(method, exePath) {		;ע�⺯�����󣬴������ķ���
				Run, % exePath	
			}
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
	MsgBox, % item.called
	menu.child.Push(item)		;��������instance
	
	;�˵������menuName��called������
	;Menu, %menu.name%, Add, %item%.name, item.called
	Menu, %chars%, Add, %itemName%, item.called
	
	;�����ȼ�������hotkeyTriger()����
	;Hotkey, %chars%, menuName.hotkeyTriger()
		
}

appStarter("F9", "test1", "C:\Windows\System32\calc.exe")
appStarter("F9", "test2", "C:\Windows\System32\calc.exe")
	