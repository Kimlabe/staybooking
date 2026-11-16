package com.kisia.staybooking;

import static org.hamcrest.Matchers.hasItem;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.time.LocalTime;
import java.util.UUID;

import com.kisia.staybooking.accommodation.AccommodationEntity;
import com.kisia.staybooking.accommodation.AccommodationRepository;
import com.kisia.staybooking.user.UserEntity;
import com.kisia.staybooking.user.UserRepository;
import org.junit.jupiter.api.BeforeEach;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.RequestPostProcessor;

@SpringBootTest(properties = "staybooking.security.injection-lab-enabled=true")
@ActiveProfiles("local")
@AutoConfigureMockMvc
class InjectionLabTests {
    @Autowired private MockMvc mvc;
    @Autowired private AccommodationRepository accommodations;
    @Autowired private UserRepository users;
    private String accountId;

    @BeforeEach
    void seedRealApplicationTables() {
        String suffix = UUID.randomUUID().toString().substring(0, 8);
        accountId = "lab-account-" + suffix;
        accommodations.save(new AccommodationEntity("Seoul Lab Stay " + suffix, "Test address",
            LocalTime.of(15, 0), LocalTime.of(11, 0)));
        users.save(new UserEntity(accountId, "synthetic-hash", "Lab user",
            accountId + "@example.test"));
    }

    @Test
    void ordinarySearchUsesRealAccommodationTable() throws Exception {
        mvc.perform(get("/api/v1/admin/lab/injection/search").with(adminHost())
                .with(user("admin").roles("ADMIN"))
                .param("keyword", "Seoul"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasItem(org.hamcrest.Matchers.startsWith("Seoul Lab Stay"))));
    }

    @Test
    void injectedUnionReadsAnotherRealApplicationTable() throws Exception {
        mvc.perform(get("/api/v1/admin/lab/injection/search").with(adminHost())
                .with(user("admin").roles("ADMIN"))
                .param("keyword", "' UNION SELECT login_id FROM users -- "))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasItem(accountId)));
    }

    @Test
    void nonAdminCannotUseLab() throws Exception {
        mvc.perform(get("/api/v1/admin/lab/injection/search").with(adminHost())
                .with(user("guest").roles("USER"))
                .param("keyword", "Seoul"))
            .andExpect(status().isForbidden());
    }

    @Test
    void accommodationScreenLabShowsBooleanInjectionDifference() throws Exception {
        mvc.perform(get("/api/v1/accommodations/lab-status").with(localHost()))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.enabled").value(true));
        mvc.perform(get("/api/v1/accommodations/lab-search").with(localHost())
                .param("keyword", "' OR '1'='2' -- "))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").isEmpty());
        mvc.perform(get("/api/v1/accommodations/lab-search").with(localHost())
                .param("keyword", "' OR '1'='1' -- "))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasItem(org.hamcrest.Matchers.startsWith("Seoul Lab Stay"))));
    }

    @Test
    void accommodationScreenLabRejectsNonLoopbackClient() throws Exception {
        mvc.perform(get("/api/v1/accommodations/lab-search")
                .with(request -> {
                    request.setServerName("localhost");
                    request.setRemoteAddr("192.0.2.10");
                    return request;
                })
                .param("keyword", "Seoul"))
            .andExpect(status().isNotFound());
    }

    @Test
    void loginDemoReproducesAuthenticationBypass() throws Exception {
        // Correct credential match is impossible (synthetic-hash is not the real password),
        // but a comment-out payload on the id bypasses the password predicate entirely.
        mvc.perform(post("/api/v1/lab/injection/login").with(localHost())
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"loginId\":\"" + accountId + "' -- \",\"password\":\"irrelevant\"}"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasItem(org.hamcrest.Matchers.startsWith(accountId))));
    }

    @Test
    void signupCheckReproducesBooleanInjection() throws Exception {
        mvc.perform(get("/api/v1/lab/injection/signup-check").with(localHost())
                .param("loginId", "nope' OR '1'='2"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0]").value("0"));
        mvc.perform(get("/api/v1/lab/injection/signup-check").with(localHost())
                .param("loginId", "nope' OR '1'='1"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0]", org.hamcrest.Matchers.not("0")));
    }

    @Test
    void labBrowserRoutesRejectNonLoopbackClient() throws Exception {
        mvc.perform(post("/api/v1/lab/injection/login")
                .with(request -> {
                    request.setServerName("localhost");
                    request.setRemoteAddr("192.0.2.10");
                    return request;
                })
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"loginId\":\"admin\",\"password\":\"x\"}"))
            .andExpect(status().isNotFound());
    }

    private static RequestPostProcessor localHost() {
        return request -> {
            request.setServerName("localhost");
            request.setRemoteAddr("127.0.0.1");
            return request;
        };
    }

    private static RequestPostProcessor adminHost() {
        return request -> {
            request.setServerName("admin.localhost");
            return request;
        };
    }
}
