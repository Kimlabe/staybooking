package com.kisia.staybooking;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.core.env.Environment;

public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(
			SpringApplicationBuilder application) {
		return application.sources(StaybookingApplication.class)
			.initializers(context -> requireMysqlProfile(context.getEnvironment()));
	}

	static void requireMysqlProfile(Environment environment) {
		if (!environment.matchesProfiles("mysql") || environment.matchesProfiles("local")) {
			throw new IllegalStateException(
				"External Tomcat requires SPRING_PROFILES_ACTIVE=mysql; local H2 is not deployable");
		}
	}
}
