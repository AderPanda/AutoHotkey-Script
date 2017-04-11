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
	
	;�����ȼ�������hotkeyTriger()����
	F1:: Menu, %chars%, show
	;Hotkey, %chars%, menuName.hotkeyTriger()
		
}

appStarter("F9", "test1", "C:\Windows\System32\calc.exe")
;appStarter("F9", "test2", "C:\Windows\System32\calc.exe")
	
hahaha:
	return