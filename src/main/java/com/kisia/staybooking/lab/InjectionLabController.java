package com.kisia.staybooking.lab;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

/**
 * Intentionally vulnerable, synthetic SQL injection exercise.
 * The endpoint exists only when the explicit lab flag is enabled and requires ROLE_ADMIN.
 * It uses a separate in-memory H2 database so no Staybooking or shared MySQL rows are reachable.
 */
@RestController
@ConditionalOnProperty(name = "staybooking.security.injection-lab-enabled", havingValue = "true")
@RequestMapping("/api/v1/admin/lab/injection")
public class InjectionLabController {
    private static final String LAB_URL = "jdbc:h2:mem:staybooking_injection_lab;DB_CLOSE_DELAY=-1";

    public InjectionLabController() {
        try (var connection = DriverManager.getConnection(LAB_URL);
             var statement = connection.createStatement()) {
            statement.execute("CREATE TABLE IF NOT EXISTS lab_stays (id INT PRIMARY KEY, name VARCHAR(100))");
            statement.execute("MERGE INTO lab_stays KEY (id) VALUES (1, 'Seoul City Stay')");
            statement.execute("MERGE INTO lab_stays KEY (id) VALUES (2, 'Busan Ocean Hotel')");
            statement.execute("MERGE INTO lab_stays KEY (id) VALUES (3, 'Jeju Garden House')");
        } catch (SQLException exception) {
            throw new IllegalStateException("Cannot initialize injection lab", exception);
        }
    }

    @GetMapping("/search")
    public List<String> search(@RequestParam String keyword) {
        if (keyword.length() > 80) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "검색어가 너무 깁니다.");
        }
        // Deliberately unsafe concatenation against the isolated synthetic lab database only.
        String sql = "SELECT name FROM lab_stays WHERE LOWER(name) LIKE '%"
            + keyword.toLowerCase(Locale.ROOT) + "%' ORDER BY name";
        try (var connection = DriverManager.getConnection(LAB_URL);
             var statement = connection.createStatement();
             var rows = statement.executeQuery(sql)) {
            List<String> names = new ArrayList<>();
            while (rows.next()) names.add(rows.getString(1));
            return names;
        } catch (SQLException exception) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "검색어를 처리하지 못했습니다.");
        }
    }
}
