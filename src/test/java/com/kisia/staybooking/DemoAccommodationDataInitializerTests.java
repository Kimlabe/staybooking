package com.kisia.staybooking;

import com.kisia.staybooking.accommodation.DemoAccommodationDataInitializer;
import com.kisia.staybooking.accommodation.AccommodationSearchRequest;
import com.kisia.staybooking.accommodation.AccommodationService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.core.io.ClassPathResource;
import org.springframework.test.context.ActiveProfiles;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(properties = "staybooking.demo-data.enabled=true")
@ActiveProfiles("local")
class DemoAccommodationDataInitializerTests {
    @Autowired private JdbcTemplate jdbc;
    @Autowired private DemoAccommodationDataInitializer initializer;
    @Autowired private AccommodationService accommodations;

    @Test
    void createsFortyAccommodationsWithPhotosAndAtLeastTwentyPhysicalRoomsEachWithoutDuplicates() {
        assertDemoCounts();

        Integer originalId = jdbc.queryForObject(
            "select accommodation_id from accommodations where name = '강남 시티 스테이'", Integer.class);
        jdbc.update("update accommodations set name = '[샘플] 강남 시티 스테이' where accommodation_id = ?",
            originalId);
        initializer.run(null);

        assertDemoCounts();
        assertThat(jdbc.queryForObject(
            "select accommodation_id from accommodations where name = '강남 시티 스테이'", Integer.class))
            .isEqualTo(originalId);
    }

    private void assertDemoCounts() {
        assertThat(jdbc.queryForObject(
            "select count(*) from accommodations where address like '% (체험용)'", Integer.class)).isEqualTo(40);
        assertThat(jdbc.queryForObject(
            "select count(*) from accommodations where name like '[샘플] %'", Integer.class)).isZero();
        assertThat(jdbc.queryForObject("""
            select count(*) from rooms r join accommodations a on a.accommodation_id = r.accommodation_id
            where a.address like '% (체험용)'
            """, Integer.class)).isEqualTo(174);
        assertThat(jdbc.queryForObject("""
            select min(unit_count) from (
              select a.accommodation_id, sum(r.total_quantity) as unit_count
              from accommodations a join rooms r on r.accommodation_id = a.accommodation_id
              where a.address like '% (체험용)'
              group by a.accommodation_id
            ) seeded
            """, Integer.class)).isGreaterThanOrEqualTo(20);
        assertThat(accommodations.search(new AccommodationSearchRequest(null, null, null, null, 0, 50))
            .content()).hasSize(40).allSatisfy(item -> {
                assertThat(item.mainImage()).startsWith("/assets/img/demo/");
                assertThat(new ClassPathResource("static" + item.mainImage()).exists()).isTrue();
            });
        var firstId = accommodations.search(new AccommodationSearchRequest(null, null, null, null, 0, 1))
            .content().get(0).accommodationId();
        var detail = accommodations.detail(firstId,
            new AccommodationSearchRequest(null, null, null, null, null, null));
        assertThat(detail.images()).hasSize(1);
        assertThat(detail.rooms()).isNotEmpty().allSatisfy(room -> {
            assertThat(room.image()).startsWith("/assets/img/demo/room-");
            assertThat(new ClassPathResource("static" + room.image()).exists()).isTrue();
        });
    }
}
