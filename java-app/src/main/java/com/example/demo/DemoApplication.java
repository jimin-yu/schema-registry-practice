package com.example.demo;

import com.example.demo.services.KafkaProducer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class DemoApplication {
	public static void main(String[] args) {

		ApplicationContext applicationContext = SpringApplication.run(DemoApplication.class, args);
		KafkaProducer producer = applicationContext.getBean(KafkaProducer.class);

//		producer.sendMessage("Hello from spring");
	}

}
