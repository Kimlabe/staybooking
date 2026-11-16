package com.kisia.staybooking.lab;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.sql.DataSource;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

/**
 * Deliberately unsafe, READ-ONLY queries for the isolated local SQL-injection training lab.
 *
 * <p>This class is NOT part of the production code paths. The real search, login and signup flows
 * use JPA / parameterized queries and are unaffected. These methods exist only so the training
 * exercise can reproduce injection against the throwaway local H2 schema, and they are gated by
 * {@code @Profile("local & !mysql")} + {@code injection-lab-enabled} so they never load against the
 * shared MySQL profile or any deployed environment.
 *
 * <p>Queries are executed with {@link java.sql.Statement#executeQuery} on purpose: UNION, sub-query,
 * boolean/blind and error-based techniques all reproduce, but stacked statements that would mutate
 * the schema (INSERT/UPDATE/DROP) do not run through this entry point.
 */
@Service
@Profile("local & !mysql")
@ConditionalOnProperty(name = "staybooking.security.injection-lab-enabled", havingValue = "true")
public class InjectionLabQueryService {
    /** Generous cap so UNION/sub-query payloads fit, while still bounding input. */
    private static final int MAX_INPUT_LENGTH = 400;

    private final DataSource dataSource;

    public InjectionLabQueryService(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    /** Vulnerable accommodation search: reproduces boolean, UNION and sub-query injection. */
    public List<String> search(String keyword) {
        guardLength(keyword);
        // The prefix predicate lets the two boolean payloads produce different visible results.
        String sql = "SELECT name FROM accommodations WHERE LOWER(name) LIKE '"
            + keyword.toLowerCase(Locale.ROOT) + "%' ORDER BY name";
        return runQuery(sql, "검색어를 처리하지 못했습니다.");
    }

    /**
     * Vulnerable login check: reproduces authentication-bypass injection (e.g. {@code ' OR '1'='1' -- }).
     * Returns the matched "login_id (role)" rows so a successful bypass is visible in the exercise.
     */
    public List<String> loginDemo(String loginId, String password) {
        guardLength(loginId);
        guardLength(password);
        String sql = "SELECT login_id, role FROM users WHERE login_id = '" + loginId
            + "' AND password_hash = '" + password + "'";
        return runQuery(sql, "로그인 실습 쿼리를 처리하지 못했습니다.", 2);
    }

    /**
     * Vulnerable signup "id availability" check: reproduces boolean/blind injection on a field that
     * normally just reports whether a login id is already taken.
     */
    public List<String> signupAvailabilityDemo(String loginId) {
        guardLength(loginId);
        String sql = "SELECT COUNT(*) FROM users WHERE login_id = '" + loginId + "'";
        return runQuery(sql, "회원가입 중복확인 실습 쿼리를 처리하지 못했습니다.");
    }

    private void guardLength(String value) {
        if (value != null && value.length() > MAX_INPUT_LENGTH) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "입력이 너무 깁니다.");
        }
    }

    private List<String> runQuery(String sql, String failureMessage) {
        return runQuery(sql, failureMessage, 1);
    }

    private List<String> runQuery(String sql, String failureMessage, int columns) {
        try (var connection = dataSource.getConnection();
             var statement = connection.createStatement();
             var rows = statement.executeQuery(sql)) {
            List<String> results = new ArrayList<>();
            while (rows.next()) {
                if (columns == 1) {
                    results.add(rows.getString(1));
                } else {
                    StringBuilder row = new StringBuilder();
                    for (int column = 1; column <= columns; column++) {
                        if (column > 1) row.append(" (").append(rows.getString(column)).append(")");
                        else row.append(rows.getString(column));
                    }
                    results.add(row.toString());
                }
            }
            return results;
        } catch (SQLException exception) {
            // Surface the DB message so error-based injection is observable in the exercise.
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                failureMessage + " (" + exception.getMessage() + ")");
        }
    }
}
