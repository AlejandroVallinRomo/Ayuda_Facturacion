@echo off

::Autor: Alejandro Vallin Romo
::Descripción del archivo: Este script fue hecho para facilitar una tarea de facturación de una empresa en México.
::Información específica de la empresa fue removida y el script fue reescrito para funcionar con una empresa genérica.
::Este script le pregunta al usuario la ruta de los archivos que quiera copiar, luego le pregunta algunas características de la factura.
::Ya con esta información, se crean las nuevas carpetas con los nombres correspondientes, y se le pide al usuario confirmar visualmente la creación de las nuevas carpetas.
::Se le pide confirmar al usuario la carpeta de origen de los archivos.
::Por último se copian los archivos correspondientes de facturación a las carpetas creadas.
::Para procesar otra factura el usuario le puede hacer clic en la tecla "1", y el programa reutilizará la información de las rutas, solo será necesario dar la información de la nueva factura.
::Si el usuario hace clic en "0" el programa terminará.
::Se copian 3 archivos pdf ("FACTURA", "PAGADO", y "SIMPLIFICADO") y los contenidos de una carpeta (partidas) a la nueva carpeta con el numero de la factura.

::setup

echo Pegue o escriba aqui la ruta a la carpeta de la empresa:
set /p _origen=

echo Pegue o escriba aqui la ruta donde quiera las nuevas carpetas:
set /p _path=

:loop

set /p nuevofolder=Numero de Factura:

set /p anno=Ultimos dos digitos del anno:

set /p cliente=Nombre del Cliente:

set /p mesf=Mes anterior:

::crear carpeta con nombre de la factura completa
MD %_path%\%nuevofolder%
MD %_path%\%nuevofolder%\partidas

echo verificar que se ha creado la carpeta correspondiente.
pause

::corrección de strings, esto de acuerdo con los estandares de nombramiento de la empresa
set factura=%nuevofolder:~4,4%-%nuevofolder:~8,15%
set facturaMas=480-%nuevofolder:~4,4%-%nuevofolder:~8,15%
echo la ruta origen de los archivos a mover es "%_origen%\20%anno%\%cliente%\%cliente% %mesf% 20%anno%\%factura%\FACTURA.pdf"
pause

::copiar archivos
copy "%_origen%\20%anno%\%cliente%\%cliente% %mesf% 20%anno%\%factura%\FACTURA.pdf" "%_path%\%nuevofolder%"
copy "%_origen%\20%anno%\%cliente%\%cliente% %mesf% 20%anno%\%factura%\PAGADO.pdf" "%_path%\%nuevofolder%"
copy "%_origen%\20%anno%\%cliente%\%cliente% %mesf% 20%anno%\%factura%\SIMPLIFICADO.pdf" "%_path%\%nuevofolder%"
copy "%_origen%\20%anno%\%cliente%\%cliente% %mesf% 20%anno%\%factura%\%facturaMas%\partidas" "%_path%\%nuevofolder%\partidas"

echo Verificar que los archivos hayan sido copiados, desea procesar otra factura? (1=Si, 0=No)
:input_
set /p _cont=
if %_cont%==1 (
	cls
	goto loop
)

if %_cont%==0 (
	exit 0
)

::Mensaje de error
echo favor de escribir "1" (uno) para procesar otra factura, o "0" (cero) para cerrar el programa
goto input_