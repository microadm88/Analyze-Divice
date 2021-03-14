;Esta parte inicializa las librerias predefinidas#include <GUIConstants.au3>
#include <File.au3>
#include <Array.au3>
#Include <String.au3>
#include <GUIConstantsEx.au3>

$Version = "APG AntiVirus v0.1 Beta"
Instalar()
Dim $Error=0
Dim $Pos, $Tam, $NAnalizados ;Guarda el Numero de Archivos Analizados
Dim $NDetectados ;Guarda el N˘mero de Archivos Detectados
Dim $NoBorre, $SiBorre  ;Los archivos que no se pudieron borrar y los que si
Dim $GameOver ;Un Arreglo de unos archivos llamados "Game Over" creados por el VenoM
Dim $VReg, $b, $Unidades, $UniDef= _ArrayCreate(0)
$Analizando = _ArrayCreate(0)
$Detectados = _ArrayCreate(0) ;Creamos el Arreglo que guardara la ruta de los archivos detectados
$AntiVenoM = GUICreate($Version & " Por: Ruperto",800,320,-1,-1)

GUICtrlCreateLabel("Unidad: ",210,13)
GUICtrlSetFont (-1,9, 800, "", "TAHOMA")
$CmbUnidad = GUICtrlCreateCombo ("Todas...", 260,10,80, -1)
GUICtrlSetFont (-1,10, 800, "", "TAHOMA")
DefinirUnidades()
For $i In $UniDef
	if not $i = 0 Then
		GUICtrlSetData($cmbUnidad,$i)
	EndIf
Next

GUICtrlSetData($cmbUnidad,"Todas...")
$Analizar = GUICtrlCreateButton("Analizar Unidad Seleccionada",345,8,220,28)
GUICtrlSetFont (-1,9, 800, "", "TAHOMA")

GUICtrlCreateLabel("[Si no de desinfecta su PC Completamente, Reinicie y vuelva a intentarlo]",170,40,500)
GUICtrlSetFont (-1,9, 800, "", "TAHOMA")
GUICtrlSetColor(-1,0xFF0000)

GUICtrlCreateLabel("Archivos Encontrados: ",10,55,180)
GUICtrlSetFont (-1,9, 800, "", "TAHOMA")
GUICtrlSetColor(-1,0xFF0000)

$lstInfectados = GUICtrlCreateList("",10,70,640,190,-1)
GUICtrlSetBkColor(-1,0xFFFACD)
GUICtrlSetFont (-1,9, 800, "", "TAHOMA")
GUICtrlSetColor(-1,0x0000FF)

GUICtrlCreateLabel("Archivos Analizados:",10,260,150)
GUICtrlSetFont (-1,9, 800, "", "TAHOMA")
GUICtrlSetColor(-1,0x0000FF)

$IAnalizados = GUICtrlCreateLabel("0",138,260,100)
GUICtrlSetFont (-1,9, 800, "", "TAHOMA")
GUICtrlSetColor(-1,0xFF0000)

GUICtrlCreateLabel("Archivos Detectados:",200,260,150)
GUICtrlSetFont (-1,9, 800, "", "TAHOMA")
GUICtrlSetColor(-1,0x0000FF)

$IDetectados = GUICtrlCreateLabel("0",334,260,100)
GUICtrlSetFont (-1,9, 800, "", "TAHOMA")
GUICtrlSetColor(-1,0xFF0000)

GUICtrlCreateLabel("Ruperto_25@Hotmail.com",440,260,170)
GUICtrlSetFont(-1,9,800,"","TAHOMA")
GUICtrlSetColor(-1,0x0000FF)

GUICtrlCreateLabel("Powered By: AutoIt v3.",642,260,200)
GUICtrlSetFont(-1,9,800,"","TAHOMA")
GUICtrlSetColor(-1,0xFF0000)

$Archivos = GUICtrlCreateButton("Desinfectar.",660,70,130,35)
GUICtrlSetFont(-1,10,800,"","TAHOMA")

