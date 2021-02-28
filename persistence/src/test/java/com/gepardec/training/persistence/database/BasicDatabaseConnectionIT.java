package com.gepardec.training.persistence.database;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.TestInstance.Lifecycle;

@TestInstance(Lifecycle.PER_CLASS)
public class BasicDatabaseConnectionIT {
    private static final String DB_BASE_URI = "jdbc:postgresql://%s:%s/%s";
    private static final String DB_PROPERTIES = "dbConnection.properties";
    private static final String PROPERTY_SERVER_NAME = "db.server.name";
    private static final String PROPERTY_SERVER_PORT = "db.server.port";
    private static final String PROPERTY_DB_NAME = "db.name";
    private static final String SELECT_VERSION = "SELECT version()";

    private Properties properties;
    private Connection connection;
    private String dbUri;


    @BeforeAll
    public void setup() throws IOException, SQLException {
        readProperties();
        establishDatabaseConnection();
    }

    @Test
    public void readDatabaseVersion() throws SQLException {
        assertTrue(executeQuery(SELECT_VERSION).get(0).startsWith("PostgreSQL"));
    }

    @AfterAll
    public void teardown() throws SQLException {
        closeDatabaseConnection();
    }

    private void readProperties() throws IOException {
        InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream(DB_PROPERTIES);
        properties = new Properties();
        properties.load(inputStream);
        dbUri = String.format(DB_BASE_URI,
                properties.getProperty(PROPERTY_SERVER_NAME),
                properties.getProperty(PROPERTY_SERVER_PORT),
                properties.getProperty(PROPERTY_DB_NAME)
        );
    }

    private void establishDatabaseConnection() throws SQLException {
        connection = DriverManager.getConnection(dbUri, properties);
    }

    private ArrayList<String> executeQuery(String statement) throws SQLException {
        ArrayList<String> resultList = new ArrayList<>();
        ResultSet result = connection.createStatement().executeQuery(statement);

        while (result.next()) {
            resultList.add(result.getString(1));
        }
        return resultList;
    }

    private void closeDatabaseConnection() throws SQLException {
        connection.close();
    }

}
