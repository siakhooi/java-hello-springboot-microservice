package sing.app.hellospringbootmicroservice;

import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.Value;
import lombok.Data;

@Component
@Data
public class GreetingConfig {
    @Value("${app.defaultGreetingMessage}")
    private String defaultMessage;
}