#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_icon=AntiVenoM 7.0.ico
#AutoIt3Wrapper_Res_Comment=Tepic, Nayarit. Mexico.
#AutoIt3Wrapper_Res_Description=Desinfecta Tu Pc del Virus VenoM
#AutoIt3Wrapper_Res_Fileversion=7.0.0.31
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Ruperto Coronado 2009
#AutoIt3Wrapper_Res_Language=2058
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ListboxConstants.au3>
#include <GUIConstantsEx.au3>
#include <Array.au3>
#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <Funciones.au3>
#include <StaticConstants.au3>
#Include <GuiListView.au3>
#include <File.au3>
#Region
#EndRegion


If not IsAdmin() Then
	If MsgBox(36,"Administrador...","Para un funcionamiento correcto, este programa debe ser ejecutado como administrador. Actualmente no está como tal, Aún asi desea continuar?")=7 Then
		Exit
	EndIf
EndIf


Dim $CHKMSCONFIG, $CHKNOTEPAD, $CHKREGEDIT, $CHKTASKMGR, $FRMRECUPERAR, $CMDACEPTAR, $C = 0
Dim $VERSION = "AntiVenoM " & FileGetVersion(@ScriptFullPath)
Dim $NOBORRE = _ARRAYCREATE(0), $SIBORRE = _ARRAYCREATE(0), $GAMEOVER
Dim $VREG, $B, $UNIDADES, $DETECTADOS = _ARRAYCREATE(0)
Dim $FECHA = "09-Julio-2009", $DETECTADOS
Global $UNIDEF
Dim $APGDIR = @TempDir & "\Ruperto"
INSTALAR()
#Region ### START Koda GUI section ### Form=K:\Proyectos\AutoIt\AntiVenoM\AntiVenoM Code\Form1.kxf
$FRMPRINCIPAL = GUICreate($VERSION & " Por: Ruperto", 648, 324, -1, -1, BitOR($WS_SYSMENU, $WS_CAPTION, $WS_POPUP, $WS_POPUPWINDOW, $WS_BORDER, $WS_CLIPSIBLINGS))
GUISetBkColor(16777215)
$PIC3 = GUICtrlCreatePic($APGDIR & "\Fondo2.jpg", 0, 0, 648, 324, BitOR($WS_GROUP, $WS_CLIPSIBLINGS))
$LBLVISITARBLOG = GUICtrlCreateLabel("", 372, 20, 265, 57)
GUICtrlSetCursor(-1, 0)
GUICtrlSetTip(-1, "Visita mi blog")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
$LBLESCANER = GUICtrlCreateLabel("Escaner", 48, 102, 126, 21)
GUICtrlSetFont(-1, 12)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 16777215)
$LBLACTUALIZAR = GUICtrlCreateLabel("Actualizar", 48, 153, 126, 21)
GUICtrlSetFont(-1, 12)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 16777215)
$LBLUTILIDADES = GUICtrlCreateLabel("Utilidades", 48, 204, 126, 21)
GUICtrlSetFont(-1, 12)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 16777215)
$LBLABOUT = GUICtrlCreateLabel("Acerca de...", 49, 254, 126, 21)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetFont(-1, 12)
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 16777215)
#Region Formulario Escaner
$LSTINFECTADOS = GUICtrlCreateListView("Archivos detectados", 192, 124, 449, 130, -1)
_GUICtrlListView_SetColumnWidth(GUICtrlGetHandle($LSTINFECTADOS), 0, 440)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 255)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_LV_ALTERNATE)
$BARRAPROGRESO = GUICtrlCreateProgress(192, 256, 450, 15)
$CMBUNIDADES = GUICtrlCreateCombo("Todas...", 330, 94, 97, 25, BitOR($LBS_SORT, $LBS_STANDARD, $WS_HSCROLL, $WS_VSCROLL, $WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
$UNIDEF = DEFINIRUNIDADES()
For $A In $UNIDEF
	GUICtrlSetData($CMBUNIDADES, $A)
Next
$LBLUNIDAD = GUICtrlCreateLabel("Unidad:", 272, 96, 58, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
$CMDANALIZAR = GUICtrlCreateButton("Analizar", 432, 95, 113, 24, 0)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$LBLINFO = GUICtrlCreateLabel("", 192, 272, 450, 25)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 16777215)
#EndRegion Formulario Escaner
#Region Formulario Actualizar
#EndRegion Formulario Actualizar
#Region Formulario Utilidades
$CMDPROCESOS = _CREARETIQUETA("Ver Procesos", 280, 100, 240, 25, 0)
GUICtrlSetTip(-1, "Abre el administrador de procesos", "Ayuda")
$CMDREGISTRO = _CREARETIQUETA("Desinfectar Registro", 280, 150, 240, 25, 0)
GUICtrlSetTip(-1, "Abre una ventana que le permitirá restaurar algunas" & @CRLF & "funciones bloqueadas por el virus VenoM" & @CRLF & "Además desinfectará el inicio del PC, de manera que el Virus," & @CRLF & "no se autoejecute al reiniciar su PC", "Ayuda")
$CMDRECUPERAR = _CREARETIQUETA("Recuperar Programas", 280, 200, 240, 25)
GUICtrlSetTip(-1, "Recupera las aplicaciones que usted ha seleccionado", "Ayuda")
$CMDRYD = _CREARETIQUETA("Reiniciar y Desinfectar", 280, 252, 240, 25, 0)
GUICtrlSetTip(-1, "Reiniciará su PC y comenzará el analisis" & @CRLF & "Esto garantiza una total desinfeccion, puesto " & @CRLF & "que ningun proceso se ejecutará antes de desinfectarse")
#EndRegion Formulario Utilidades
$LBLACT = GUICtrlCreateLabel("Buscar Actualización", 224, 168, 353, 40, $SS_CENTER)
GUICtrlSetFont(-1, 20, 800, 0)
GUICtrlSetColor(-1, 255)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlSetTip(-1, "clic aquí para buscar actualizaciones")
GUICtrlSetState($LBLACT, $GUI_HIDE)
#Region Acerca de...
$LBLVERSION = GUICtrlCreateLabel($VERSION, 224, 108, 353, 40, $SS_CENTER)
GUICtrlSetFont(-1, 20, 800, 0)
GUICtrlSetColor(-1, 255)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
$LBLINFOABOUT = GUICtrlCreateLabel("Aplicación creada por Ruperto Coronado." & @CRLF & "para cualquier duda o sugerencia, envíe un e-mail a rupert.25@gmail.com" & @CRLF & "o visita: rupertic.blogspot.com" & @CRLF & "Tepic, Nayarit. Mexico" & @CRLF & @CRLF & $FECHA, 248, 152, 324, 140, $SS_CENTER)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetFont(-1, 9)
GUICtrlSetColor(-1, 16777215)
#EndRegion Acerca de...
_UTILIDADES($GUI_HIDE)
_ABOUT($GUI_HIDE)
GUISetState(@SW_SHOW)
_CREARRECUPROG()
_OPTIMIZAR()
If StringInStr($CMDLINERAW, "/RyD") Then _ANALIZAR()
_ESPERAR()
#EndRegion ### END Koda GUI section ###
Func _ESPERAR()
	While 1
		Sleep(40)
		EVENTOS()
		$C = $C + 1
		If $C >= 200 Then
			_OPTIMIZAR()
			$C = 0
		EndIf
	WEnd
EndFunc
Func EVENTOS()
	$MSG = GUIGetMsg()
	Switch $MSG
		Case $GUI_EVENT_CLOSE
			_SALIR()
		Case $CMDANALIZAR
			_ANALIZAR()
		Case $LBLABOUT
			_MOSTRARACERCADE()
		Case $LBLACTUALIZAR
			_MOSTRARACTUALIZAR()
		Case $LBLESCANER
			_MOSTRARESCANER()
		Case $LBLUTILIDADES
			_MOSTRARUTILIDADES()
		Case $CMDPROCESOS
			_VERPROCESOS()
		Case $CMDRECUPERAR
			_MOSTRARRECUPERAR()
		Case $CMDREGISTRO
			_DESINFECTAR_REGISTRO()
		Case $CMDRYD
			_REINICIARYDESINFECTAR()
		Case $LBLVISITARBLOG
			_VISITARBLOG()
		Case $CMDACEPTAR
			_RECUPERARPROGRAMAS()
		Case $LBLACT
			_CMDACTUALIZAR()
	EndSwitch
EndFunc
Func CANCELAR()
	If (MsgBox(36, "Cancelando...", "Esta seguro de cancelar el analisis?", "", $FRMPRINCIPAL)) = 6 Then
		GUICtrlSetData($LBLINFO, "Analisis Cancelado")
		GUICtrlSetData($CMDANALIZAR, "Analizar")
		GUICtrlSetData($BARRAPROGRESO, 0)
		If (UBound($DETECTADOS) - 1) > 0 Then GUICtrlSetData($CMDANALIZAR, "Desinfectar!")
		_ESPERAR()
	EndIf
EndFunc
Func _RECUPERARPROGRAMAS()
	$PROGRAMAS = ""
	If BitAND(GUICtrlRead($CHKMSCONFIG), $GUI_CHECKED) Then $PROGRAMAS = $PROGRAMAS & "MsConfig.exe (Configurador de Windows)" & @CRLF
	If BitAND(GUICtrlRead($CHKNOTEPAD), $GUI_CHECKED) Then $PROGRAMAS = $PROGRAMAS & "Notepad.exe (Editor de Textos)" & @CRLF
	If BitAND(GUICtrlRead($CHKREGEDIT), $GUI_CHECKED) Then $PROGRAMAS = $PROGRAMAS & "Regedit.exe (Editor del registro)" & @CRLF
	If BitAND(GUICtrlRead($CHKTASKMGR), $GUI_CHECKED) Then $PROGRAMAS = $PROGRAMAS & "TaskMgr.exe (Administrador de Procesos)" & @CRLF
	If $PROGRAMAS <> "" Then
		If MsgBox(36, "Recuperar Aplicaciones", "Va a restaurar los siguientes programas" & @CRLF & @CRLF & $PROGRAMAS & @CRLF & "Desea Continuar?") = 6 Then
			If BitAND(GUICtrlRead($CHKMSCONFIG), $GUI_CHECKED) Then FileCopy($APGDIR & "\MsConfig.exe", @SystemDir & "\MsConfig.exe")
			If BitAND(GUICtrlRead($CHKNOTEPAD), $GUI_CHECKED) Then FileCopy($APGDIR & "\Bloc.exe", @SystemDir & "\Notepad.exe")
			If BitAND(GUICtrlRead($CHKREGEDIT), $GUI_CHECKED) Then FileCopy($APGDIR & "\Regedit.exe", @SystemDir & "\Regedit.exe")
			If BitAND(GUICtrlRead($CHKTASKMGR), $GUI_CHECKED) Then FileCopy($APGDIR & "\ProcesosAntivenoM.exe", @SystemDir & "\TaskMgr.exe")
		EndIf
	EndIf
EndFunc
Func DETECTVENOM($FILE)
	If FileExists($FILE) Then
		_ArrayAdd($DETECTADOS, $FILE)
		GUICtrlSetData($LSTINFECTADOS, $FILE)
	EndIf
EndFunc
Func RASTROSVENOM()
	$ARCHIVOSCOM = FILES2ARRAY(@SystemDir & "\Drivers\Etc\", "*.com")
	If IsArray($ARCHIVOSCOM) Then
		If $ARCHIVOSCOM[0] > 0 Then
			For $X In $ARCHIVOSCOM
				$ARCHIVOALEER = @SystemDir & "\Drivers\Etc\" & $X
				Sleep(40)
				If ANALIZARARCHIVO($ARCHIVOALEER) = 1 Then
					_ArrayAdd($DETECTADOS, $ARCHIVOALEER)
					GUICtrlSetData($LSTINFECTADOS, $ARCHIVOALEER)
				EndIf
			Next
		EndIf
	EndIf
	DETECTVENOM(@UserProfileDir & "\Plantillas\help.hta")
	DETECTVENOM(@StartupDir & "\Win.scr")
	DETECTVENOM(@UserProfileDir & "\VenoM.txt")
	DETECTVENOM(@UserProfileDir & "\Autorun.inf")
	DETECTVENOM(@UserProfileDir & "\Desktop.inf")
	DETECTVENOM(@HomeDrive & "\Autorun.inf")
	DETECTVENOM(@AppDataDir & "\Autorun.inf")
	DETECTVENOM(@StartupDir & "\MS-DOS.pif")
	DETECTVENOM(@StartupDir & "\VenoM.bat")
	DETECTVENOM(@StartupDir & "\VenoM.vbs")
	$UNIDEF = DEFINIRUNIDADES()
	For $I In $UNIDEF
		If Not ($I = 0) Or Not ($I = "A:\") Then
			If StringInStr(IniRead($I & "\Autorun.inf", "AutoRun", "Open", ""), "venom") Then DETECTVENOM($I & "\Autorun.inf")
			DETECTVENOM($I & "\VenoM.666\Explorer.exe")
			DETECTVENOM($I & "\VenoM.txt")
			DETECTVENOM($I & "\Desktop.inf")
		EndIf
	Next
	$GAMEOVER = _FileListToArray(@UserProfileDir & "\SendTo", "Game*.txt")
	If Not @error = 1 Then
		For $I = 1 To $GAMEOVER[0]
			DETECTVENOM(@UserProfileDir & "\SendTo\" & $GAMEOVER[$I])
		Next
	EndIf
	For $I In $UNIDEF
		If Not $I = 0 Then
			BORRARCARPETA($I & "\System.volume.information")
			BORRARCARPETA($I & "\VenoM.666")
		EndIf
	Next
EndFunc
Func BORRARARCHIVO($ARCHIVOB)
	If FileExists($ARCHIVOB) Then
		FileSetAttrib($ARCHIVOB, "-R-H")
		$ESTADO = FileDelete($ARCHIVOB)
		If $ESTADO = 0 Then
			_ArrayInsert($NOBORRE, UBound($NOBORRE), $ARCHIVOB)
		Else
			_ArrayInsert($SIBORRE, UBound($SIBORRE), $ARCHIVOB)
		EndIf
	EndIf
EndFunc
Func BORRARCARPETA($CARPETA)
	If FileExists($CARPETA) Then
		FileSetAttrib($CARPETA, "-R-H")
		$ESTADO = FileRecycle($CARPETA)
		If $ESTADO = 0 Then
			_ArrayInsert($NOBORRE, UBound($NOBORRE), $CARPETA)
		Else
			_ArrayInsert($SIBORRE, UBound($SIBORRE), $CARPETA)
		EndIf
	EndIf
EndFunc
Func DESINFECTAR()
	GUICtrlSetData($LBLINFO, "Desinfectando...")
	GUICtrlSetState($CMDANALIZAR, $GUI_DISABLE)
	CERRARPROCESOS()
	FileCopy(@SystemDir & "\Hal.dll", @HomeDrive)
	FileSetAttrib(@HomeDrive & "\Hal.dll", "H")
	$TAMDETECT = UBound($DETECTADOS) - 1
	For $I = 1 To $TAMDETECT
		GUICtrlSetData($BARRAPROGRESO, $TAMDETECT / ($TAMDETECT - $I))
		BORRARARCHIVO($DETECTADOS[$I])
	Next
	REGISTRO($VERSION, $FRMPRINCIPAL)
	FileSetAttrib(@WindowsDir, "-H", 1)
	If Not (UBound($NOBORRE) = 0) Then
		For $B In $NOBORRE
			BORRARARCHIVO($B)
		Next
	EndIf
	_MOSTRARRECUPERAR()
	ESCRIBELOG($VERSION, $SIBORRE, $NOBORRE, $LSTINFECTADOS)
	GUICtrlSetState($CMDANALIZAR, $GUI_ENABLE)
	GUICtrlSetData($LBLINFO, "Felicidades Su PC ha sido desinfectada del Virus VenoM!")
	GUICtrlSetData($CMDANALIZAR, "Analizar")
	GUICtrlSetData($BARRAPROGRESO, 100)
EndFunc

Func _REINICIARYDESINFECTAR()
	If MsgBox(36, "Reinciar y Desinfectar", "Esta funcion reiniciara su PC y la Desinfectará." & @CRLF & "¿desea continuar?") = 6 Then
		GUICtrlSetData($LBLVERSION, "Reiniciando...")
		GUICtrlSetData($LBLINFOABOUT, "Se está reiniciando su PC por favor espere un momento")
		_MOSTRARACERCADE()
		GUICtrlSetState($BARRAPROGRESO, $GUI_SHOW)
		GUICtrlSetData($BARRAPROGRESO, 20)
		Sleep(600)
		RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx", "TITLE", "REG_SZ", "Rupert.25@gmail.com")
		RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx\001", "1", "REG_SZ", @HomeDrive & "\AntiVenoM7.Exe /RyD")
		GUICtrlSetData($BARRAPROGRESO, 40)
		Sleep(600)
		If FileCopy(@ScriptFullPath, @HomeDrive & "\AntiVenoM7.exe", 1) = 1 Then
			GUICtrlSetData($BARRAPROGRESO, 70)
			If MsgBox(36, "Reiniciar", "Se va a reinicar su PC ahora. ¿Desea continuar?") = 6 Then
				GUICtrlSetData($BARRAPROGRESO, 100)
				Shutdown(6)
			EndIf
		Else
			MsgBox(36, "Error!", "Error al copiar el archivo a la unidad: " & @HomeDrive & @CRLF & "Por favor reintentelo")
		EndIf
	EndIf
EndFunc

Func _ANALIZARPROCESOS()
	GUICtrlSetData($LBLINFO, "Analizando Procesos...")
	$PROCESOS = _PROCESSLISTPROPERTIES()
	If IsArray($PROCESOS) Then
		For $I = 1 To $PROCESOS[0][0]
			GUICtrlSetData($LBLINFO, "Analizando Procesos..." & @CRLF & "Proceso: " & $PROCESOS[$I][5])
			If ANALIZARARCHIVO($PROCESOS[$I][5]) = 1 Then
				_ArrayAdd($DETECTADOS, $PROCESOS[$I][5])
				ProcessClose($PROCESOS[$I][1])
				GUICtrlSetData($LSTINFECTADOS, $PROCESOS[$I][5])
			EndIf
		Next
	EndIf
EndFunc

Func _SALIR()
	If WinActive($FRMPRINCIPAL) Then
		If MsgBox(36, "Salir?", "Desea cerrar " & $VERSION & " Ahora?", "", $FRMPRINCIPAL) = 6 Then
			DirRemove($APGDIR, 1)
			Exit
		EndIf
	Else
		_CERRARME()
	EndIf
EndFunc
Func _ANALIZAR()
	If (GUICtrlRead($CMDANALIZAR) = "Cancelar!") Then
		CANCELAR()
	ElseIf (GUICtrlRead($CMDANALIZAR) = "Desinfectar!") Then
		DESINFECTAR()
	Else
		_ANALIZARPROCESOS()
		RASTROSVENOM()
		$UNIDAD = StringUpper(GUICtrlRead($CMBUNIDADES))
		If $UNIDAD = "TODAS..." Then
			For $A In $UNIDEF
				GUICtrlSetData($CMDANALIZAR, "Cancelar!")
				ANALIZAR($A)
			Next
			GUICtrlSetData($CMDANALIZAR, "Analizar")
			GUICtrlSetData($LBLINFO, "Analisis Terminado")
			GUICtrlSetData($BARRAPROGRESO, 0)
			$TAMDETECT = UBound($DETECTADOS) - 1
			If $TAMDETECT <> 0 Then
				If MsgBox(36, "Desinfectar", "Se han encontrado " & $TAMDETECT & " archivos infectados en su PC " & "¿Desea proceder a desinfectar su PC?", "", $FRMPRINCIPAL) = 6 Then
					GUICtrlSetData($LBLINFO, "Analisis Terminado - Se han encontrado " & $TAMDETECT & " archivos infectados en su PC")
					DESINFECTAR()
				Else
					GUICtrlSetData($LBLINFO, "Analisis Terminado - Se han encontrado " & $TAMDETECT & " archivos infectados en su PC")
					GUICtrlSetData($CMDANALIZAR, "Desinfectar!")
				EndIf
			Else
				GUICtrlSetData($CMDANALIZAR, "Analizar")
				GUICtrlSetData($LBLINFO, "Analisis Terminado - no hay rastros del virus venom en su PC")
				GUICtrlSetData($BARRAPROGRESO, 100)
			EndIf
		Else
			$UNIDAD = COMPROBARUNIDAD($UNIDAD)
			If $UNIDAD = "0" Then
				MsgBox(16, "Error!", "La unidad que usted ha escrito no está preparada")
			Else
				GUICtrlSetData($CMDANALIZAR, "Cancelar!")
				ANALIZAR($UNIDAD)
				GUICtrlSetData($BARRAPROGRESO, 0)
				$TAMDETECT = UBound($DETECTADOS) - 1
				If $TAMDETECT <> 0 Then
					If MsgBox(36, "Desinfectar", "Se han encontrado " & $TAMDETECT & " archivos infectados en su PC " & "¿Desea proceder a desinfectar su PC?", "", $FRMPRINCIPAL) = 6 Then
						GUICtrlSetData($LBLINFO, "Analisis Terminado - Se han encontrado " & $TAMDETECT & " archivos infectados en su PC")
						DESINFECTAR()
					Else
						GUICtrlSetData($LBLINFO, "Analisis Terminado - Se han encontrado " & $TAMDETECT & " archivos infectados en su PC")
						GUICtrlSetData($CMDANALIZAR, "Desinfectar!")
					EndIf
				Else
					GUICtrlSetData($CMDANALIZAR, "Analizar")
					GUICtrlSetData($LBLINFO, "Analisis Terminado - no hay rastros del virus venom en su PC")
					GUICtrlSetData($BARRAPROGRESO, 100)
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc
Func _MOSTRARESCANER()
	_UTILIDADES($GUI_HIDE)
	_ESCANER()
	_ABOUT($GUI_HIDE)
	GUICtrlSetState($LBLACT, $GUI_HIDE)
EndFunc
Func _MOSTRARACTUALIZAR()
	_ABOUT($GUI_HIDE)
	_ESCANER($GUI_HIDE)
	_UTILIDADES($GUI_HIDE)
	GUICtrlSetState($LBLACT, $GUI_SHOW)
EndFunc
Func _MOSTRARUTILIDADES()
	_ABOUT($GUI_HIDE)
	_ESCANER($GUI_HIDE)
	_UTILIDADES()
	GUICtrlSetState($LBLACT, $GUI_HIDE)
EndFunc
Func _MOSTRARACERCADE()
	_ESCANER($GUI_HIDE)
	_UTILIDADES($GUI_HIDE)
	_ABOUT()
	GUICtrlSetState($LBLACT, $GUI_HIDE)
EndFunc
Func _DESINFECTAR_REGISTRO()
	REGISTRO($VERSION, $FRMPRINCIPAL)
EndFunc
Func _UTILIDADES($_ESTATUS = $GUI_SHOW)
	GUICtrlSetState($CMDPROCESOS, $_ESTATUS)
	GUICtrlSetState($CMDREGISTRO, $_ESTATUS)
	GUICtrlSetState($CHKNOTEPAD, $_ESTATUS)
	GUICtrlSetState($CHKREGEDIT, $_ESTATUS)
	GUICtrlSetState($CHKMSCONFIG, $_ESTATUS)
	GUICtrlSetState($CHKTASKMGR, $_ESTATUS)
	GUICtrlSetState($CMDRECUPERAR, $_ESTATUS)
	GUICtrlSetState($CMDRYD, $_ESTATUS)
EndFunc
Func _ESCANER($_ESTATUS = $GUI_SHOW)
	GUICtrlSetState($LSTINFECTADOS, $_ESTATUS)
	GUICtrlSetState($CMDANALIZAR, $_ESTATUS)
	GUICtrlSetState($CMBUNIDADES, $_ESTATUS)
	GUICtrlSetState($LBLUNIDAD, $_ESTATUS)
	GUICtrlSetState($BARRAPROGRESO, $_ESTATUS)
	GUICtrlSetState($LBLINFO, $_ESTATUS)
EndFunc
Func _ABOUT($_ESTATUS = $GUI_SHOW)
	GUICtrlSetState($LBLVERSION, $_ESTATUS)
	GUICtrlSetState($LBLINFOABOUT, $_ESTATUS)
EndFunc
Func _CREARETIQUETA($TEXTO, $X, $Y, $LARGO = -1, $ALTO = -1, $CURSOR = 0)
	$LBLTEMP = GUICtrlCreateLabel($TEXTO, $X, $Y, $LARGO, $ALTO, $SS_CENTER)
	GUICtrlSetColor(-1, 16777215)
	GUICtrlSetFont(-1, 16)
	GUICtrlSetCursor(-1, $CURSOR)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	Return $LBLTEMP
EndFunc
Func _MOSTRARRECUPERAR()
	GUISetState(@SW_DISABLE, $FRMPRINCIPAL)
	GUISetState(@SW_SHOW, $FRMRECUPERAR)
	While 1
		$MSG = GUIGetMsg()
		Switch $MSG
			Case $GUI_EVENT_CLOSE
				_CERRARME()
				ExitLoop
			Case $CMDACEPTAR
				_RECUPERARPROGRAMAS()
				_CERRARME()
				ExitLoop
		EndSwitch
	WEnd
EndFunc
Func _CERRARME()
	GUISetState(@SW_HIDE, $FRMRECUPERAR)
	GUISetState(@SW_ENABLE, $FRMPRINCIPAL)
	WinActivate($FRMPRINCIPAL)
EndFunc
Func _VISITARBLOG()
	ShellExecute("http://rupertic.blogspot.com")
EndFunc
Func _OPTIMIZAR($I_PID = -1)
	If $I_PID <> -1 Then
		Local $AI_HANDLE = DllCall("kernel32.dll", "int", "OpenProcess", "int", 2035711, "int", False, "int", $I_PID)
		Local $AI_RETURN = DllCall("psapi.dll", "int", "EmptyWorkingSet", "long", $AI_HANDLE[0])
		DllCall("kernel32.dll", "int", "CloseHandle", "int", $AI_HANDLE[0])
	Else
		Local $AI_RETURN = DllCall("psapi.dll", "int", "EmptyWorkingSet", "long", -1)
	EndIf
	Return $AI_RETURN[0]
EndFunc
Func _CREARRECUPROG()
	$FRMRECUPERAR = GUICreate("Recuperar programas", 300, 200, -1, -1, $WS_SYSMENU, -1, $FRMPRINCIPAL)
	GUISetBkColor(16777215, $FRMRECUPERAR)
	GUICtrlCreateLabel("por favor seleccione los programas que desea recuperar", 10, 10)
	GUICtrlSetColor(-1, 8421504)
	$CHKNOTEPAD = GUICtrlCreateCheckbox("Bloc de notas", 10, 30, 250)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$CHKREGEDIT = GUICtrlCreateCheckbox("Registro De Windows", 10, 50, 250)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$CHKMSCONFIG = GUICtrlCreateCheckbox("MSConfig", 10, 70, 250)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$CHKTASKMGR = GUICtrlCreateCheckbox("Administrador de Tareas", 10, 90, 250)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$CMDACEPTAR = GUICtrlCreateButton("Recuperar", 10, 120, 270, 30)
EndFunc
Func FILES2ARRAY($DIR, $FILTRO = "*")
	Local $HSEARCH, $SFILE, $ASFILELIST = _ARRAYCREATE(0)
	$ASFILELIST[0] = 0
	If Not FileExists($DIR) Then SetError(0)
	$EXTS = StringSplit($FILTRO, ";")
	For $I = 1 To $EXTS[0]
		$FILTRO = $EXTS[$I]
		$HSEARCH = FileFindFirstFile($DIR & "\" & $FILTRO)
		While 1
			$SFILE = FileFindNextFile($HSEARCH)
			If @error Then ExitLoop
			If StringInStr(FileGetAttrib($DIR & "\" & $SFILE), "D") = 0 Then
				_ArrayAdd($ASFILELIST, $SFILE)
			EndIf
		WEnd
	Next
	FileClose($HSEARCH)
	$ASFILELIST[0] = UBound($ASFILELIST) - 1
	Return $ASFILELIST
EndFunc
Func ANALIZAR($UNIDADA)
	$ANALIZANDO = FILES2ARRAY($UNIDADA, "*.exe;*.scr")
	If Not IsArray($ANALIZANDO) Then MsgBox(64, "", "Pause: " & $UNIDADA & @CRLF & $ANALIZANDO)
	If IsArray($ANALIZANDO) Then
		If $ANALIZANDO[0] > 0 Or @error Then
			For $X In $ANALIZANDO
				If $B = 100 Then $B = 0
				$B = $B + 1
				GUICtrlSetData($BARRAPROGRESO, $B)
				$ARCHIVOALEER = $UNIDADA & $X
				If Not (GUICtrlGetState($LBLINFO) = 96) Then GUICtrlSetData($LBLINFO, "Analizando: [" & FileGetShortName($ARCHIVOALEER) & "]")
				EVENTOS()
				Sleep(40)
				If ANALIZARARCHIVO($ARCHIVOALEER) = 1 Then
					_ArrayAdd($DETECTADOS, $ARCHIVOALEER)
					GUICtrlCreateListViewItem($ARCHIVOALEER, $LSTINFECTADOS)
				EndIf
			Next
		EndIf
	EndIf
	$FOLDERANALIZANDO = _FileListToArray($UNIDADA, "*.*", 2)
	If Not @error = 1 Then
		For $Z = 1 To $FOLDERANALIZANDO[0]
			$RUTA = $UNIDADA & $FOLDERANALIZANDO[$Z] & "\"
			ANALIZAR($RUTA)
		Next
	EndIf
EndFunc
Func _CMDACTUALIZAR()
	ShellExecute("http://rupertic.blogspot.com/search/label/AntiVenoM")
EndFunc