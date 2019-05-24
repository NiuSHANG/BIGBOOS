package config;

import org.apache.struts2.dispatcher.filter.StrutsPrepareAndExecuteFilter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;

import javax.servlet.ServletContext;

public class WebInitializer implements WebApplicationInitializer {
    @Override
    public void onStartup(ServletContext servletContext) {
        // Struts 2
        servletContext.addFilter("struts2", StrutsPrepareAndExecuteFilter.class)
                      .addMappingForUrlPatterns(null, false, "/*");

        // Spring
        AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
        context.register(SpringConfig.class);
        servletContext.addListener(new ContextLoaderListener(context));
    }
}
