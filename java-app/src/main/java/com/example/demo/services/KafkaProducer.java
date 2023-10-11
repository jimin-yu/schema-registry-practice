package com.example.demo.services;
import com.example.demo.Person;
import org.springframework.kafka.core.KafkaTemplate;

import org.springframework.stereotype.Service;

@Service
public class KafkaProducer {
    private final KafkaTemplate<String, Object> kafkaTemplate;
    public KafkaProducer(KafkaTemplate<String, Object> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }
    private final String topicName = "sample-topic";

    public void sendMessage(Person person) {
        System.out.println("Publish Message: " + person.toString());
        kafkaTemplate.send(topicName, person);
        System.out.println("DONE");
    }
}
