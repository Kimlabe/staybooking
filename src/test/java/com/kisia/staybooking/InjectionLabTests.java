package com.kisia.staybooking;

import static org.hamcrest.Matchers.hasItem;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
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

    private static RequestPostProcessor adminHost() {
        return request -> {
            request.setServerName("admin.localhost");
            return request;
        };
    }
}
