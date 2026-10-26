package com.kisia.staybooking.accommodation;

import javax.sql.DataSource;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Profile;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * 개발·시연용 숙소 데이터. local에서는 기본 활성화하고 mysql에서는 명시적으로 켠 경우에만 실행한다.
 * SQL은 숙소명과 숙소별 객실 유형명을 기준으로 재실행해도 중복 삽입하지 않는다.
 */
@Component
@Profile({"local", "mysql"})
@ConditionalOnProperty(name = "staybooking.demo-data.enabled", havingValue = "true")
public class DemoAccommodationDataInitializer implements ApplicationRunner {
    private final DataSource dataSource;

    public DemoAccommodationDataInitializer(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        new ResourceDatabasePopulator(new ClassPathResource("demo-accommodations.sql")).execute(dataSource);
    }
}
