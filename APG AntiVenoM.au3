#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Description=Elimina Virus VenoM
#AutoIt3Wrapper_Res_Fileversion=5.2.0.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Ruperto 2008
#AutoIt3Wrapper_Res_Language=2058
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;Esta parte inicializa las librerias predefinidas
#include <GUIConstants.au3>
#include <File.au3>
#include <Array.au3>
#include <String.au3>
$Version = "APG AntiVenoM 5.7" ;guardamos La version del AntivenoM para no estarla escribiendo cada rato
Instalar()
Dim $Error = 0, $Msg
Dim $Pos, $Tam, $NAnalizados ;Guarda el Numero de Archivos Analizados
Dim $NDetectados ;Guarda el N˘mero de Archivos Detectados
Dim $NoBorre, $SiBorre ;Los archivos que no se pudieron borrar y los que si
Dim $GameOver ;Un Arreglo de unos archivos llamados "Game Over" creados por el VenoM
Dim $VReg, $b, $Unidades, $UniDef = _ArrayCreate(0)

$Detectados = _ArrayCreate(0) ;Creamos el Arreglo que guardara la ruta de los archivos detectados
;Enseguida creamos la Ventana que aparece; Con El Titulo...
$AntiVenoM = GUICreate($Version & " Por: Ruperto", 800, 320, -1, -1)
;enseguida comenzamos acrear todos los controles que se ven en la pantalla

GUICtrlCreateLabel("Unidad: ", 210, 13)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
$CmbUnidad = GUICtrlCreateCombo("Todas...", 260, 10, 80, -1)
GUICtrlSetFont(-1, 10, 800, "", "TAHOMA")
DefinirUnidades()
For $i In $UniDef
	If Not $i = 0 Then
		GUICtrlSetData($CmbUnidad, $i)
	EndIf
Next
;Ahora agregamos la Opcion "Todas..."
GUICtrlSetData($CmbUnidad, "Todas...")
$Analizar = GUICtrlCreateButton("Analizar Unidad Seleccionada", 345, 8, 220, 28)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")

GUICtrlCreateLabel("[Si no de desinfecta su PC Completamente, Reinicie y vuelva a intentarlo]", 170, 40, 500)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
GUICtrlSetColor(-1, 0xFF0000)

GUICtrlCreateLabel("Archivos Encontrados: ", 10, 55, 180)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
GUICtrlSetColor(-1, 0xFF0000)

$lstInfectados = GUICtrlCreateList("", 10, 70, 640, 190, -1)
GUICtrlSetBkColor(-1, 0xFFFACD)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
GUICtrlSetColor(-1, 0x0000FF)

GUICtrlCreateLabel("Archivos Analizados:", 10, 260, 150)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
GUICtrlSetColor(-1, 0x0000FF)

$IAnalizados = GUICtrlCreateLabel("0", 138, 260, 100)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
GUICtrlSetColor(-1, 0xFF0000)

GUICtrlCreateLabel("Archivos Detectados:", 200, 260, 150)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
GUICtrlSetColor(-1, 0x0000FF)

$IDetectados = GUICtrlCreateLabel("0", 334, 260, 100)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
GUICtrlSetColor(-1, 0xFF0000)

GUICtrlCreateLabel("Ruperto@progvisual.com", 440, 260, 170)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
GUICtrlSetColor(-1, 0x0000FF)

GUICtrlCreateLabel("Powered By: AutoIt v3.", 642, 260, 200)
GUICtrlSetFont(-1, 9, 800, "", "TAHOMA")
GUICtrlSetColor(-1, 0xFF0000)

$Archivos = GUICtrlCreateButton("Desinfectar.", 660, 70, 130, 35)
GUICtrlSetFont(-1, 10, 800, "", "TAHOMA")

$Registro = GUICtrlCreateButton("Limpiar Registro.", 660, 108, 130, 35)
GUICtrlSetFont(-1, 10, 800, "", "TAHOMA")

$cmdProcesos = GUICtrlCreateButton("Ver Procesos.", 660, 146, 130, 35)
GUICtrlSetFont(-1, 10, 800, "", "TAHOMA")

