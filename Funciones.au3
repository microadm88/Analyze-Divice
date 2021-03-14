#include <GUIConstantsEx.au3>
#include <Array.au3>

Dim $VERSION, $APGDIR = @TempDir & "\Ruperto"
Func DEFINIRUNIDADES()
	$UNIDEF = _ARRAYCREATE(0)
	$UNIDADES = DriveGetDrive("ALL")
	If Not @error Then
		For $DISCO = 1 To $UNIDADES[0]
			$TIPO = DriveGetType($UNIDADES[$DISCO])
			If $TIPO = "FIXED" Or $TIPO = "REMOVABLE" Or $TIPO = "NETWORK" Then
				$UNIDAD = StringUpper($UNIDADES[$DISCO]) & "\"
				If DriveStatus($UNIDAD) = "READY" Then
					_ArrayAdd($UNIDEF, $UNIDAD)
				EndIf
			EndIf
		Next
		_ArrayDelete($UNIDEF, 0)
	EndIf
	Return $UNIDEF
EndFunc
Func REGISTRO($VERSION, $FRM)
	$RESP = MsgBox(4, $VERSION, $VERSION & " Cerrar· Todas las Ventanas de Windows, Para Actualizar Configuraciones" & @CRLF & "øDesea Continuar?", "", $FRM)
	If $RESP = 6 Then
		ProcessClose("Explorer.exe")
		ProcessClose("Explorer.exe")
		ProcessClose("Explorer.exe")
		RunWait($APGDIR & "\Registro.exe")
		Dim $KEYNAME
		$KEYNAME = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\"
		RegDelete($KEYNAME, "CFTMON.EXE")
		RegDelete($KEYNAME, "Syslog")
		RegDelete($KEYNAME, "CFTMON.EXE")
		RegWrite("HKLM\Software\Microsoft\Windows NT\CurrentVersion\WinLogon\", "Shell", "REG_SZ", "Explorer.exe")
		$KEYNAME = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\"
		ProcessClose("Explorer.exe")
		RegDelete($KEYNAME & "Explorer", "NoFolderOptions")
		RegDelete($KEYNAME & "System", "DisableRegistryTools")
		RegDelete($KEYNAME & "System", "DisableTaskMgr")
		RegDelete($KEYNAME & "System", "DisableCMD")
		$KEYNAME = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\"
		RegWrite($KEYNAME & "policies\Explorer", "NoDriveTypeAutoRun", "REG_DWORD", "255")
		RegWrite($KEYNAME & "Explorer\Advanced", "HideFileExt", "REG_DWORD", 0)
		$KEYNAME = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\"
		RegDelete($KEYNAME & "DisallowRun\")
		RegDelete($KEYNAME, "DisallowRun")
		ProcessClose("Explorer.exe")
		RegWrite("HKEY_CLASSES_ROOT\regfile\shell\open\command\", "@", "REG_SZ", 'regedit.exe "%1"')
		RegDelete($KEYNAME, "NoFind")
		RegDelete($KEYNAME, "NoResolveSearch")
		RegDelete($KEYNAME, "NoResolveTrack")
		RegDelete($KEYNAME, "NoFolderOptions")
		RegDelete($KEYNAME, "NoPropertiesMyComputer")
		RegDelete($KEYNAME, "NoRecicleFyles")
		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\", "NoPropertiesRecycleBin", "REG_DWORD", 0)
		RegWrite("HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\", "NoPropertiesRecycleBin", "REG_DWORD", 0)
		RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System\", "DisableTaskMgr")
		RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Run\", "CTFMON.EXE")
		$KEYNAME = "HKCU\Software\Microsoft\Windows NT\"
		RegDelete($KEYNAME & "CurrentVersion\WinLogon\", "Shell")
		RegDelete($KEYNAME & "SystemRestore\", "DisableConfig")
		RegDelete($KEYNAME & "SystemRestore\", "DisableSR")
		ProcessClose("Explorer.exe")
		$KEYNAME = "HKLM\Software\Microsoft\Windows\CurrenteVersion\App Paths\"
		RegDelete("HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\", "NoFind")
		RegDelete("HKLM\Software\Microsoft\Windows\CurrentVersion\Run\", "CTFMON.EXE")
		RegWrite("HKEY_CURRENT_USER\Control Panel\Mouse\", "SwapMouseButtons", "REG_SZ", 0)
		Run($APGDIR & "\Regedit.exe /S " & $APGDIR & "\AntiVenoM.reg")
		Run("Explorer.exe")
	EndIf
	$RESP = 0
EndFunc
Func INSTALAR()
	ProgressOn($VERSION & " Iniciando Aplicacion", "0 porcentaje", 250, 250, 18)
	ProgressSet(15, "Creando directorio de trabajo Temporal", "16 porcentaje")
	DirCreate($APGDIR)
	ProgressSet(15 * 2, "Extrayendo Archivo AntiVenoM.reg", 15 * 2 & " porcentaje")
	FileInstall("Recursos\AntiVenoM.reg", $APGDIR & "\AntiVenoM.reg", 1)
	ProgressSet(15 * 3, "Extrayendo Archivo Notepad.exe", 15 * 3 & " porcentaje")
	FileInstall("Recursos\Notepad.exe", $APGDIR & "\Bloc.exe", 1)
	FileInstall("Recursos\Regedit.exe", $APGDIR & "\Regedit.exe", 1)
	ProgressSet(15 * 5, "Extrayendo Archivo ProcesosAntiVenoM.exe (Administrador de Tareas)", 15 * 5 & " porcentaje")
	FileInstall("Recursos\Taskmgr.exe", $APGDIR & "\ProcesosAntiVenoM.exe", 1)
	ProgressSet(15 * 6, "Extrayendo Archivo 'MSConfig.exe'", 15 * 3 & " porcentaje")
	FileInstall("Recursos\msconfig.exe", $APGDIR & "\msconfig.exe", 1)
	FileInstall("Recursos\Registro.exe", $APGDIR & "\Registro.exe", 1)
	FileInstall("Recursos\Fondo2.jpg", $APGDIR & "\Fondo2.jpg", 1)
	ProgressSet(15 * 7 - 5, "Iniciando Aplicacion " & $VERSION, 15 * 7 - 5 & " porcentaje")
	ProgressOff()
EndFunc

Func OCULTAR($CONTROL)
	GUICtrlSetState($CONTROL, $GUI_HIDE)
EndFunc
Func MOSTRAR($CONTROL)
	GUICtrlSetState($CONTROL, $GUI_SHOW)
EndFunc
Func ANALIZARARCHIVO($ARCHIVOALEER)
	If _LEERARCHIVO($ARCHIVOALEER, 39) = "–nÔ8uáÅ;]'â) ∞dh	Ù,]«#¸à`,‡VY√3<>¸LB˘>‚ó{ñÍÉÎ#›ÎiµñØ∆î" Or _LEERARCHIVO($ARCHIVOALEER, 39) = "Õ¨Ñ9Ãl4÷L§ñ~ì" Or _LEERARCHIVO($ARCHIVOALEER, 49) = 'ãPËŒÂˇˇâãäÑ€tÄ˚ vÈãÄ8"u' Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc
Func _LEERARCHIVO($ARCHIVO, $LINEA)
	$ARCHIVOALEER = FileOpen($ARCHIVO, 0)
	$LEC = FileReadLine($ARCHIVOALEER, $LINEA)
	FileClose($ARCHIVOALEER)
	Return $LEC
EndFunc
Func CERRARPROCESOS()
	ProcessClose("mshta.exe")
	ProcessClose("mshta.exe")
	ProcessClose("cmd.exe")
	ProcessClose("cmd.exe")
	ProcessClose("cmd.exe")
	ProcessClose("cmd.exe")
EndFunc
Func MATARPROCESO($ARCHIVO)
	$POS = StringInStr($ARCHIVO, "\", 0, -1)
	$TAM = StringLen($ARCHIVO)
	$ARCHIVO = StringRight($ARCHIVO, $TAM - $POS)
	ProcessClose($ARCHIVO)
	ProcessClose($ARCHIVO)
	ProcessClose($ARCHIVO)
EndFunc
Func COMPROBARUNIDAD($SUNIDAD)
	If FileExists($SUNIDAD) Then
		Return $SUNIDAD
	Else
		Return 0
	EndIf
EndFunc
Func ESCRIBELOG($VERSION, $SIBORRE, $NOBORRE, $LSTINFECTADOS)
	Dim $LOG
	$LOG = FileOpen(@DesktopDir & "\AntiVenoM-Log.txt", 10)
	FileWrite($LOG, "                                " & $VERSION & " por: Ruperto [rupert.25@gmail.com]                             " & @CRLF)
	FileWrite($LOG, "____________________________________________________________________________________________________________________" & @CRLF & @CRLF)
	FileWrite($LOG, "Se han Habilitado las siguientes funciones de windows" & @CRLF)
	FileWrite($LOG, "*Administrador de Tareas (Procesos)" & @CRLF)
	FileWrite($LOG, "*Registro de Windows" & @CRLF)
	FileWrite($LOG, "*Ignorar 'Autorun.inf' en dispositivos extraibles" & @CRLF)
	FileWrite($LOG, "*Se ha recuperado el Bloc de Notas" & @CRLF)
	FileWrite($LOG, "*Reparado el Men˙: 'Abrir con..." & @CRLF)
	FileWrite($LOG, "*La Busqueda de Archivos se ha habilitado" & @CRLF)
	FileWrite($LOG, "*Habilitada la Funcion de 'Enviar a la papelera de Reciclaje" & @CRLF)
	FileWrite($LOG, "*Habilitado Propiedades de Mi PC" & @CRLF)
	FileWrite($LOG, "_____________________________________________________________________________________________________________________" & @CRLF & @CRLF)
	FileWrite($LOG, "Powered By AutoIt v3 - http://www.autoit.es  " & @CRLF)
	FileWrite($LOG, "_____________________________________________________________________________________________________________________" & @CRLF & @CRLF)
	FileWrite($LOG, "_____________________________________________________________________________________________________________________" & @CRLF)
	FileWrite($LOG, "Se ha hecho una copia de seguridad del Archivo Hal.dll en '" & @HomeDrive & "\' (Se encuentra Oculto)_______________________________" & @CRLF)
	FileWrite($LOG, "_____________________________________________________________________________________________________________________" & @CRLF)
	$TAMBORRADOS = UBound($SIBORRE) - 1
	$TAMNOBORRADOS = UBound($NOBORRE) - 1
	If $TAMNOBORRADOS = 0 And Not $TAMBORRADOS = 0 Then
		FileWrite($LOG, "Los siguientes archivos se han eliminado Correctamente: " & @CRLF)
		ARREGLOAARCHIVO($LOG, $SIBORRE)
	ElseIf Not $TAMNOBORRADOS = 0 And $TAMBORRADOS = 0 Then
		FileWrite($LOG, "Los siguientes archivos no se han podido eliminar: " & @CRLF)
		ARREGLOAARCHIVO($LOG, $NOBORRE)
	ElseIf Not $TAMNOBORRADOS = 0 And Not $TAMBORRADOS = 0 Then
		FileWrite($LOG, "Los siguientes archivos se han eliminado Correctamente: " & @CRLF)
		ARREGLOAARCHIVO($LOG, $SIBORRE)
		FileWrite($LOG, "Los siguientes archivos No se han podido eliminar: " & @CRLF)
		ARREGLOAARCHIVO($LOG, $NOBORRE)
	EndIf
	FileClose($LOG)
	GUICtrlSetData($LSTINFECTADOS, "")
	Run($APGDIR & "\Bloc.exe " & @DesktopDir & "\AntiVenoM-Log.txt")
EndFunc
Func ARREGLOAARCHIVO($SARCHIVO, $SARREGLO)
	For $A = 1 To UBound($SARREGLO) - 1
		FileWrite($SARCHIVO, $SARREGLO[$A] & @CRLF)
	Next
EndFunc
Func _VALIDARSO()
	If @OSVersion <> "WIN_XP" Then
		If MsgBox(36, "Windows", "Su sistema operativo es: " & @OSVersion & ", Y Este programa est· diseÒado para Windows XP" & @CRLF & "Aun asÌ desea continuar?") <> 6 Then
			Exit
		EndIf
	EndIf
EndFunc
Func _VERPROCESOS()
	If FileExists($APGDIR & "\ProcesosAntiVenoM.exe") Then Run($APGDIR & "\ProcesosAntiVenoM.exe")
EndFunc
Func _PROCESSLISTPROPERTIES($PROCESS = "", $SCOMPUTER = ".")
	Local $SUSERNAME, $SMSG, $SUSERDOMAIN, $AVPROCS, $DTMDATE
	Local $AVPROCS[1][2] = [[0, ""]], $N = 1
	If StringIsInt($PROCESS) Then $PROCESS = Int($PROCESS)
	$OWMI = ObjGet("winmgmts:{impersonationLevel=impersonate,authenticationLevel=pktPrivacy}!\\" & $SCOMPUTER & "\root\cimv2")
	If IsObj($OWMI) Then
		If $PROCESS = "" Then
			$COLPROCS = $OWMI.ExecQuery("select * from win32_process")
		ElseIf IsInt($PROCESS) Then
			$COLPROCS = $OWMI.ExecQuery("select * from win32_process where ProcessId = " & $PROCESS)
		Else
			$COLPROCS = $OWMI.ExecQuery("select * from win32_process where Name = '" & $PROCESS & "'")
		EndIf
		If IsObj($COLPROCS) Then
			If $COLPROCS.count = 0 Then Return $AVPROCS
			ReDim $AVPROCS[$COLPROCS.count + 1][10]
			$AVPROCS[0][0] = UBound($AVPROCS) - 1
			For $OPROC In $COLPROCS
				$AVPROCS[$N][0] = $OPROC.name
				$AVPROCS[$N][1] = $OPROC.ProcessId
				$AVPROCS[$N][2] = $OPROC.ParentProcessId
				If $OPROC.GetOwner($SUSERNAME, $SUSERDOMAIN) = 0 Then $AVPROCS[$N][3] = $SUSERDOMAIN & "\" & $SUSERNAME
				$AVPROCS[$N][4] = $OPROC.Priority
				$AVPROCS[$N][5] = $OPROC.ExecutablePath
				$DTMDATE = $OPROC.CreationDate
				If $DTMDATE <> "" Then
					Local $SREGEXPPATT = "\A(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})(?:.*)"
					$DTMDATE = StringRegExpReplace($DTMDATE, $SREGEXPPATT, "$2/$3/$1 $4:$5:$6")
				EndIf
				$AVPROCS[$N][8] = $DTMDATE
				$AVPROCS[$N][9] = $OPROC.CommandLine
				$N += 1
			Next
		Else
			SetError(2)
		EndIf
		$COLPROCS = 0
		Local $OREFRESHER = ObjCreate("WbemScripting.SWbemRefresher")
		$COLPROCS = $OREFRESHER.AddEnum($OWMI, "Win32_PerfFormattedData_PerfProc_Process" ).objectSet
		$OREFRESHER.Refresh
		Local $ITIME = TimerInit()
		Do
			Sleep(20)
		Until TimerDiff($ITIME) >= 100
		$OREFRESHER.Refresh
		For $OPROC In $COLPROCS
			For $N = 1 To $AVPROCS[0][0]
				If $AVPROCS[$N][1] = $OPROC.IDProcess Then
					$AVPROCS[$N][6] = $OPROC.PercentProcessorTime
					$AVPROCS[$N][7] = $OPROC.WorkingSet
					ExitLoop
				EndIf
			Next
		Next
	Else
		SetError(1)
	EndIf
	Return $AVPROCS
EndFunc