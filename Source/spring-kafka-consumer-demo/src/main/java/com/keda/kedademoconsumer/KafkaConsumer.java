package com.keda.kedademoconsumer;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
public class KafkaConsumer {

    @Value("${spring.kafka.properties.bootstrap.servers}")
    private String bootstrapServers;

    private Integer delay = 5000;

    @KafkaListener(topics = "${kafka.topic}", groupId = "${kafka.consumer-group-id}")
    public void handle(String message) throws InterruptedException {
        System.out.println("Processing message: " + message);
        Thread.sleep(delay);
    }

    public Integer getDelay() {
        return delay;
    }

    public void setDelay(Integer delay) {
        this.delay = delay;
    }

}
