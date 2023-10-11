package com.example.demo;

import com.example.demo.services.KafkaProducer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

/**
 * producer app : @kafkaListener 코드 주석 처리하고 실행하기.
 * consumer app : producer.sendMessage 코드 주석 처리하고 실행하기.
 */

@SpringBootApplication
public class DemoApplication {
	public static void main(String[] args) {

		ApplicationContext applicationContext = SpringApplication.run(DemoApplication.class, args);
		KafkaProducer producer = applicationContext.getBean(KafkaProducer.class);

		Person person = new Person("Yu", "Jimin", 27);
//		producer.sendMessage(person);
	}
}
