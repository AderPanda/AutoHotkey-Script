SetTitleMatchMode Regex
#SingleInstance ignore

TrayTip, ��ʾ, �ű�������, , 1
Sleep, 1000
TrayTip

F2::Reload

;-------------------------------------------------------------------------------
;~ ��Ϸ ����ɱ ��ݼ�
;-------------------------------------------------------------------------------
#IfWinExist ������Ϸ
{
	;��̨����λ
	F1::			
		WinGet, active_id, ID, A
		Loop {
			SetControlDelay -1
			ControlClick, X1283 Y609, ahk_id %active_id%,,,, NA	;��10��λ
			Sleep, 100
		}
		return
}