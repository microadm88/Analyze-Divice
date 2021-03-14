#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Comment=Tepic, Nayarit. Mexico.
#AutoIt3Wrapper_Res_Description=Desinfecta Tu Pc del Virus VenoM
#AutoIt3Wrapper_Res_Fileversion=6.1.0.21
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Ruperto Muñoz 2008
#AutoIt3Wrapper_Res_Language=2058
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <ListBoxConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Funciones.au3>
#include <_ProcessGetproperties.au3>
SO()

Dim $Version = "APG AntiVenoM " & FileGetVersion(@AutoItExe) 
Dim $_Error = 0, $Msg, $Pos, $Tam
Dim $NoBorre = _ArrayCreate(0), $SiBorre = _ArrayCreate(0), $GameOver 
Dim $VReg, $b, $Unidades,  $Detectados = _ArrayCreate(0)
Dim $Fecha = "22-Agosto-2008", $Detectados
Global $UniDef
Global $hSearch, $sFile, $asFileList = _ArrayCreate(0), $NN = 0
Dim $APGDir = @TempDir & "\Ruperto"

Instalar()

#Region ### START Koda GUI section ### Form=K:\Proyectos\AutoIt\AntiVenoM\AntiVenoM Code\Form1.kxf
$Form1 = GUICreate($Version & " Por: Ruperto", 645, 320, -1, -1, BitOR($WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_BORDER,$WS_CLIPSIBLINGS))
GUISetBkColor(0xFFFFFF)
;Formulario Padre
$Pic1 = GUICtrlCreatePic($APGDir & "\Fondo.jpg", 0, 0, 648, 324, BitOR($WS_GROUP,$WS_CLIPSIBLINGS))
$lblEscaner = GUICtrlCreateLabel("Escaner", 48, 99, 126, 21)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0x0a7bf8)
GUICtrlSetCursor (-1, 0)
GUICtrlSetColor(-1,0xFFFFFF)
$lblActualizar = GUICtrlCreateLabel("Actualizar", 48, 150, 126, 21)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0x0a7bf8)
GUICtrlSetCursor (-1, 0)
GUICtrlSetColor(-1,0xFFFFFF)
$lblUtilidades = GUICtrlCreateLabel("Utilidades", 48, 201, 126, 21)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0x0a7bf8)
GUICtrlSetCursor (-1, 0)
GUICtrlSetColor(-1,0xFFFFFF)
$lblAbout = GUICtrlCreateLabel("Acerca de...", 49, 251, 126, 21)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0x0a7bf8)
GUICtrlSetCursor (-1, 0)
GUICtrlSetColor(-1,0xFFFFFF)
;=>Formulario Padre

