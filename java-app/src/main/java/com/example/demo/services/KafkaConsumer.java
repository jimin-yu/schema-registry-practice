package com.example.demo.services;
import com.example.demo.Person;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;


@Service
public class KafkaConsumer {
    @KafkaListener(topics = "sample-topic")
    public void processMessage(ConsumerRecord<String, Person> record) {
        System.out.println("Consume Message: " + record);
    }
}


