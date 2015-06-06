:: DO NOT DIRECTLY RUN THIS. INSTEAD run one of these:
::   selenium-server-hub-update.cmd
::   selenium-server-node-update.cmd

for %%I in ("%~dp0.") do set SERVICE_HOME=%%~dpfI
set PRUNSRV=%SERVICE_HOME%\selenium-server

rem Initial memory pool size in MB.
set JVM_MS=256
rem Maximum memory pool size in MB.
set JVM_MX=256

set JVM_CLASSPATH=%SERVICE_HOME%\selenium-server-service.jar;%SERVICE_HOME%\selenium-server.jar

set JVM_OPTIONS=%JVM_OPTIONS% -Djava.net.preferIPv4Stack=true

set JVM=auto
if exist "%SERVICE_HOME%\jre\bin\server\jvm.dll" set JVM=%SERVICE_HOME%\jre\bin\server\jvm.dll
if exist "%SERVICE_HOME%\jre\bin\client\jvm.dll" set JVM=%SERVICE_HOME%\jre\bin\client\jvm.dll

set SERVICE_CLASS=com.ruilopes.selenium.Service

"%PRUNSRV%" //US//%SERVICE_NAME% ^
  --Jvm "%JVM%" ^
  --DisplayName "%SERVICE_DISPLAY_NAME%" ^
  --Description "%SERVICE_DESCRIPTION%" ^
  --StdOutput auto ^
  --StdError auto ^
  --LogPrefix "%SERVICE_NAME%-service" ^
  --LogPath "%SERVICE_HOME%\logs" ^
  --StartPath "%SERVICE_HOME%" ^
  --StartMode=jvm --StartClass=%SERVICE_CLASS% --StartMethod=main ^
  --StartParams "%SERVICE_START_PARAMS%" ^
  --StopMode=jvm --StopClass=%SERVICE_CLASS% --StopMethod=stop ^
  --Classpath "%JVM_CLASSPATH%" ^
  --JvmMs %JVM_MS% ^
  --JvmMx %JVM_MX% ^
  %JVM_OPTIONS: = ++JvmOptions %

rem These settings are saved in the Windows Registry at:
rem
rem    HKEY_LOCAL_MACHINE\SOFTWARE\Apache Software Foundation\Procrun 2.0\selenium-server-hub
rem
rem OR, on windows 64-bit procrun always uses the 32-bit registry at:
rem
rem    HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Apache Software Foundation\Procrun 2.0\selenium-server-hub
rem
rem See http://commons.apache.org/daemon/procrun.html
