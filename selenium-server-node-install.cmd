@echo off
setlocal

set SERVICE_NAME=selenium-server-node
for %%I in ("%~dp0.") do set SERVICE_HOME=%%~dpfI
set PRUNSRV=%SERVICE_HOME%\selenium-server

"%PRUNSRV%" //IS//%SERVICE_NAME%
call %SERVICE_HOME%\%SERVICE_NAME%-update.cmd
