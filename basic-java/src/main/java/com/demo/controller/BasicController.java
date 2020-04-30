package com.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/v1/basic")
public class BasicController {

    private final Logger logger = LoggerFactory.getLogger(BasicController.class);

    private final String applicationName;
    private final String runningEnv;


    public BasicController(@Value("${application.name}") String applicationName,
                           @Value("${basic.running.environment}") String runningEnv) {
        this.applicationName = applicationName;
        this.runningEnv = runningEnv;
    }

    /**
     * URI: /v1/basic/healthcheck
     *
     * @return
     */
    @GetMapping("/healthcheck")
    public ResponseEntity healthCheck() {
        return new ResponseEntity(applicationName, HttpStatus.OK);
    }

    /**
     * URI: /v1/basic/create
     *
     * @param payload
     * @return
     */
    @PostMapping("/create")
    public ResponseEntity create(@RequestBody String payload) {
        logger.info("Running environment: {} - Create resource: {}", runningEnv, payload);
        return new ResponseEntity(runningEnv + ": Create - successful", HttpStatus.CREATED);
    }

    /**
     * URI: /v1/basic/read
     *
     * @return
     */
    @GetMapping("/read")
    public ResponseEntity read() {
        logger.info("Running environment: {} - Read", runningEnv);
        return new ResponseEntity(runningEnv + ": Read - successful", HttpStatus.OK);
    }

    /**
     * URI: /v1/basic/update
     *
     * @param payload
     * @return
     */
    @PutMapping("/update")
    public ResponseEntity update(@RequestBody String payload) {
        logger.info("Running environment: {} - Update resource: {}", runningEnv, payload);
        return new ResponseEntity(runningEnv + ": Update - successful", HttpStatus.OK);
    }

    /**
     * URI: /v1/basic/delete
     *
     * @return
     */
    @DeleteMapping("/delete")
    public ResponseEntity delete() {
        logger.info("Running environment: {} - Delete resources", runningEnv);
        return new ResponseEntity(runningEnv + ": Delete - successful", HttpStatus.OK);
    }
}
