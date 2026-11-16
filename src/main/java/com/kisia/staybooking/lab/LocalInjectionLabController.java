package com.kisia.staybooking.lab;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

/**
 * Browser-facing endpoints for the isolated SQL-injection TRAINING LAB.
 *
 * <p>These routes live under an explicit {@code /lab/} path so they are never mistaken for the real
 * search, login or signup APIs — which remain parameterized and are not reachable from here. The lab
 * only loads on the local H2 profile with {@code injection-lab-enabled=true}, and every call is
 * restricted to loopback clients. It is consumed by the clearly-labeled {@code injection-lab.html}
 * practice page, not by the production login/signup forms.
 */
@RestController
@Profile("local & !mysql")
@ConditionalOnProperty(name = "staybooking.security.injection-lab-enabled", havingValue = "true")
@RequestMapping("/api/v1/lab/injection")
public class LocalInjectionLabController {
    private final InjectionLabQueryService query;

    public LocalInjectionLabController(InjectionLabQueryService query) {
        this.query = query;
    }

    @GetMapping("/status")
    public Map<String, Boolean> status(HttpServletRequest request) {
        requireLoopback(request);
        return Map.of("enabled", true);
    }

    @GetMapping("/search")
    public List<String> search(@RequestParam String keyword, HttpServletRequest request) {
        requireLoopback(request);
        return query.search(keyword);
    }

    @PostMapping("/login")
    public List<String> login(@RequestBody LoginLabRequest body,
                              HttpServletRequest request) {
        requireLoopback(request);
        return query.loginDemo(body.loginId(), body.password());
    }

    public record LoginLabRequest(String loginId, String password) {}

    @GetMapping("/signup-check")
    public List<String> signupCheck(@RequestParam String loginId, HttpServletRequest request) {
        requireLoopback(request);
        return query.signupAvailabilityDemo(loginId);
    }

    private static void requireLoopback(HttpServletRequest request) {
        String host = request.getServerName();
        if (!("localhost".equalsIgnoreCase(host) || "127.0.0.1".equals(host) || "::1".equals(host))) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        try {
            if (!InetAddress.getByName(request.getRemoteAddr()).isLoopbackAddress()) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND);
            }
        } catch (UnknownHostException exception) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }
}
