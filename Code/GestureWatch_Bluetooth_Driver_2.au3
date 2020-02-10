#include <WinAPIFiles.au3>
#include <WinAPIHObj.au3>
Dim $nBytes = 1
$Result = 0
$input = InputBox("", "Port Number?")
Do
	$RESULT = _WinAPI_CreateFile("\\.\COM"&$input, 2, 2)
	If $RESULT = 0 then
		ToolTip("Connection failed, trying again...", 0, 0, "", 1)
	EndIf
Until $RESULT <> 0
ToolTip("Connection success!", 0, 0, "", 1, 4)
Sleep(2000)
ToolTip("")

$tBuffer = DllStructCreate("byte[1]")
$altUp = 1
while 1
	_WinAPI_ReadFile($RESULT, DllStructGetPtr($tBuffer), 1, $nBytes)
	$sText = BinaryToString(DllStructGetData($tBuffer, 1))
	#ConsoleWrite($sText)
	Select
		Case $sText = '+'
			#ConsoleWrite($sText)
			Send("{RIGHT}")
		Case $sText = '-'
			#ConsoleWrite($sText)
			Send("{LEFT}")
		Case $sText = 's'
			Send("{SPACE}")
		Case $sText = 'a'
			If $altUp = 1 then
				Send("{ALT DOWN}")
				Send("{TAB}")
				$altUp = 0
			Else
				Send("{ALT UP}")
				$altUp = 1
			EndIf
		#Case $sText = 'f'
		#	Send("{RIGHT}")
		#Case $sText = 'r'
		#	Send("{LEFT}")
		#Case $sText = 'e'
		#	Send("{RIGHT UP}")
		#	Send("{LEFT UP}")
	EndSelect
	Sleep(25)
wend
_WinAPI_CloseHandle($RESULT)
