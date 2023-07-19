package net.infobank.moyamo.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestAdminController {

    @RequestMapping("/rest/")
    public String index() {
        return "Hello";
    }

}