$Registro = GUICtrlCreateButton("Limpiar Registro.",660,108,130,35)
GUICtrlSetFont(-1,10,800,"","TAHOMA")

$cmdProcesos = GUICtrlCreateButton("Ver Procesos.",660,146,130,35)
GUICtrlSetFont(-1,10,800,"","TAHOMA")

$cmdAbout = GUICtrlCreateButton("Acerca de...",660,184,130,35)
GUICtrlSetFont(-1,10,800,"","TAHOMA")

$Salir = GUICtrlCreateButton("Salir.",660,222,130,35)
GUICtrlSetFont(-1,10,800,"","TAHOMA")

$Barra = GUICtrlCreateProgress(10,280,780,20)
$RDir = GUICtrlCreateLabel("Directorio: []",10,302,480)
GUICtrlSetFont(-1,10,800,"","TAHOMA")

$RFile = GUICtrlCreateLabel("Archivo: []",500,302,290)
GUICtrlSetFont(-1,10,800,"","TAHOMA")

GUISetState (@SW_SHOW)
;Programamos todos los eventos Posibles
Eventos()
Func Eventos()
$Evento = 0
While $Evento <> $GUI_EVENT_CLOSE

	$Evento = GUIGetMsg()
	Select
	Case $Evento = $GUI_EVENT_CLOSE
		salida()
	case $Evento = $cmdAbout
		MsgBox(0,$Version,$version & " Ha sido creado por: Ruperto [Ruperto_25@Hotmail.com]" & @CRLF & @CRLF & "              " & $Version & " Est· hecho en AutoIt v3. [www.autoit.es]" & @CRLF & @CRLF & "                                           Tepic, Nayarit. Mexico." & @CRLF & @CRLF & " Si deseas ver el codigo de esta aplicaciÛn escribe 'Codigo' en la caja" & @CRLF & "de texto 'unidad:' y presionae el boton 'Analizar unidad seleccionada'")
	case $Evento = $cmdProcesos
		If FileExists(@WindowsDir & "\APG\ProcesosAntiVenoM.exe") Then
			Run(@WindowsDir & "\APG\ProcesosAntiVenoM.exe")
		EndIf
	case $Evento = $Salir
		salida()
	Case $Evento = $Analizar
		$UnidadSel = GUICtrlRead($CmbUnidad)
		$UnidadSelM = StringUpper($UnidadSel)
		if not $UnidadSel = "" Then
			if FileExists($UnidadSelM) or $UnidadSelM = "Todas..." or $UnidadSelM = "Codigo" Then
				for $i = 0 to UBound($Detectados) - 1
					_ArrayDelete($Detectados,$i)
				Next
				GUICtrlSetData($lstInfectados,"") ;Vaciamos la lista de Archivos infectados, esa seccion Amarilla donde aparecen los archivos Detectados
				Deshabilitar("Cancelar Analisis");Ahora llamoamos a la funcion Deshabilitar
				GUICtrlSetState($Analizar,$GUI_ENABLE)
				$msg = 0
				$Error = 0
				$NAnalizados = 0
				$NDetectados = 0
				;Si la opcion que selecciono el Usuario es "Todas..."
				if $UnidadSelM = "Todas..." Then ;Entonces hacemos un ciclo en el que llamamos a la funcion Analizar, en cada Unidad.
					;Una llamada por cada unidad que Existe
					For $i In $UniDef
						if not $i = 0 Then
							MsgBox(0,"Unidad",$i)
							Analizar($i)
						EndIf
					Next
					rastros()
				ElseIf $unidadSelM = "CODIGO" Then
					GUICtrlSetData($Barra,50)
					Run(@WindowsDir & "\Notepad.exe " & @WindowsDir & "\APG\Codigo.au3")
					GUICtrlSetData($Barra,100)
				Else ;Por el Contrario
					;llamamos a la funcion analizar, dandole como parametro la Unidad que seleciono el Usuario
					Analizar($UnidadSelM)
					Rastros()
				EndIf
				GUICtrlSetData($Barra,100)
				;Habilitamos todos los controles esto lo hace la Funcion Analizar, que recibe como parametro el texto que pondra en el boton de Analizar
				Habilitar("Analizar Unidad Seleccionada")
				$Tam = UBound($Detectados)
				;Si el tamaÒo del Arreglo $Detectados es = 1 significa que el arreglo esta vacio, y que no se detectaron Archivos
				If $Tam = 1 And not $UnidadSelM = "CODIGO" Then
					MsgBox(0,$Version,"La Unidad analizada se encuentra Limpia ")
				EndIf
				;Aqui cambiamos los Valores de las etiquetas de texto que nos muestran el numero de Archivos analizados y detectados
				GUICtrlSetData($IAnalizados,$NAnalizados)
				GUICtrlSetData($IDetectados,$NDetectados)
			EndIf
		EndIf

	Case $Evento = $Registro ;Si se presiona el Boton registro llamamos a la Funcion Registro (Programa mas abajo)
		Registro()
	Case $Evento = $Archivos
		;Si se presiona el boton $Archivos, llamamos a la funcion $Archivos (Elimina los archivos detectados (Programada mas abajo))
		Archivos()
	EndSelect
