@Echo off
IF "%~nx1" == "" GOTO NOdrag
SET FOLDER=%~d1%~p1%~n1
MD %FOLDER%
ECHO Extracting %~n1 ...
%~f1 /extract "%FOLDER%"
ECHO Done.
ECHO Extracted %~nx1 to %FOLDER%\
pause

:NOdrag
ECHO Did not drag a file to this batch file. Please drag a TD installation file to this batch file.
pause
EXIT