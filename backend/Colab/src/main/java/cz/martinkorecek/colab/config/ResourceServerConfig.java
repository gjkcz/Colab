package cz.martinkorecek.colab.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.ResourceServerTokenServices;

import cz.martinkorecek.colab.service.ProjectCommentService;
import cz.martinkorecek.colab.service.impl.ProjectCommentServiceImpl;

/*
 * MOST OF THE CODE IN THIS CLASS IS COPIED FROM TUTORIAL https://github.com/nydiarra/springboot-jwt
 */
@Configuration
@EnableResourceServer
public class ResourceServerConfig extends ResourceServerConfigurerAdapter {

	@Autowired
	private ResourceServerTokenServices tokenServices;
	
	@Bean
	public ProjectCommentService projectCommentService() {
		return new ProjectCommentServiceImpl();
	}
	
	@Value("${security.jwt.resource-ids}")
    private String resourceIds;
	
	@Override
	public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
		resources.resourceId(resourceIds).tokenServices(tokenServices);
	}
	
	@Override
	public void configure(HttpSecurity http) throws Exception {
		http
        .requestMatchers()
        .and()
        .authorizeRequests()
        .antMatchers("/actuator/**", "/api-docs/**").permitAll()
        .antMatchers("/springjwt/**" ).authenticated();
	}
}
