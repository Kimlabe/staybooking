package com.kisia.staybooking;

import com.kisia.staybooking.accommodation.DemoAccommodationDataInitializer;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(properties = "staybooking.demo-data.enabled=true")
@ActiveProfiles("local")
class DemoAccommodationDataInitializerTests {
    @Autowired private JdbcTemplate jdbc;
    @Autowired private DemoAccommodationDataInitializer initializer;

    @Test
    void createsThirtyAccommodationsWithAtLeastTwentyPhysicalRoomsEachWithoutDuplicates() {
        assertDemoCounts();

        initializer.run(null);

        assertDemoCounts();
    }

    private void assertDemoCounts() {
        assertThat(jdbc.queryForObject(
            "select count(*) from accommodations where name like '[샘플] %'", Integer.class)).isEqualTo(30);
        assertThat(jdbc.queryForObject("""
            select count(*) from rooms r join accommodations a on a.accommodation_id = r.accommodation_id
            where a.name like '[샘플] %'
            """, Integer.class)).isEqualTo(134);
        assertThat(jdbc.queryForObject("""
            select min(unit_count) from (
              select a.accommodation_id, sum(r.total_quantity) as unit_count
              from accommodations a join rooms r on r.accommodation_id = a.accommodation_id
              where a.name like '[샘플] %'
              group by a.accommodation_id
            ) seeded
            """, Integer.class)).isGreaterThanOrEqualTo(20);
    }
}
