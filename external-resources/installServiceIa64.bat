echo off

if not "%JAVA_HOME%" == "" goto gotJavaHome

echo The JAVA_HOME environment variable is not defined

echo This environment variable is needed to run this program

goto exit

:gotJavaHome

if exist %JAVA_HOME%\bin\server\jvm.dll (
    set JVM=%JAVA_HOME%\bin\server\jvm.dll
) else (
    set JVM=%JAVA_HOME%\jre\bin\server\jvm.dll  
)

if defined LIQUID_ELASTIC_HOME (
	echo LIQUID_ELASTIC_HOME IS defined
) else (
	set LIQUID_ELASTIC_HOME=%~dp0
)

echo Using %LIQUID_ELASTIC_HOME% as liquid home directory

set SERVICE_NAME=LiquidElasticService

%LIQUID_ELASTIC_HOME%\bin\ia64\prunsrv.exe //IS//%SERVICE_NAME% --DisplayName=%SERVICE_NAME% --Description=%SERVICE_NAME% --Startup=auto --Install=%LIQUID_ELASTIC_HOME%\bin\amd64\prunsrv.exe --Jvm=auto --Classpath=%LIQUID_ELASTIC_HOME%\liquid-elastic.jar --StartMode=jvm --StartClass=com.pte.liquid.LiquidElastic --StartMethod=startService --StartParams=start --StopMode=jvm --StopClass=com.pte.liquid.LiquidElastic --StopMethod=stopService --StopParams=stop --StdOutput=auto --StdError=auto --LogPath=%LIQUID_ELASTIC_HOME%\logs --LogLevel=Info --StartPath=%LIQUID_ELASTIC_HOME% --Jvm=%JVM%