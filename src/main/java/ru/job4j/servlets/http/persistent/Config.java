package ru.job4j.servlets.http.persistent;

import java.io.InputStream;
import java.util.Properties;

public class Config {
    private final Properties values = new Properties();

    public void init() {
        try (InputStream in = Config.class.getClassLoader().getResourceAsStream("db.properties")) {
            values.load(in);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public String get(String key) {
        return this.values.getProperty(key);
    }
}
