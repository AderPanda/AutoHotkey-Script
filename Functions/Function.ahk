;-------------------------------------------------------------------------------

;~ ������ʹ�õ��ĺ���

;-------------------------------------------------------------------------------

;~ ��ȡѡ�е��ļ����ļ��е�·�������Ƶ�������
GetPath(Type = "FullPath", ShowTooltipTime = 0)
    {
        Clipboard =
        Send, ^c    ;����� c д�ɴ�д C �Ļ��Ͳ������ˣ���ְ�������
        ClipWait, 1
        If !ErrorLevel
        {
            Loop, Parse, Clipboard, `r, `n  ;windows ���Ƶ�ʱ�򣬼�����ᱣ�桰·���������Ե����ַ�������
            {
                If (Type = "Dir")
                {
                    SplitPath, A_LoopField,, Temp
                    Temp = %Temp%\             ;�� \ ��������һ���ļ��У���������չ���ļ�
                }

                If (Type = "Name")
                {
                    SplitPath, A_LoopField, Temp
                    If IsFolder(A_LoopField)
                    {
                        Temp = %Temp%\
                    }
                }

                If (Type = "FullPath")
                {
                    Temp = %A_LoopField%
                    If IsFolder(A_LoopField)
                    {
                        Temp = %Temp%\
                    }
                }

                FilePath = %FilePath%%Temp%`n
            }
            StringTrimRight, FilePath, FilePath, 1  ;ȥ���������ӵ�һ�����з�

            If (ShowTooltipTime > 0)                  ;���Ƶ�����ʾ��Ϣ��ʱ�䳤��
            {
                ToolTip, %FilePath%
                SetTimer, RemoveToolTip, 1500        ;1.5����Ƴ���ʾ��Ϣ
            }

            Clipboard = %FilePath%
            Return 1
        }
        Else
        {
            Return 0
        }
    }

;-------------------------------------------------------------------------------

;~ �ж�ѡ�е��Ƿ��ļ���
IsFolder(Path)
    {
        FileGetAttrib, Attrib, %Path%   ;�� Path ָ����ļ����ļ��е����Ը�ֵ�� Attrib
        IfInString, Attrib, D            ;����� Attrib ���� D ,�ͱ�ʾ���·����������ļ��У���������ļ�
        {
            Return 1
        }
        Else
        {
            Return 0
        }
    }

;-------------------------------------------------------------------------------

;~ ����˼�壬�Ƴ���ʾ��Ϣ��
RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
Return

;-------------------------------------------------------------------------------