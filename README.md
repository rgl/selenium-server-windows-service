This is my FAILED attempt to run [Selenium Server](http://www.seleniumhq.org/) as a Windows Service.

Although the Selenium Server runs fine as a Windows Service, the Browsers it tries to start do not. Even when:

* You run the service as a NON-SYSTEM account.
* Enable _Allow service to interact with desktop_.

At least, the latest Chrome and Internet Explorer need a full Desktop Session. Working from [Session 0](http://www.brianbondy.com/blog/id/100/understanding-windows-at-a-deeper-level---sessions-window-stations-and-desktops/) does not work.

This means You have to find another way to automatically start a Desktop Session and run the Selenium Server after logon.

The sections bellow will not really work in the end. They are here just for reference.

# Build

These following commands must be run on a bash shell, which I'll assume that you have installed following the instructions from [Sane shell environment on Windows](http://blog.ruilopes.com/sane-shell-environment-on-windows.html).

Type `make` and everything should be downloaded.

To start the Hub and Node either install the services as described bellow or run them in foreground with:

```
make run-hub
make run-node
```

# Install Services

This uses [procrun](http://commons.apache.org/proper/commons-daemon/procrun.html) (and a [little adapter](src/com/ruilopes/selenium/Service.java)) to launch the Selenium Server Hub and Node as a Windows Service.

If you will run the Hub and Node in the same machine you don't need to configure them. You just need to install the services by running the following commands in a Administrator shell:

    selenium-server-hub-install.cmd
    selenium-server-node-install.cmd

**NB** The services will be run by the `SYSTEM` account, which is not really advisable. You should create and use a dedicated user account.

After that, start the services with:

    net start selenium-server-hub
    net start selenium-server-node

If you need to configure any of the services, edit `hubConfig.json` and `nodeConfig.json` files and restart the services.

If you need to edit the JVM settings edit the `*-update.cmd` files, run them, and restart the service.
