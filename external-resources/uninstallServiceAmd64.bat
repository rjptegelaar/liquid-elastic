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

REM Remove service 
%LIQUID_ELASTIC_HOME%\bin\amd64\prunsrv.exe //DS//%SERVICE_NAME%