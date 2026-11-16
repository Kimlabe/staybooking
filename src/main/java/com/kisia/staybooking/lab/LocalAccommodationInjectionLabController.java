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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

/** Exposes the lab query on the real accommodation screen only for local loopback requests. */
@RestController
@Profile("local & !mysql")
@ConditionalOnProperty(name = "staybooking.security.injection-lab-enabled", havingValue = "true")
@RequestMapping("/api/v1/accommodations")
public class LocalAccommodationInjectionLabController {
    private final InjectionLabQueryService query;

    public LocalAccommodationInjectionLabController(InjectionLabQueryService query) {
        this.query = query;
    }

    @GetMapping("/lab-status")
    public Map<String, Boolean> status(HttpServletRequest request) {
        requireLoopback(request);
        return Map.of("enabled", true);
    }

    @GetMapping("/lab-search")
    public List<String> search(@RequestParam String keyword, HttpServletRequest request) {
        requireLoopback(request);
        return query.search(keyword);
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
