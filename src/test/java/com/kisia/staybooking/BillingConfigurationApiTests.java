package com.kisia.staybooking;

import com.kisia.staybooking.user.UserEntity;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.context.annotation.Import;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest(properties = {
    "staybooking.toss.client-key=test_ck_example",
    "staybooking.toss.secret-key=test_sk_example",
    "staybooking.billing.encryption-key="
})
@AutoConfigureMockMvc
@Import(TestFixtures.class)
class BillingConfigurationApiTests {
    @Autowired private MockMvc mvc;
    @Autowired private TestFixtures fixtures;

    @Test
    void missingPersistentKeyDisablesBillingButKeepsOrdinaryTossAvailable() throws Exception {
        UserEntity user = fixtures.user("빌링설정확인");
        String authorization = fixtures.bearer(user);

        mvc.perform(get("/api/v1/payments/capabilities").header("Authorization", authorization))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.tossEnabled").value(true))
            .andExpect(jsonPath("$.billingEnabled").value(false));

        mvc.perform(post("/api/v1/payments/billing-keys/customer")
                .header("Authorization", authorization))
            .andExpect(status().isServiceUnavailable())
            .andExpect(jsonPath("$.code").value("BILLING_NOT_CONFIGURED"));
    }
}