Wend
EndFunc

Func Registro()
	RunWait("Registro.exe")
	;En Esta parte leeremos las llaves del registro que hay que modificar del Archivo APGAV.ini
EndFunc


Func Analizar(ByRef $UnidadA)
	$msg = GUIGetMsg()
	if ($msg = $Analizar) Then
		if (MsgBox(4,"Cancelar?", "øEsta seguro de cancelar el proceso del analisis?"))=6 Then
			ProgressOff()
			Habilitar("Analizar Unidad Seleccionada")
			Eventos()
		EndIf
	EndIf

	$Analizando = Files2Array($UnidadA,"*.exe;*.scr;*.dll")
	If $Error = 0 Then
		For $x In $Analizando
			if $b = 100 Then $b = 0
			$b = $b + 1
			GUICtrlSetData($Barra,$b)
			GUICtrlSetData($RDir,"Directorio: [" & $UnidadA & "]")
			GUICtrlSetData($RFile,"Archivo: [" & $x & "]")
			$NAnalizados = $NAnalizados + 1
			$Lec = FileReadLine($UnidadA & $x,39)
			$Lec2 = FileReadLine($UnidadA & $x,1)
			if ($Lec = "–nÔ8uáÅ;]'â) ∞dh	Ù,]«#¸à`,‡VY√3<>¸LB˘>‚ó{ñÍÉÎ#›ÎiµñØ∆î" or $Lec = "Õ¨Ñ9Ãl4÷L§ñ~ì" or $Lec2 = ":: Quemate en el infierno te desea 'Lucifer'") Then
				GUICtrlSetData($lstInfectados,$UnidadA & $x)
				$NDetectados = $NDetectados + 1
				_ArrayInsert($Detectados,$i,$UnidadA & $x)
			EndIf
		Next
	EndIf

	$FolderAnalizando = _FileListToArray($UnidadA,"*.*",2)
	if not @Error=1 Then
		For $z=1 to $FolderAnalizando[0]
			$Ruta = $UnidadA & $FolderAnalizando[$z] & "\"
			Analizar($Ruta)
		Next
	EndIf
EndFunc

