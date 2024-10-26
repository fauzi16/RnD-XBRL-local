package com.keda.kedademoproducer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1")
public class KafkaProducerRESTController {
    
    @Autowired
    private KedaProducer producer;

    @PostMapping("/produce-message/{count}")
    public void produceMessage(@PathVariable Integer count){
        producer.produceMessage(count);
    }

    @PutMapping("/set-delay/{delay}")
    public void setDelay(@PathVariable Integer delay){
        producer.setDelay(delay);
    }

    @GetMapping("/check-delay")
    public Integer checkDelay(){
        return producer.getDelay();
    }

}
