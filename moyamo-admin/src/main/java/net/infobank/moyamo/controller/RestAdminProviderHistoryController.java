package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.UserDto;
import net.infobank.moyamo.dto.UserModifyProviderHistoryDto;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.UserModifyProviderHistory;
import net.infobank.moyamo.repository.AdminProviderHistoryRepository;
import net.infobank.moyamo.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 포스팅 관련 rest api
 *
 * @author jspark
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/providerHistory")
public class RestAdminProviderHistoryController {

    private final AdminProviderHistoryRepository adminProviderHistoryRepository;
    private final UserRepository userRepository;


    // USER 리스트 조회
    @Transactional(readOnly = true)
    @JsonView(Views.WebAdminJsonView.class)
    @RequestMapping("/getList")
    public ResponseEntity<Map<String, Object>> get(@RequestParam("providerId") String providerId) {

        Map<String, Object> map = new HashMap<>();
        List<UserModifyProviderHistoryDto> list = getList(providerId);
        map.put("recordsTotal", list.size());
        map.put("recordsFiltered", list.size());
        map.put("data", list);

        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    @JsonView(Views.WebAdminJsonView.class)
    @RequestMapping("/getUserInfoList")
    public ResponseEntity<Map<String, Object>> getUserInfo(@RequestParam("providerId") String providerId) {
        Map<String, Object> map = new HashMap<>();

        List<UserDto> list = getUserInfoList(providerId);
        map.put("recordsTotal", list.size());
        map.put("recordsFiltered", list.size());
        map.put("data", list);

        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    /*어드민 추가*/
    public List<UserModifyProviderHistoryDto> getList(String providerId) {
        List<UserModifyProviderHistory> list = adminProviderHistoryRepository.getList(providerId);
        return list.stream().map(UserModifyProviderHistoryDto::of).collect(Collectors.toList());
    }

    public List<UserDto> getUserInfoList(String providerId) {
        List<User> list = userRepository.findByProviderId(providerId);
        return list.stream().map(UserDto::of).collect(Collectors.toList());
    }

}
