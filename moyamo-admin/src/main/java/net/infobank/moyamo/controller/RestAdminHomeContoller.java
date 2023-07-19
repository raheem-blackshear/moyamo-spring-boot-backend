package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.service.AdminHomeService;
import org.mapstruct.ap.internal.util.Collections;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/rest/home")
public class RestAdminHomeContoller {

    private final AdminHomeService adminHomeService;

    public RestAdminHomeContoller(AdminHomeService adminHomeService) {
        this.adminHomeService = adminHomeService;
    }

    @JsonView(Views.WebAdminJsonView.class)
    @PostMapping("/getAll")
    public List<String> getHomeAll() {
        return adminHomeService.getAllOrders();
    }

    @JsonView(Views.WebAdminJsonView.class)
    @PostMapping("/update")
    public List<String> update(@RequestBody List<String> genres) {
        adminHomeService.updateHomeOrder(genres);
        return genres;
    }

}
