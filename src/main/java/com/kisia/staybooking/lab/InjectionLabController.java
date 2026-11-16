package com.kisia.staybooking.lab;

import java.util.List;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Profile;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Intentionally vulnerable SQL injection baseline against the application's local database.
 * This controller is excluded from the shared MySQL profile and requires ROLE_ADMIN.
 */
@RestController
@Profile("local & !mysql")
@ConditionalOnProperty(name = "staybooking.security.injection-lab-enabled", havingValue = "true")
@RequestMapping("/api/v1/admin/lab/injection")
public class InjectionLabController {
    private final InjectionLabQueryService query;

    public InjectionLabController(InjectionLabQueryService query) {
        this.query = query;
    }

    @GetMapping("/search")
    public List<String> search(@RequestParam String keyword) {
        return query.search(keyword);
    }

}
