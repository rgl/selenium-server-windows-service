package com.ruilopes.selenium;

import org.openqa.grid.selenium.GridLauncher;

public class Service {
    public static void main(String[] args) throws Exception {
        GridLauncher.main(args);
    }

    public static void stop(String[] args) {
        System.exit(0);
    }
}
