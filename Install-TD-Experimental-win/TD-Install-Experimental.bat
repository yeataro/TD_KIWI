@Echo off
SET FOLDER=%~d1%~p1%~n1
MD %FOLDER%
ECHO Extracting %~n1 ...
%~f1 /extract "%FOLDER%"
ECHO Done.
ECHO Extracted %~nx1 to %FOLDER%\
pause