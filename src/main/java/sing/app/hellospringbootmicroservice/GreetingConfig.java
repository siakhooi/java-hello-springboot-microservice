package sing.app.hellospringbootmicroservice;

import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.Value;

@Component

public class GreetingConfig {
    @Value("${app.defaultGreetingMessage}")
    private String defaultMessage;

    public String getDefaultMessage() {
        return this.defaultMessage;
    }
}