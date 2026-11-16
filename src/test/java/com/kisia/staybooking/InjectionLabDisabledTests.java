package com.kisia.staybooking;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest(properties = "staybooking.security.injection-lab-enabled=false")
@ActiveProfiles("local")
@AutoConfigureMockMvc
class InjectionLabDisabledTests {
    @Autowired private MockMvc mvc;

    @Test
    void labEndpointIsAbsentWhenDisabled() throws Exception {
        mvc.perform(get("/api/v1/admin/lab/injection/search")
                .with(request -> {
                    request.setServerName("admin.localhost");
                    return request;
                })
                .with(user("admin").roles("ADMIN"))
                .param("keyword", "Seoul"))
            .andExpect(status().isNotFound());

        mvc.perform(get("/api/v1/accommodations/lab-status")
                .with(request -> {
                    request.setServerName("localhost");
                    request.setRemoteAddr("127.0.0.1");
                    return request;
                }))
            // With the lab controller absent, the normal numeric detail route rejects this path.
            .andExpect(status().isBadRequest());

        // With the lab disabled, the public permit rule for /api/v1/lab/** is never registered,
        // so the route is not openly reachable (falls back to the authenticated /api/** rule).
        mvc.perform(post("/api/v1/lab/injection/login")
                .with(request -> {
                    request.setServerName("localhost");
                    request.setRemoteAddr("127.0.0.1");
                    return request;
                })
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"loginId\":\"admin\",\"password\":\"x\"}"))
            .andExpect(status().isUnauthorized());
    }
}
