package com.kisia.staybooking;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;
import org.springframework.mock.env.MockEnvironment;

class ServletInitializerProfileTests {
    @Test
    void externalTomcatRequiresOnlyMysqlProfile() {
        assertThrows(IllegalStateException.class,
            () -> ServletInitializer.requireMysqlProfile(new MockEnvironment()));

        MockEnvironment mysql = new MockEnvironment();
        mysql.setActiveProfiles("mysql");
        assertDoesNotThrow(() -> ServletInitializer.requireMysqlProfile(mysql));

        MockEnvironment mixed = new MockEnvironment();
        mixed.setActiveProfiles("mysql", "local");
        assertThrows(IllegalStateException.class,
            () -> ServletInitializer.requireMysqlProfile(mixed));
    }
}
