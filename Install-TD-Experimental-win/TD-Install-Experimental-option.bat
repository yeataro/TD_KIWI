@Echo off
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
pause