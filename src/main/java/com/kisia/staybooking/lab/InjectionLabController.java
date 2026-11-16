package com.kisia.staybooking.lab;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.sql.DataSource;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

/**
 * Intentionally vulnerable SQL injection baseline against the application's local database.
 * This controller is excluded from the shared MySQL profile and requires ROLE_ADMIN.
 */
@RestController
@Profile("local & !mysql")
@ConditionalOnProperty(name = "staybooking.security.injection-lab-enabled", havingValue = "true")
@RequestMapping("/api/v1/admin/lab/injection")
public class InjectionLabController {
    private final DataSource dataSource;

    public InjectionLabController(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @GetMapping("/search")
    public List<String> search(@RequestParam String keyword) {
        if (keyword.length() > 80) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "검색어가 너무 깁니다.");
        }
        // Diagnostic baseline: deliberately unsafe query against the real local app schema.
        String sql = "SELECT name FROM accommodations WHERE LOWER(name) LIKE '%"
            + keyword.toLowerCase(Locale.ROOT) + "%' ORDER BY name";
        try (var connection = dataSource.getConnection();
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
