@Echo off
IF "%~nx1" == "" GOTO NOdrag
SET FOLDER=%~d1%~p1%~n1
MD %FOLDER%_temp
ECHO Extracting %~n1 ...
%~f1 /extract "%FOLDER%_temp"
ECHO Done.
ECHO Extracted %~nx1 to %FOLDER%_temp\
ECHO Delete Useless files...
DEL /Q %FOLDER%_temp\*
RD /Q /S "%FOLDER%_temp\Visual C++ Redistributable for Visual Studio 2015"
FOR /F %%F IN ('dir %FOLDER%_temp /a:d /b') DO (REN "%FOLDER%_temp\%%F" "%~n1")
MOVE %FOLDER%_temp\%~n1 %~d1%~p1
RD /Q %FOLDER%_temp
ECHO Done.
CHOICE /C YN /M "Create Shortcut in SendTo?" 
if errorlevel 2 goto END
if errorlevel 1 goto CreateShortcut

:CreateShortcut
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\%~n1.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%FOLDER%\bin\TouchDesigner099.exe" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs
ECHO Done.
START %SystemRoot%\explorer.exe "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\"
pause
EXIT


:END
pause
EXIT

:NOdrag
ECHO Did not drag a file to this batch file. Please drag a TD installation file to this batch file.
pause
EXIT