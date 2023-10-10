package com.example.demo.services;
import org.springframework.kafka.core.KafkaTemplate;

import org.springframework.stereotype.Service;

@Service
public class KafkaProducer {
    private final KafkaTemplate<String, Object> kafkaTemplate;
    public KafkaProducer(KafkaTemplate<String, Object> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }
    private final String topicName = "sample-topic";

    public void sendMessage(String message) {
        System.out.println("Publish Message: " + message);
        kafkaTemplate.send(topicName, message);
        System.out.println("DONE");
    }
}