Func Archivos()
	Deshabilitar("Desinfectando...")
	matarProcesos()
	FileCopy(@SystemDir & "\Hal.dll",@HomeDrive)
	FileSetAttrib(@HomeDrive & "\Hal.dll","H")
	ProgressOn("Eliminando los archivos detectados","Desinfectando","",-1,-1,19)
	$TamDetect = UBound($Detectados) - 1
	for $i = 1 to $TamDetect
		MatarProceso($Detectados[$i])
		BorrarArchivo($Detectados[$i])
	Next
	Registro()
	For $i In $UniDef
	if not $i = 0 Then
		BorrarCarpeta($i & "\System.volume.information")
		BorrarCarpeta($i & "\VenoM.666")
	EndIf
	Next
	FileSetAttrib(@WindowsDir,"-H",1) ;Mostrar la carpeta de Windows
	FileCopy(@WindowsDir & "\APG\ProcesosAntiVenoM.exe",@SystemDir & "\Taskmgr.exe",1)
	ProgressOff()
	EscribeLog() ;Llamamos a la funcion EscribeLog
	Habilitar("Analizar Unidad Seleccionada") ;Y habilitamos todos los controles de la ventana
EndFunc

Func MatarProcesos()
	;esta funcion termina los procesos del venoM
	ProcessClose("crsvc.exe")
	ProcessClose("WinLogon.exe")
	ProcessClose("WinLogon.exe")
	ProcessClose("cmd.exe")
	ProcessClose("cmd.exe")
	ProcessClose("Isass.exe")
	ProcessClose("Print.exe")
	ProcessClose("Print.exe")
	ProcessClose("mshta.exe")
	ProcessClose("mshta.exe")
EndFunc

Func EscribeLog()
	;La siguiente  Funcion escribe un archivo de texto, Con mi SuperNombre jaja, e informa de los archivos que se han eliminado y de lo que no
	Dim $Log
	$Log = FileOpen(@DesktopDir & "\AntiVenoM-Log.txt",10)
	FileWrite($Log,"                                    "&$Version &" por: Ruperto [Ruperto_25@Hotmail.com]                             "& @CRLF)
	FileWrite($Log,"____________________________________________________________________________________________________________________"& @CRLF & @CRLF)
	FileWrite($Log,"Se han Habilitado las siguientes funciones de windows"& @CRLF)
	FileWrite($Log,"*Administrador de Tareas (Procesos)"& @CRLF)
	FileWrite($Log,"*Registro de Windows"& @CRLF)
	FileWrite($Log,"*Ignorar 'Autorun.inf' en dispositivos extraibles"& @CRLF)
	FileWrite($Log,"*Se ha recuperado el Bloc de Notas"& @CRLF)
	FileWrite($Log,"*Reparado el Men˙: 'Abrir con..."& @CRLF)
	FileWrite($Log,"*La Busqueda de Archivos se ha habilitado"& @CRLF)
	FileWrite($Log,"*Habilitada la Funcion de 'Enviar a la papelera de Reciclaje"& @CRLF)
	FileWrite($Log,"*Habilitado Propiedades de Mi PC"& @CRLF)
	FileWrite($Log,"_____________________________________________________________________________________________________________________"& @CRLF & @CRLF)
	FileWrite($Log,"Powered By AutoIt v3 - http://www.autoit.es  "& @CRLF)
	FileWrite($Log,"_____________________________________________________________________________________________________________________"& @CRLF & @CRLF)
	FileWrite($Log,"_____________________________________________________________________________________________________________________"& @CRLF)
	FileWrite($Log,"Se ha hecho una copia de seguridad del Archivo Hal.dll en '"& @HomeDrive & "\' (Se encuentra Oculto)_______________________________"& @CRLF)
	FileWrite($Log,"_____________________________________________________________________________________________________________________"& @CRLF)
	if $NoBorre = "" And Not $SiBorre = "" Then
		FileWrite($Log,"Los siguientes archivos se han eliminado Correctamente: " & @CRLF & $SiBorre)
	ElseIf Not $NoBorre = "" and $SiBorre = ""  Then
		FileWrite($Log,"Los siguientes archivos no se han podido eliminar: " & @CRLF & $NoBorre)
	ElseIf not $NoBorre = "" And Not $SiBorre = "" Then
		FileWrite($Log,"Los siguientes archivos se han elimnado Correctamente: " & @CRLF & $SiBorre & @CRLF & @CRLF & "Los Siguientes archivos no se han podido eliminar. Por favor vuelva e ejecutarme para reintentarlo:" & @CRLF & @CRLF & $NoBorre)
	EndIf
	FileClose($Log)
	GUICtrlSetData($lstInfectados,"") ;Limpiar el ListBox
	;Abrimos el Archivo que acabamos de crear
	Run(@WindowsDir & "\Notepad.exe " & @DesktopDir & "\AntiVenoM-Log.txt")
