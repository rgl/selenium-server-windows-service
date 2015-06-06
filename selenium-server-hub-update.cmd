@echo off

set SERVICE_NAME=selenium-server-hub
set SERVICE_DISPLAY_NAME=Selenium Server Hub
set SERVICE_DESCRIPTION=%SERVICE_DISPLAY_NAME%
set SERVICE_START_PARAMS=-role;hub;-hubConfig;hubConfig.json

call selenium-server-update.cmd
