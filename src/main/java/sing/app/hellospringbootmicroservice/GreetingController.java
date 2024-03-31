package sing.app.hellospringbootmicroservice;

import java.util.concurrent.atomic.AtomicLong;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
public class GreetingController {

	@Autowired
	private GreetingConfig config;

	private static final String GREETING_TEMPLATE = "Hello, %s!";
	private final AtomicLong counter = new AtomicLong();

	@GetMapping("/greeting")
	public Greeting greeting(@RequestParam(value = "name", required = false) String name) {

		String displayName = name == null ? config.getDefaultMessage() : name;

		return new Greeting(counter.incrementAndGet(), String.format(GREETING_TEMPLATE, displayName));
	}
}