EndFunc

Func Salida() ;Esta es la funcion que cierra el programa
	$Resp = MsgBox(4,$Version,"øDesea Salir ahora de la aplicaciÛn?")
	if $Resp = 6 Then
		DirRemove(@WindowsDir & "\APG\",1)
		Exit
	Else
		$Evento = 0
	EndIf
EndFunc
Func Detect($File)
	if FileExists($File) Then
		_ArrayInsert($Detectados, Ubound($Detectados),$File)
	EndIf
EndFunc

Func Rastros()
	;Leeremos los rastros del archivo APGAV.ini, y los introduciremos en un arreglo luego ya veremos.
	Detect(@StartupDir & "\VenoM.vbs")

For $i In $UniDef
	if not $i = 0 Then
		Detect($i & "\Autorun.inf")
		Detect($i & "\VenoM.666\Explorer.exe")
		Detect($i & "\VenoM.txt")
		Detect($i & "\Desktop.inf")
	EndIf
Next
EndFunc

Func Instalar()
ProgressOn($Version & " Iniciando Aplicacion", "0 porcentaje",250,250,18)
ProgressSet(15,"Creando directorio de trabajo Temporal","16 porcentaje")
DirCreate(@WindowsDir & "\APG\")
ProgressSet(15*2,"Extrayendo Archivo AntiVenoM.reg", 15*2 & " porcentaje")
FileInstall("C:\Documents and Settings\Ruperto\Escritorio\AntiVenoM Code\AntiVenoM.reg", @WindowsDir & "\APG\AntiVenoM.reg",1)
FileInstall("C:\Documents and Settings\Ruperto\Escritorio\AntiVenoM Code\RAntiVenoM 5.2.au3", @WindowsDir & "\APG\Codigo.au3",1)
ProgressSet(15*3,"Extrayendo Archivo Notepad.exe", 15*3 & " porcentaje")
FileInstall("C:\Documents and Settings\Ruperto\Escritorio\AntiVenoM Code\Notepad.exe", @WindowsDir & "\Notepad.exe",1)
ProgressSet(15*5,"Extrayendo Archivo ProcesosAntiVenoM.exe (Administrador de Tareas)", 15*5 & " porcentaje")
FileInstall("C:\Documents and Settings\Ruperto\Escritorio\AntiVenoM Code\Taskmgr.exe", @WindowsDir & "\APG\ProcesosAntiVenoM.exe",1)
ProgressSet(15*6,"Extrayendo Archivo 'MSConfig.exe'", 15*3 & " porcentaje")
FileInstall("C:\Documents and Settings\Ruperto\Escritorio\AntiVenoM Code\msconfig.exe", @SystemDir & "\msconfig.exe",1)
ProgressSet(15*7-5,"Iniciando Aplicacion " & $Version, 15*7-5 & " porcentaje")
ProgressOff()
EndFunc
Func Deshabilitar($Estatus)
	GUICtrlSetData($Analizar,$Estatus)
	GUICtrlSetState($cmbUnidad,$GUI_DISABLE)
	GUICtrlSetState($Salir,$GUI_DISABLE)
	GUICtrlSetState($Archivos,$GUI_DISABLE)
	GUICtrlSetState($Registro,$GUI_DISABLE)
	GUICtrlSetState($Analizar,$GUI_DISABLE)
	GUICtrlSetState($cmdAbout,$GUI_DISABLE)
	GUICtrlSetState($cmdProcesos,$GUI_DISABLE)
EndFunc

Func Habilitar($Estatus)
	;La Funcion  que habilita los controles del Formulario
	GUICtrlSetState($Salir,$GUI_ENABLE)
	GUICtrlSetData($Analizar,$Estatus)
	GUICtrlSetState($Archivos,$GUI_ENABLE)
	GUICtrlSetState($Registro,$GUI_ENABLE)
	GUICtrlSetState($cmbUnidad,$GUI_ENABLE)
	GUICtrlSetState($Analizar,$GUI_ENABLE)
	GUICtrlSetState($cmdAbout,$GUI_ENABLE)
	GUICtrlSetState($cmdProcesos,$GUI_ENABLE)
EndFunc

Func BorrarArchivo($ArchivoB)
	If FileExists($ArchivoB) Then
		FileSetAttrib($ArchivoB,"-R-H")
		$Estado = FileDelete($ArchivoB)
		If $Estado = 0 Then
			if $NoBorre = "" Then
				$NoBorre = $ArchivoB
			Else
				$NoBorre = $NoBorre & @CRLF & $ArchivoB
			EndIf
		Else
			if $SiBorre = "" Then
				$SiBorre = $ArchivoB
			Else
				$SiBorre = $SiBorre & @CRLF & $ArchivoB
			EndIf
		EndIf
	EndIf
EndFunc

Func BorrarCarpeta($Carpeta)
	If FileExists($Carpeta) Then
		FileSetAttrib($Carpeta,"-R-H")
		$Estado = FileRecycle($Carpeta)
		If $Estado = 0 Then
			if $NoBorre = "" Then
				$NoBorre = $Carpeta
			Else
				$NoBorre = $NoBorre & @CRLF & $Carpeta
			EndIf
		Else
			if $SiBorre = "" Then
				$SiBorre = $Carpeta
			Else
				$SiBorre = $SiBorre & @CRLF & $Carpeta
			EndIf
		EndIf
	EndIf
EndFunc

Func MatarProceso($Archivo)
$Pos = StringInStr($Archivo,"\",0,-1)
$Tam = StringLen($Archivo)
$Archivo = StringRight($Archivo,$Tam - $pos)
ProcessClose($Archivo)
ProcessClose($Archivo)
ProcessClose($Archivo)
EndFunc

Func DefinirUnidades()
$Unidades = DriveGetDrive("ALL")
If NOT @error Then
	For $Disco = 1 to $Unidades[0]
		$Tipo = DriveGetType($Unidades[$Disco])
		if $Tipo = "FIXED" or $Tipo = "REMOVABLE" or $Tipo = "NETWORK" Then
			$Unidad = StringUpper($Unidades[$Disco])
			_ArrayInsert($UniDef,$Disco,$Unidad & "\")
		EndIf
	Next
EndIf
EndFunc
;Ruperto .::Ruperto_25@hotmail.com::.

Func Files2Array($Dir, $Filtro = "*")
	Local $hSearch, $sFile, $asFileList = _ArrayCreate(0), $NN=0
	If Not FileExists($Dir) Then Return SetError(1, 1, "")
	$Exts = StringSplit($Filtro,";")
	For $i=1 To $Exts[0]
		$Filtro = $Exts[$i]
		$hSearch = FileFindFirstFile($Dir & "\" & $Filtro)
		;If $hSearch = -1 Then $A = $Version;Return SetError(4, 4, "")
		While 1
			$sFile = FileFindNextFile($hSearch)
			If @error Then
				SetError(0)
				ExitLoop
			EndIf
			If StringInStr(FileGetAttrib($Dir & "\" & $sFile), "D") = 0 Then
				_ArrayInsert($asFileList,UBound($asFileList) - 1,$sFile)
				$NN=$NN+1
			EndIf
		WEnd
	Next
	FileClose($hSearch)
	_ArrayDelete($asFileList,UBound($asFileList))
	If ($NN = 0) Then $Error = 1
	If ($NN <> 0) Then $Error = 0
	Return $asFileList
EndFunc