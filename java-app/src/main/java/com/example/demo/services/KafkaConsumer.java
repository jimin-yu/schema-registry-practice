package com.example.demo.services;
import com.example.demo.Person;
import org.apache.avro.specific.SpecificRecord;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;


@Service
public class KafkaConsumer {
//    @KafkaListener(topics = "sample-topic")
//    public void processMessage(ConsumerRecord<String, Person> record) {
//        Person person = record.value();
//        System.out.println("Consume Message: " + person.toString());
//    }

    @KafkaListener(topics = "sample-topic")
    public void processMessage(ConsumerRecord<String, SpecificRecord> record) {
        Object person = record.value();
        if(person instanceof Person){
            System.out.println("Consume Message: " + person.toString());
        }else{
            System.out.println("Unknown class");
        }
    }
}


