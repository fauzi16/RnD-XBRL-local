package com.keda.kedademoconsumer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1")
public class KafkaConsumerRESTController {

    @Autowired
    private KafkaConsumer kafkaConsumer;

    @PutMapping("/set-delay/{delay}")
    public void setDelay(@PathVariable Integer delay){
        this.kafkaConsumer.setDelay(delay);
    }
    
}
