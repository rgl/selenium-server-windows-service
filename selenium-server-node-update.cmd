@echo off

set SERVICE_NAME=selenium-server-node
set SERVICE_DISPLAY_NAME=Selenium Server Node
set SERVICE_DESCRIPTION=%SERVICE_DISPLAY_NAME%
set SERVICE_START_PARAMS=-role;node;-nodeConfig;nodeConfig.json
set JVM_OPTIONS=%JVM_OPTIONS% -Dwebdriver.chrome.driver=chromedriver.exe

call selenium-server-update.cmd
