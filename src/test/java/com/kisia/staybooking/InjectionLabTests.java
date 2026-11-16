package com.kisia.staybooking;

import static org.hamcrest.Matchers.hasSize;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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

    @Test
    void ordinarySearchReturnsOnlyMatchingSyntheticStay() throws Exception {
        mvc.perform(get("/api/v1/admin/lab/injection/search").with(adminHost())
                .with(user("admin").roles("ADMIN"))
                .param("keyword", "Seoul"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(1)))
            .andExpect(jsonPath("$[0]").value("Seoul City Stay"));
    }

    @Test
    void injectedPredicateBypassesSyntheticStayFilter() throws Exception {
        mvc.perform(get("/api/v1/admin/lab/injection/search").with(adminHost())
                .with(user("admin").roles("ADMIN"))
                .param("keyword", "' OR 1=1 -- "))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(3)));
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