$cmdAbout = GUICtrlCreateButton("Acerca de...", 660, 184, 130, 35)
GUICtrlSetFont(-1, 10, 800, "", "TAHOMA")

$Salir = GUICtrlCreateButton("Salir.", 660, 222, 130, 35)
GUICtrlSetFont(-1, 10, 800, "", "TAHOMA")
$Barra = GUICtrlCreateProgress(10, 280, 780, 20)
$RDir = GUICtrlCreateLabel("Directorio: []", 10, 302, 480)
GUICtrlSetFont(-1, 10, 800, "", "TAHOMA")

$RFile = GUICtrlCreateLabel("Archivo: []", 500, 302, 290)
GUICtrlSetFont(-1, 10, 800, "", "TAHOMA")
GUISetState(@SW_SHOW)
;Programamos todos los eventos Posibles
Eventos()
Func Eventos()
	$Evento = 0
	While $Evento <> $GUI_EVENT_CLOSE

		$Evento = GUIGetMsg()
		Select
			Case $Evento = $GUI_EVENT_CLOSE
				Salida()
			Case $Evento = $cmdAbout
				MsgBox(0, $Version, $Version & " Ha sido creado por: Ruperto [Ruperto@progvisual.com]" & @CRLF & @CRLF & "              " & $Version & " Est· hecho en AutoIt v3. [www.autoit.es]" & @CRLF & @CRLF & "                                           Tepic, Nayarit. Mexico.")
			Case $Evento = $cmdProcesos
				If FileExists(@WindowsDir & "\APG\ProcesosAntiVenoM.exe") Then
					Run(@WindowsDir & "\APG\ProcesosAntiVenoM.exe")
				EndIf
			Case $Evento = $Salir
				Salida()
			Case $Evento = $Analizar
				$UnidadSel = GUICtrlRead($CmbUnidad)
				$UnidadSelM = StringUpper($UnidadSel)
				If Not $UnidadSel = "" Then ;Checamos si la Variable $UnidadSelM no esta Vacia
					If FileExists($UnidadSelM) Or $UnidadSelM = "Todas..." Then
						For $i = 0 To UBound($Detectados) - 1
							_ArrayDelete($Detectados, $i)
						Next
						GUICtrlSetData($lstInfectados, "") ;Vaciamos la lista de Archivos infectados, esa seccion Amarilla donde aparecen los archivos Detectados
						Deshabilitar("Cancelar Analisis");Ahora llamoamos a la funcion Deshabilitar
						GUICtrlSetState($Analizar, $GUI_ENABLE)
						$NAnalizados = 0
						$NDetectados = 0
						If $UnidadSelM = "Todas..." Then ;Entonces hacemos un ciclo en el que llamamos a la funcion Analizar, en cada Unidad.
							For $i In $UniDef
								If Not $i = 0 Then
									If Not ($i = "A:\") Then Analizar($i)
								EndIf
							Next
							RastrosVenoM()
						Else ;Por el Contrario
							Analizar($UnidadSelM)
							RastrosVenoM()
						EndIf
						GUICtrlSetData($Barra, 100)
						Habilitar("Analizar Unidad Seleccionada")
						$Tam = UBound($Detectados)
						If $Tam = 1 And Not $UnidadSelM = "CODIGO" Then
							MsgBox(0, $Version, "La Unidad analizada se encuentra Limpia ")
						EndIf
						GUICtrlSetData($IAnalizados, $NAnalizados)
						GUICtrlSetData($IDetectados, $NDetectados)
					EndIf
				EndIf
				
			Case $Evento = $Registro ;Si se presiona el Boton registro llamamos a la Funcion Registro (Programa mas abajo)
				Registro()
			Case $Evento = $Archivos
				Desinfectar()
		EndSelect
	WEnd
EndFunc   ;==>Eventos

Func Analizar(ByRef $UnidadA)
	$Analizando = Files2Array($UnidadA, "*.exe;*.scr;*.dll")
	GUICtrlSetData($IAnalizados, $NAnalizados)
	GUICtrlSetData($IDetectados, $NDetectados)
	If $Error = 0 Then
		For $x In $Analizando
			If $b = 100 Then $b = 0
			$b = $b + 1
			GUICtrlSetData($Barra, $b)
			GUICtrlSetData($RDir, "Directorio: [" & $UnidadA & "]")
			GUICtrlSetData($RFile, "Archivo: [" & $x & "]")
			$NAnalizados = $NAnalizados + 1
			$Lec = FileReadLine($UnidadA & $x, 39)
			If ($Lec = "–nÔ8uáÅ;]'â) ∞dh	Ù,]«#¸à`,‡VY√3<>¸LB˘>‚ó{ñÍÉÎ#›ÎiµñØ∆î" Or $Lec = "Õ¨Ñ9Ãl4÷L§ñ~ì") Then
				GUICtrlSetData($lstInfectados, $UnidadA & $x)
				$NDetectados = $NDetectados + 1
				_ArrayInsert($Detectados, $i, $UnidadA & $x)
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

Func Registro() ;Esta es la funcion registro, que Limpia el registro de Windows
	RunWait(@WindowsDir & "\APG\Registro.exe")
	$Resp = MsgBox(4, $Version, $Version & " Cerrar· Todas las Ventanas de Windows, Para Actualizar Configuraciones" & @CRLF & "øDesea Continuar?")
	If $Resp = 6 Then ;Si Responde "SI"
		Dim $KeyName
		$KeyName = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\"
		RegDelete($KeyName, "CFTMON.EXE")
		RegDelete($KeyName, "Syslog")
		RegDelete($KeyName, "CFTMON.EXE")
		RegWrite("HKLM\Software\Microsoft\Windows NT\CurrentVersion\WinLogon\", "Shell", "REG_SZ", "Explorer.exe")
		;Ahora se habilitan algunas funcionas que deshabilita el VenoM
		$KeyName = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\"
		RegDelete($KeyName & "Explorer", "NoFolderOptions")
		RegDelete($KeyName & "System", "DisableRegistryTools")
		RegDelete($KeyName & "System", "DisableTaskMgr")
		RegDelete($KeyName & "System", "DisableCMD")
		$KeyName = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\"
		RegWrite($KeyName & "policies\Explorer", "NoDriveTypeAutoRun", "REG_DWORD", "255")
		RegWrite($KeyName & "Explorer\Advanced", "HideFileExt", "REG_DWORD", 0)
		;Limpiar el registro en "HKEY_CURRENT_USER"
		$KeyName = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\"
		RegDelete($KeyName & "DisallowRun\")
		RegDelete($KeyName, "DisallowRun")
		RegWrite("HKEY_CLASSES_ROOT\regfile\shell\open\command\", "", "REG_SZ", "regedit.exe ""%1""")
		RegDelete($KeyName, "NoFind")
		RegDelete($KeyName, "NoResolveSearch")
		RegDelete($KeyName, "NoResolveTrack")
		RegDelete($KeyName, "NoFolderOptions")
		RegDelete($KeyName, "NoPropertiesMyComputer")
		RegDelete($KeyName, "NoRecicleFyles")
		RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System\", "DisableTaskMgr")
		RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Run\", "CTFMON.EXE")
		$KeyName = "HKCU\Software\Microsoft\Windows NT\"
		RegDelete($KeyName & "CurrentVersion\WinLogon\", "Shell")
		RegDelete($KeyName & "SystemRestore\", "DisableConfig")
		RegDelete($KeyName & "SystemRestore\", "DisableSR")
		;Limpiar el registro en "HKEY_LOCAL_MACHINE"
		$KeyName = "HKLM\Software\Microsoft\Windows\CurrenteVersion\App Paths\"
		RegDelete("HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\", "NoFind")
		RegDelete("HKLM\Software\Microsoft\Windows\CurrentVersion\Run\", "CTFMON.EXE")
		Run(@WindowsDir & "\Regedit.exe /S " & @WindowsDir & "\APG\AntiVenoM.reg")
		ProcessClose("Explorer.exe")
		ProcessClose("Explorer.exe") ;Por si las dudas
		Run("Explorer.exe")
		MsgBox(0, $Version, "He Terminado de limpiar el Registro de Windows")
	EndIf
	$Resp = 0
EndFunc   ;==>Registro

Func Desinfectar()
	Deshabilitar("Desinfectando...")
	FileCopy(@SystemDir & "\Hal.dll", @HomeDrive)
	FileSetAttrib(@HomeDrive & "\Hal.dll", "H")
	$TamDetect = UBound($Detectados) - 1
	For $i = 1 To $TamDetect
		GUICtrlSetData($Barra, $TamDetect / ($TamDetect - $i))
		MatarProceso($Detectados[$i])
		BorrarArchivo($Detectados[$i])
	Next
	Registro()
	For $i In $UniDef
		If Not $i = 0 Then
			BorrarCarpeta($i & "\System.volume.information")
			BorrarCarpeta($i & "\VenoM.666")
		EndIf
	Next
	FileSetAttrib(@WindowsDir, "-H", 1)
	FileCopy(@WindowsDir & "\APG\ProcesosAntiVenoM.exe", @SystemDir & "\Taskmgr.exe", 1)
	EscribeLog()
	Habilitar("Analizar Unidad Seleccionada")
EndFunc   ;==>Desinfectar

Func EscribeLog()
	Dim $Log
	$Log = FileOpen(@DesktopDir & "\AntiVenoM-Log.txt", 10)
	FileWrite($Log, "                                " & $Version & " por: Ruperto [Ruperto@progvisual.com]                             " & @CRLF)
	FileWrite($Log, "____________________________________________________________________________________________________________________" & @CRLF & @CRLF)
	FileWrite($Log, "Se han Habilitado las siguientes funciones de windows" & @CRLF)
	FileWrite($Log, "*Administrador de Tareas (Procesos)" & @CRLF)
	FileWrite($Log, "*Registro de Windows" & @CRLF)
	FileWrite($Log, "*Ignorar 'Autorun.inf' en dispositivos extraibles" & @CRLF)
	FileWrite($Log, "*Se ha recuperado el Bloc de Notas" & @CRLF)
	FileWrite($Log, "*Reparado el Men˙: 'Abrir con..." & @CRLF)
	FileWrite($Log, "*La Busqueda de Archivos se ha habilitado" & @CRLF)
	FileWrite($Log, "*Habilitada la Funcion de 'Enviar a la papelera de Reciclaje" & @CRLF)
	FileWrite($Log, "*Habilitado Propiedades de Mi PC" & @CRLF)
	FileWrite($Log, "_____________________________________________________________________________________________________________________" & @CRLF & @CRLF)
	FileWrite($Log, "Powered By AutoIt v3 - http://www.autoit.es  " & @CRLF)
	FileWrite($Log, "_____________________________________________________________________________________________________________________" & @CRLF & @CRLF)
	FileWrite($Log, "_____________________________________________________________________________________________________________________" & @CRLF)
	FileWrite($Log, "Se ha hecho una copia de seguridad del Archivo Hal.dll en '" & @HomeDrive & "\' (Se encuentra Oculto)_______________________________" & @CRLF)
	FileWrite($Log, "_____________________________________________________________________________________________________________________" & @CRLF)
	If $NoBorre = "" And Not $SiBorre = "" Then
		FileWrite($Log, "Los siguientes archivos se han eliminado Correctamente: " & @CRLF & $SiBorre)
	ElseIf Not $NoBorre = "" And $SiBorre = "" Then
		FileWrite($Log, "Los siguientes archivos no se han podido eliminar: " & @CRLF & $NoBorre)
	ElseIf Not $NoBorre = "" And Not $SiBorre = "" Then
		FileWrite($Log, "Los siguientes archivos se han elimnado Correctamente: " & @CRLF & $SiBorre & @CRLF & @CRLF & "Los Siguientes archivos no se han podido eliminar. Por favor vuelva e ejecutarme para reintentarlo:" & @CRLF & @CRLF & $NoBorre)
	EndIf
	FileClose($Log)
	GUICtrlSetData($lstInfectados, "") ;Limpiar el ListBox
	;Abrimos el Archivo que acabamos de crear
	Run(@WindowsDir & "\Notepad.exe " & @DesktopDir & "\AntiVenoM-Log.txt")
EndFunc   ;==>EscribeLog

Func Salida() ;Esta es la funcion que cierra el programa
	$Resps = MsgBox(36, $Version, "øDesea Salir ahora de la aplicaciÛn?")
	If $Resps = 6 Then
		DirRemove(@WindowsDir & "\APG\", 1)
		Exit
	Else
		$Evento = 0
		Eventos()
	EndIf
EndFunc   ;==>Salida

Func DetectVenoM($File)
	If FileExists($File) Then
		_ArrayInsert($Detectados, UBound($Detectados), $File)
	EndIf
EndFunc   ;==>DetectVenoM

Func RastrosVenoM()
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
EndFunc   ;==>RastrosVenoM

Func Instalar()
	ProgressOn($Version & " Iniciando Aplicacion", "0 porcentaje", 250, 250, 18)
	ProgressSet(15, "Creando directorio de trabajo Temporal", "16 porcentaje")
	DirCreate(@WindowsDir & "\APG\")
	ProgressSet(15 * 2, "Extrayendo Archivo AntiVenoM.reg", 15 * 2 & " porcentaje")
	FileInstall("G:\Proyectos\AutoIt\AntiVenoM\AntiVenoM Code\Recursos\AntiVenoM.reg", @WindowsDir & "\APG\AntiVenoM.reg", 1)
	ProgressSet(15 * 3, "Extrayendo Archivo Notepad.exe", 15 * 3 & " porcentaje")
	FileInstall("G:\Proyectos\AutoIt\AntiVenoM\AntiVenoM Code\Recursos\Notepad.exe", @WindowsDir & "\Notepad.exe", 1)
	ProgressSet(15 * 5, "Extrayendo Archivo ProcesosAntiVenoM.exe (Administrador de Tareas)", 15 * 5 & " porcentaje")
	FileInstall("G:\Proyectos\AutoIt\AntiVenoM\AntiVenoM Code\Recursos\Taskmgr.exe", @WindowsDir & "\APG\ProcesosAntiVenoM.exe", 1)
	ProgressSet(15 * 6, "Extrayendo Archivo 'MSConfig.exe'", 15 * 3 & " porcentaje")
	FileInstall("G:\Proyectos\AutoIt\AntiVenoM\AntiVenoM Code\Recursos\msconfig.exe", @SystemDir & "\msconfig.exe", 1)
	FileInstall("G:\Proyectos\AutoIt\AntiVenoM\AntiVenoM Code\Recursos\Registro.exe", @WindowsDir & "\APG\Registro.exe", 1)
	ProgressSet(15 * 7 - 5, "Iniciando Aplicacion " & $Version, 15 * 7 - 5 & " porcentaje")
	ProgressOff()
EndFunc   ;==>Instalar

Func Deshabilitar($Estatus)
	GUICtrlSetData($Analizar, $Estatus)
	GUICtrlSetState($CmbUnidad, $GUI_DISABLE)
	GUICtrlSetState($Salir, $GUI_DISABLE)
	GUICtrlSetState($Archivos, $GUI_DISABLE)
	GUICtrlSetState($Registro, $GUI_DISABLE)
	GUICtrlSetState($Analizar, $GUI_DISABLE)
	GUICtrlSetState($cmdAbout, $GUI_DISABLE)
	GUICtrlSetState($cmdProcesos, $GUI_DISABLE)
EndFunc   ;==>Deshabilitar

Func Habilitar($Estatus)
	;La Funcion  que habilita los controles del Formulario
	GUICtrlSetState($Salir, $GUI_ENABLE)
	GUICtrlSetData($Analizar, $Estatus)
	GUICtrlSetState($Archivos, $GUI_ENABLE)
	GUICtrlSetState($Registro, $GUI_ENABLE)
	GUICtrlSetState($CmbUnidad, $GUI_ENABLE)
	GUICtrlSetState($Analizar, $GUI_ENABLE)
	GUICtrlSetState($cmdAbout, $GUI_ENABLE)
	GUICtrlSetState($cmdProcesos, $GUI_ENABLE)
EndFunc   ;==>Habilitar

Func BorrarArchivo($ArchivoB)
	If FileExists($ArchivoB) Then
		FileSetAttrib($ArchivoB, "-R-H")
		$Estado = FileDelete($ArchivoB)
		If $Estado = 0 Then
			If $NoBorre = "" Then
				$NoBorre = $ArchivoB
			Else
				$NoBorre = $NoBorre & @CRLF & $ArchivoB
			EndIf
		Else
			If $SiBorre = "" Then
				$SiBorre = $ArchivoB
			Else
				$SiBorre = $SiBorre & @CRLF & $ArchivoB
			EndIf
		EndIf
	EndIf
EndFunc   ;==>BorrarArchivo

Func BorrarCarpeta($Carpeta)
	If FileExists($Carpeta) Then
		FileSetAttrib($Carpeta, "-R-H")
		$Estado = FileRecycle($Carpeta)
		If $Estado = 0 Then
			If $NoBorre = "" Then
				$NoBorre = $Carpeta
			Else
				$NoBorre = $NoBorre & @CRLF & $Carpeta
			EndIf
		Else
			If $SiBorre = "" Then
				$SiBorre = $Carpeta
			Else
				$SiBorre = $SiBorre & @CRLF & $Carpeta
			EndIf
		EndIf
	EndIf
EndFunc   ;==>BorrarCarpeta

Func MatarProceso($Archivo)
	$Pos = StringInStr($Archivo, "\", 0, -1)
	$Tam = StringLen($Archivo)
	$Archivo = StringRight($Archivo, $Tam - $Pos)
	ProcessClose($Archivo)
	ProcessClose($Archivo)
	ProcessClose($Archivo)
EndFunc   ;==>MatarProceso

Func DefinirUnidades()
	$UniDef = _ArrayCreate(10)
	$Unidades = DriveGetDrive("ALL")
	If Not @error Then
		For $Disco = 1 To $Unidades[0]
			$Tipo = DriveGetType($Unidades[$Disco])
			If $Tipo = "FIXED" Or $Tipo = "REMOVABLE" Or $Tipo = "NETWORK" Then
				$Unidad = StringUpper($Unidades[$Disco]) & "\"
				If DriveStatus($Unidad) = "READY" Then
					_ArrayInserts($UniDef, $Disco, $Unidad)
				EndIf
			EndIf
		Next
		_ArrayDelete($UniDef, 0)
	EndIf
EndFunc   ;==>DefinirUnidades

Func Files2Array($Dir, $Filtro = "*")
	Local $hSearch, $sFile, $asFileList = _ArrayCreate(0), $NN = 0
	If Not FileExists($Dir) Then Return SetError(1, 1, "")
	$Exts = StringSplit($Filtro, ";")
	For $i = 1 To $Exts[0]
		$Filtro = $Exts[$i]
		$hSearch = FileFindFirstFile($Dir & "\" & $Filtro)
		While 1
			$Msg = GUIGetMsg()
			If ($Msg = $Analizar) Then
				If (MsgBox(36, "Cancelar?", "øEsta seguro de cancelar el proceso del analisis?")) = 6 Then
					Habilitar("Analizar Unidad Seleccionada")
					GUICtrlSetData($Barra, 0)
					GUICtrlSetData($RDir, "Directorio: []")
					GUICtrlSetData($RFile, "Archivo: []")
					Eventos()
				EndIf
			EndIf
			$sFile = FileFindNextFile($hSearch)
			If @error Then
				SetError(0)
				ExitLoop
			EndIf
			If StringInStr(FileGetAttrib($Dir & "\" & $sFile), "D") = 0 Then
				_ArrayInsert($asFileList, UBound($asFileList) - 1, $sFile)
				$NN = $NN + 1
			EndIf
		WEnd
	Next
	FileClose($hSearch)
	_ArrayDelete($asFileList, UBound($asFileList))
	If ($NN = 0) Then $Error = 1
	If ($NN <> 0) Then $Error = 0
	Return $asFileList
EndFunc   

Func _ArrayInserts(ByRef $avArray, $iElement, $vValue = "")
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	Local $iUBound = UBound($avArray) + 1
	ReDim $avArray[$iUBound]
	For $i = $iUBound - 1 To $iElement + 1 Step -1
		$avArray[$i] = $avArray[$i - 1]
	Next
	ReDim $avArray[$iElement + 1]
	$avArray[$iElement] = $vValue
	Return $iUBound
EndFunc

                                                                                                                                                                                                                                                                                 