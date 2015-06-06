SOURCES=$(shell find src -name '*.java')
JAR=selenium-server-service.jar
COMMONS_DAEMON_ZIP_URL=http://www.apache.org/dist/commons/daemon/binaries/windows/commons-daemon-1.0.15-bin-windows.zip
COMMONS_DAEMON_ZIP=$(shell basename $(COMMONS_DAEMON_ZIP_URL))
SELENIUM_SERVER_JAR_URL=http://selenium-release.storage.googleapis.com/2.46/selenium-server-standalone-2.46.0.jar
SELENIUM_SERVER_JAR=selenium-server.jar
CHROME_DRIVER_URL=http://chromedriver.storage.googleapis.com/2.15/chromedriver_win32.zip
CHROME_DRIVER_ZIP=chromedriver_win32.zip
CHROME_DRIVER_EXE=chromedriver.exe
SERVICE_EXE=selenium-server.exe

all: $(JAR) $(SERVICE_EXE)

$(JAR): $(SOURCES) $(SELENIUM_SERVER_JAR)
	mkdir -p classes
	javac -cp $(SELENIUM_SERVER_JAR) -d classes -Werror $(SOURCES)
	jar cf $@ -C classes .

$(SELENIUM_SERVER_JAR):
	curl -o $@ $(SELENIUM_SERVER_JAR_URL)

$(SERVICE_EXE):
	curl -O $(COMMONS_DAEMON_ZIP_URL)
	unzip -j $(COMMONS_DAEMON_ZIP) amd64/prunsrv.exe
	mv prunsrv.exe $(SERVICE_EXE)

$(CHROME_DRIVER_EXE):
	curl -O $(CHROME_DRIVER_URL)
	unzip -j $(CHROME_DRIVER_ZIP) $@

clean:
	rm -rf classes logs
	rm -f $(JAR) $(SELENIUM_SERVER_JAR)
	rm -f $(COMMONS_DAEMON_ZIP) $(SERVICE_EXE)
	rm -f $(CHROME_DRIVER_ZIP) $(CHROME_DRIVER_EXE)

run-hub: $(JAR) $(SELENIUM_SERVER_JAR)
	java -cp "$(JAR);$(SELENIUM_SERVER_JAR)" com.ruilopes.selenium.Service \
		-role hub -hubConfig hubConfig.json

run-node: $(JAR) $(SELENIUM_SERVER_JAR) $(CHROME_DRIVER_EXE)
	java -cp "$(JAR);$(SELENIUM_SERVER_JAR)" com.ruilopes.selenium.Service \
		-Dwebdriver.chrome.driver=chromedriver.exe \
		-role node -nodeConfig nodeConfig.json