#Region Formulario Escaner
$LstInfectados = GUICtrlCreateList("", 192, 124, 449, 130, -1, 0)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
$BarraProgreso = GUICtrlCreateProgress(192,256,450,15)
$cmbUnidades = GUICtrlCreateCombo("Todas...", 330, 94, 97, 25,BitOR($LBS_SORT,$LBS_STANDARD,$WS_HSCROLL,$WS_VSCROLL,$WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$UniDef = DefinirUnidades()
For $A In $UniDef
	Guictrlsetdata($cmbUnidades,$A)
Next
$lblUnidad = GUICtrlCreateLabel("Unidad:", 272, 96, 58, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$cmdAnalizar = GUICtrlCreateButton("Analizar", 432, 95, 113, 24, 0)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$lblInfo = GUICtrlCreateLabel("",192,272,450,25)
$chkStopAndDestroy = GUICtrlCreateCheckbox("Habilitar 'Stop And Destroy'",192,300)
GUICtrlSetState(-1,$GUI_CHECKED)
$AyudaSAD = GUICtrlCreateButton("?",360,300)
#EndRegion =>Formulario Escaner

#Region Formulario Actualizar
#EndRegion =>Formulario Actualizar

#Region Formulario Utilidades
$CmdProcesos = GUICtrlCreateButton("Ver Procesos",280,90,220,40)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$CmdInfoProcesos =GUICtrlCreateButton("?",505,90,40,40)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$CmdRegistro = GUICtrlCreateButton("Desinfectar Registro",280,135,220,40)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetTip(-1,"Abre una ventana que le permitirá restaurar algunas funciones bloqueadas por el virus VenoM" & @CRLF & _ 
	"Además desinfectará el inicio del PC, de manera que el VenoM, no se autoejecute al reiniciar su PC","Ayuda")

$cmdInfoRegistro = GUICtrlCreateButton("?",505,135,40,40)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$chkNotepad = GUICtrlCreateCheckbox("Notepad",283,175)
GUICtrlSetState(-1, $GUI_CHECKED)
$chkRegedit = GUICtrlCreateCheckbox("Registro De Windows",355,175)
GUICtrlSetState(-1, $GUI_CHECKED)
$chkMsConfig = GUICtrlCreateCheckbox("MSConfig",283,195)
GUICtrlSetState(-1, $GUI_CHECKED)
$chkTaskMgr = GUICtrlCreateCheckbox("Administrador de Tareas",355,195)
GUICtrlSetState(-1, $GUI_CHECKED)
$cmdRecuperar = GUICtrlCreateButton("Recuperar Programas",280,217,220,40)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$cmdInfoRecuperar = GUICtrlCreateButton("?",505,217,40,40)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$cmdRyD = GUICtrlCreateButton("Reiniciar y Desinfectar",280,262,220,40)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$cmdInfoRyD = GUICtrlCreateButton("?",505,262,40,40)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
#EndRegion => Formulario Utilidades


#Region Acerca de...
$lblversion = GUICtrlCreateLabel($Version, 224, 128, 353, 20, $SS_CENTER)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
$lblInfoAbout = GUICtrlCreateLabel("Creado Por Ruperto." & @CRLF & "rupert.25@gmail.com" & @CRLF & @CRLF & "Tepic, Nayarit. Mexico" & @CRLF & @CRLF & $Fecha, 248, 152, 324, 100, $SS_CENTER)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
#EndRegion =>Acerca De...


NoUtilidades()
NoAbout()
GUISetState(@SW_SHOW)
Esperar()
#EndRegion ### END Koda GUI section ###

Func Eventos()
	$Evento = GUIGetMsg()
	Switch $Evento
		Case $GUI_EVENT_CLOSE
			If MsgBox(36,"Salir?","Desea cerrar " & $Version & " Ahora?","",$Form1)=6 Then 
				DirRemove($APGDir,1)
				Exit
			EndIf
		Case $lblEscaner
			NoUtilidades()
			Escaner()
			NoAbout()
		Case $lblActualizar
			NoAbout()
			NoEscaner()
			NoUtilidades()
		Case $lblUtilidades
			NoAbout()
			NoEscaner()
			Utilidades()
		Case $lblAbout
			NoEscaner()
			NoUtilidades()
			About()
		Case $AyudaSAD
			MsgBox(64,"Ayuda","indica si se deben terminar procesos al desinfectar",0,$Form1)
		Case $cmdAnalizar
			If (GUICtrlRead($cmdAnalizar) = "Cancelar!") Then
				Cancelar()
			ElseIf (GUICtrlRead($cmdAnalizar) = "Desinfectar!") Then
				Desinfectar()
			Else
			$Unidad = StringUpper(GUICtrlRead($CmbUnidades))
			If $Unidad = "TODAS..." Then
				For $a In $UniDef
					GUICtrlSetData($cmdAnalizar,"Cancelar!")
					Analizar($a)
				Next
				GUICtrlSetData($cmdAnalizar,"Analizar")
				GUICtrlSetData($lblInfo,"Analisis Terminado")
				GUICtrlSetData($BarraProgreso,0)
					If MsgBox(36,"Desinfectar","Se procederá a desinfectar su PC, ¿Desea Continuar")=6 Then Desinfectar()
			Else
				$Unidad = ComprobarUnidad($Unidad)
				If $Unidad = "0" Then 
					MsgBox(16,"Error!","La unidad que usted ha escrito no está preparada")
				Else
					;MsgBox(0,"Unidad","Se selecciona una unidad que si esta lista")
					GUICtrlSetData($cmdAnalizar,"Cancelar!")
					Analizar($Unidad)
					GUICtrlSetData($BarraProgreso,0)
					$TamDetect = UBound($Detectados) - 1
					If $TamDetect <> 0 Then
						If MsgBox(36,"Desinfectar","Se han encontrado " & $TamDetect & " archivos infectados en su PC " & _
								"¿Desea proceder a desinfectar su PC?")=6 Then 
							GUICtrlSetData($lblInfo,"Analisis Terminado - Se han encontrado " & $TamDetect & " archivos infectados en su PC")
							Desinfectar()
						Else
							GUICtrlSetData($lblInfo,"Analisis Terminado - Se han encontrado " & $TamDetect & " archivos infectados en su PC")		
							GUICtrlSetData($cmdAnalizar,"Desinfectar!")
						EndIf
					Else
						GUICtrlSetData($cmdAnalizar,"Analizar")
						GUICtrlSetData($lblInfo,"Analisis Terminado - Felicidades!!! Su PC NO está infectada")
						GUICtrlSetData($BarraProgreso,100)
					EndIf
				EndIf
			EndIf
			EndIf
		Case $cmdInfoRyD
			MsgBox(64,"Ayuda","Reiniciará su PC y comenzará el analisis" & @CRLF & "Esto garantiza una total desinfeccion, puesto que ningun proceso se ejecutará antes de desinfectarse")
		Case $CmdInfoProcesos
			MsgBox(64,"Ayuda","Presione el botón para ver y terminar procesos, que se ejecutan en su computadora")
		Case $cmdInfoRegistro
			MsgBox(64,"Ayuda","Abre una ventana que le permitirá restaurar algunas funciones bloqueadas por el virus VenoM" & @CRLF & "Además desinfectará el inicio del PC, de manera que el VenoM, no se autoejecute al reiniciar su PC")
		Case $cmdInfoRecuperar
			MsgBox(64,"Ayuda","Recupera las aplicaciones que usted ha seleccionado")
		Case $CmdRegistro
			Registro($Version)
		Case $CmdProcesos
			;VerProcesos()
		Case $cmdRecuperar
			Recuperar()
		Case $cmdRyD
			ReiniciarYDesinfectar()
	EndSwitch
	$Evento = 0
EndFunc

Func NoEscaner()
	Ocultar($LstInfectados)
	Ocultar($cmdAnalizar)
	Ocultar($cmbUnidades)
	Ocultar($lblUnidad)
	Ocultar($BarraProgreso)
	Ocultar($lblInfo)
	Ocultar($chkStopAndDestroy)
	Ocultar($AyudaSAD)
EndFunc

Func Escaner()
	Mostrar($LstInfectados)
	Mostrar($cmdAnalizar)
	Mostrar($cmbUnidades)
	Mostrar($lblUnidad)
	Mostrar($BarraProgreso)
	Mostrar($lblInfo)
	Mostrar($chkStopAndDestroy)
	Mostrar($AyudaSAD)
EndFunc

Func NoUtilidades()
	Ocultar($CmdProcesos)
	Ocultar($CmdInfoProcesos)
	Ocultar($CmdRegistro)
	Ocultar($cmdInfoRegistro)
	Ocultar($chkNotepad)
	Ocultar($chkRegedit)
	Ocultar($chkMsConfig)
	Ocultar($chkTaskMgr)
	Ocultar($cmdRecuperar)
	Ocultar($cmdInfoRecuperar)
	Ocultar($cmdRyD)
	Ocultar($CmdInfoRyD)
EndFunc

Func Utilidades()
	Mostrar($CmdProcesos)
	Mostrar($CmdInfoProcesos)
	Mostrar($CmdRegistro)
	Mostrar($cmdInfoRegistro)
	Mostrar($chkNotepad)
	Mostrar($chkRegedit)
	Mostrar($chkMsConfig)
	Mostrar($chkTaskMgr)
	Mostrar($cmdRecuperar)
	Mostrar($cmdInfoRecuperar)
	Mostrar($cmdRyD)
	Mostrar($CmdInfoRyD)
EndFunc

Func NoAbout()
	Ocultar($lblversion)
	Ocultar($lblInfoAbout)
EndFunc

Func About()
	Mostrar($lblversion)
	Mostrar($lblInfoAbout)
EndFunc

Func Files2Array($Dir, $Filtro = "*")
	Local $hSearch, $sFile, $asFileList = _ArrayCreate(0), $NN = 0
	If Not FileExists($Dir) Then Return SetError(1, 1, "")
	$Exts = StringSplit($Filtro, ";")
	For $i = 1 To $Exts[0]
		$Filtro = $Exts[$i]
		$hSearch = FileFindFirstFile($Dir & "\" & $Filtro)
		While 1
			$sFile = FileFindNextFile($hSearch)
			;Eventos()
			If @error Then
				SetError(0)
				ExitLoop
			EndIf
			If StringInStr(FileGetAttrib($Dir & "\" & $sFile), "D") = 0 Then
				_ArrayAdd($asFileList, $sFile)
				$NN = $NN + 1
			EndIf
		WEnd
	Next
	FileClose($hSearch)
	_ArrayDelete($asFileList, 0)
	If ($NN = 0) Then $_Error = 1
	If ($NN <> 0) Then $_Error = 0
	Return $asFileList
EndFunc   ;==>Files2Array

Func Analizar($UnidadA)
	$Analizando = Files2Array($UnidadA, "*.exe;*.scr")
	;MsgBox(0,"Funcion Analizar","Estoy en la funcion analizar")
	If $_Error = 0 Then
		For $x In $Analizando
			If $b = 100 Then $b = 0
			$b = $b + 1
			GUICtrlSetData($BarraProgreso, $b)
			$ArchivoALeer = $UnidadA & $x
			If Not (GUICtrlGetState($lblInfo) = 96) Then GUICtrlSetData($lblInfo, "Analizando: [" & $ArchivoALeer & "]")
			Eventos()
			If AnalizarArchivo($ArchivoALeer) = 1 Then 
				_ArrayAdd($Detectados,$ArchivoALeer)
				GUICtrlSetData($LstInfectados,$ArchivoALeer)
			EndIf
		Next
	EndIf
	
	$FolderAnalizando = _FileListToArray($UnidadA, "*.*", 2)
	If Not @error = 1 Then
		For $z = 1 To $FolderAnalizando[0]
			$Ruta = $UnidadA & $FolderAnalizando[$z] & "\"
			Analizar($Ruta)
		Next
	EndIf
EndFunc   ;==>Analizar

Func Cancelar()
	If (MsgBox(36,"Cancelando...","Esta seguro de cancelar el analisis?")) = 6 Then
		GUICtrlSetData($lblInfo,"Analisis Cancelado")
		GUICtrlSetData($cmdAnalizar,"Analizar")
		GUICtrlSetData($BarraProgreso,0)
		Esperar()
	EndIf
EndFunc

Func Esperar()
	While 1
		Eventos()
	WEnd
EndFunc

Func Recuperar()
	$Programas = ""
	if BitAND(GUICtrlRead($chkMsConfig),$GUI_CHECKED) Then $Programas = $Programas & "MsConfig.exe (Configurador de Windows)" & @CRLF
	if BitAND(GUICtrlRead($chkNotepad),$GUI_CHECKED) Then $Programas = $Programas & "Notepad.exe (Editor de Textos)" & @CRLF
	if BitAND(GUICtrlRead($chkRegedit),$GUI_CHECKED) Then $Programas = $Programas & "Regedit.exe (Editor del registro)" & @CRLF
	if BitAND(GUICtrlRead($chkTaskMgr),$GUI_CHECKED) Then $Programas = $Programas & "TaskMgr.exe (Administrador de Procesos)" & @CRLF
	If $Programas <> "" Then
		If MsgBox(36,"Recuperar Aplicaciones","Va a restaurar los siguientes programas" & @CRLF & @CRLF & $Programas & @CRLF & "Desea Continuar?")=6 Then 
		if BitAND(GUICtrlRead($chkMsConfig),$GUI_CHECKED) Then FileCopy($APGDir & "\MsConfig.exe",@SystemDir & "\MsConfig.exe")
		if BitAND(GUICtrlRead($chkNotepad),$GUI_CHECKED) Then FileCopy($APGDir & "\Bloc.exe",@SystemDir & "\Notepad.exe")
		if BitAND(GUICtrlRead($chkRegedit),$GUI_CHECKED) Then FileCopy($APGDir & "\Regedit.exe",@SystemDir & "\Regedit.exe")
		if BitAND(GUICtrlRead($chkTaskMgr),$GUI_CHECKED) Then FileCopy($APGDir & "\ProcesosAntivenoM.exe",@SystemDir & "\TaskMgr.exe")
		MsgBox(64,"Ruperto","Se han recuperado las aplicaciones seleccionadas")
	EndIf
	Else
		MsgBox(16,"Error","No ha seleccionado ninguna aplicacion para recuperar")
	EndIf
EndFunc		

Func DetectVenoM($File)
	If FileExists($File) Then
		_ArrayAdd($Detectados, $File)
		GUICtrlSetData($LstInfectados,$File)
	EndIf
EndFunc   ;==>DetectVenoM

Func RastrosVenoM()
	DetectVenoM(@SystemDir & "\Drivers\Etc\Proceso inactivo del sistema.com")
	DetectVenoM(@SystemDir & "\Drivers\Etc\Proceso inactivo del sistema.com")
	DetectVenoM(@UserProfileDir & "\Plantillas\help.hta")
	DetectVenoM(@StartupDir & "\Win.scr")
	DetectVenoM(@UserProfileDir & "\VenoM.txt")
	DetectVenoM(@UserProfileDir & "\Autorun.inf")
	DetectVenoM(@UserProfileDir & "\Desktop.inf")
	DetectVenoM(@HomeDrive & "\Autorun.inf")
	DetectVenoM(@AppDataDir & "\Autorun.inf")
	DetectVenoM(@StartupDir & "\MS-DOS.pif")
	DetectVenoM(@StartupDir & "\VenoM.bat")
	DetectVenoM(@StartupDir & "\VenoM.vbs")
	$UniDef = DefinirUnidades()
	For $i In $UniDef
		If Not ($i = 0) Or Not ($i = "A:\") Then
			DetectVenoM($i & "\Autorun.inf")
			DetectVenoM($i & "\VenoM.666\Explorer.exe")
			DetectVenoM($i & "\VenoM.txt")
			DetectVenoM($i & "\Desktop.inf")
		EndIf
	Next

	$GameOver = _FileListToArray(@UserProfileDir & "\SendTo", "Game*.txt")
	If Not @error = 1 Then
		For $i = 1 To $GameOver[0]
			DetectVenoM(@UserProfileDir & "\SendTo\" & $GameOver[$i])
		Next
	EndIf
	For $i In $UniDef
		If Not $i = 0 Then
			BorrarCarpeta($i & "\System.volume.information")
			BorrarCarpeta($i & "\VenoM.666")
		EndIf
	Next
EndFunc   ;==>RastrosVenoM

Func BorrarArchivo($ArchivoB)
	If FileExists($ArchivoB) Then
		FileSetAttrib($ArchivoB, "-R-H")
		$Estado = FileDelete($ArchivoB)
		If $Estado = 0 Then
			_ArrayInsert($NoBorre, UBound($NoBorre), $ArchivoB)
		Else
			_ArrayInsert($SiBorre, UBound($SiBorre), $ArchivoB)
		EndIf
	EndIf
EndFunc   ;==>BorrarArchivo

Func BorrarCarpeta($Carpeta)
	If FileExists($Carpeta) Then
		FileSetAttrib($Carpeta, "-R-H")
		$Estado = FileRecycle($Carpeta)
		If $Estado = 0 Then
			_ArrayInsert($NoBorre, UBound($NoBorre), $Carpeta)
		Else
			_ArrayInsert($SiBorre, UBound($SiBorre), $Carpeta)
		EndIf
	EndIf
EndFunc   ;==>BorrarCarpeta

Func Desinfectar()
	GUICtrlSetData($lblInfo,"Desinfectando...")
	GUICtrlSetState($cmdAnalizar,$GUI_DISABLE)
	CerrarProcesos()
	FileCopy(@SystemDir & "\Hal.dll", @HomeDrive)
	FileSetAttrib(@HomeDrive & "\Hal.dll", "H")
	$TamDetect = UBound($Detectados) - 1
	For $i = 1 To $TamDetect
		GUICtrlSetData($BarraProgreso, $TamDetect / ($TamDetect - $i))
		If BitAND(GUICtrlRead($chkStopAndDestroy),$GUI_CHECKED) Then MatarProceso($Detectados[$i])
		BorrarArchivo($Detectados[$i])
	Next
	Registro($Version)
	FileSetAttrib(@WindowsDir, "-H", 1)
	If Not (UBound($NoBorre) = 0) Then
		For $b In $NoBorre
			BorrarArchivo($b)
		Next
	EndIf
	Recuperar()
	EscribeLog($Version, $SiBorre, $NoBorre, $LstInfectados)
	GUICtrlSetState($cmdAnalizar,$GUI_ENABLE)
	GUICtrlSetData($lblInfo,"Felicidades Su PC ha sido desinfectada del Virus VenoM!")
	GUICtrlSetData($BarraProgreso,100)
EndFunc   ;==>Desinfectar

Func ReiniciarYDesinfectar()
	If MsgBox(36,"Reinciar y Desinfectar","Esta funcion reiniciara su PC y la Desinfectará desea continuar ahora?")=6 Then
		RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx","TITLE","REG_SZ","Ruperto@ProgVisual.com")
		RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx\001","@","REG_SZ","APG AntiVenoM 6.1")
		RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx\001","1","REG_SZ",@HomeDrive & "\APG-AntiVenoM.Exe")
		if MsgBox(36,"Reiniciar","Se va a reinicar su PC ahora. ¿Desea continuar?")=6 Then 
			If FileCopy(@ScriptFullPath,@HomeDrive & "\APG-AntiVenoM.exe",1) = 1 Then
				MsgBox(64,"Reinciando PC ","Finalizando arbol de procesos para reiniciar su PC",4)
				Shutdown(6)
			Else
				MsgBox(36,"Error!","Error al copiar el archivo a la unidad: " & @HomeDrive & @CRLF & "Por favor reintentelo")
			EndIf
		EndIf
	EndIf
EndFunc

Func _AnalizarServicios()
$Procesos = _ProcessListProperties()
For $i = 1 to $Procesos[0][0]
	if AnalizarArchivo($Procesos[$i][5])=1 Then
		_ArrayAdd($Detectados,$Procesos[$i][5])
		GUICtrlSetData($LstInfectados,$Procesos[$i][5])
	EndIf	
Next
EndFunc