@echo off

echo ##### TouchDesigner START #####

set MOVIESDIR=%~d1%~p1%resource
echo Starting %~nx1 and set "movies://" =  %MOVIESDIR%
start "%programfiles%\derivative\touchdesigner099\bin\touchdesigner099.exe" %1
timeout /t 30