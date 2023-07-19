package net.infobank.moyamo.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.INotification;
import net.infobank.moyamo.models.Resource;
import net.infobank.moyamo.models.firebase.DynamicLinkRequest;
import net.infobank.moyamo.models.firebase.DynamicLinkResponse;
import net.infobank.moyamo.common.configurations.ServiceHost;
import net.infobank.moyamo.util.CommonUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
public class DeeplinkService {

    @Value("${spring.firebase.dynamiclink.host:https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyAt1xqZBEJb03wzz7XqFW-4Q-3FahNIvgw}")
    private String remoteUrl;

    @Value("${spring.firebase.dynamiclink.domainUriPrefix:https://go.moyamo.co.kr}")
    private String domainUriPrefix; //"https://bbchattest.page.link"


    @Value("${spring.firebase.dynamiclink.linkHost:https://link.moyamo.co.kr}")
    private String linkHost;

    private final ObjectMapper objectMapper;

    private final RestTemplate restTemplate;

    public DeeplinkService(ObjectMapper objectMapper, RestTemplate restTemplate) {
        this.objectMapper = objectMapper;
        this.restTemplate = restTemplate;
    }

    @SneakyThrows
    private String createLinkUrl(Resource resource, String code) {
        if(resource.getReferenceType().isBoardType()) {
            return String.format("%s/postings/%s?postingType=%s&code=%s", linkHost, resource.getReferenceId(), resource.getReferenceType(), code);
        } else if(resource.getReferenceType().equals(Resource.ResourceType.dictionary)) {
            return String.format("http://cms.moyamo.co.kr/plant/%s", URLEncoder.encode(resource.getReferenceId(), "utf-8"));
        } else if(resource.getReferenceType().equals(Resource.ResourceType.advertisement)) {
            /*
             * api 로 referenceId(상대url) 로 api 호출 후 return 된 주소로 페이지 이동
             */
            return resource.getReferenceId();
        } else if(resource.getReferenceType().equals(Resource.ResourceType.shop)) {
            /*
             * api 로 referenceId(상대url) (/v2/shops/page/order) 로 api 호출 후 return 된 주소로 페이지 이동
             */
            return String.format("%s/redirect?resourceType=%s&resourceId=%s&&code=%s", linkHost, resource.getResourceType(), resource.getResourceId(), code);
        } else if(resource.getReferenceType().equals(Resource.ResourceType.web)) {
            return String.format("%s/redirect?resourceType=%s&resourceId=%s&&code=%s", linkHost, resource.getResourceType(), URLEncoder.encode(resource.getResourceId(), "utf-8"), code);
        } else if(resource.getReferenceType().equals(Resource.ResourceType.photoalbum)){
            return String.format("%s/photoAlbums/%s?postingType=%s&code=%s", linkHost, resource.getReferenceId(), resource.getReferenceType(), code);
        }
        else {
            return "https://www.moyamo.co.kr";
        }
    }

    private Map<String, DynamicLinkRequest> build(final INotification iNotification, String code) {

        Resource resource = iNotification.asResource();

        DynamicLinkRequest.AndroidInfo androidInfo;
        DynamicLinkRequest.IosInfo iosInfo;

        DynamicLinkRequest dynamicLinkInfo = DynamicLinkRequest.builder()
                .domainUriPrefix(domainUriPrefix)
                .link(createLinkUrl(resource, code))
                .build();

        androidInfo =  dynamicLinkInfo.new AndroidInfo();
        androidInfo.setAndroidPackageName("com.atlas.moyamo");

        iosInfo =  dynamicLinkInfo.new IosInfo();
        iosInfo.setIosBundleId("kr.co.moyamo.Moyamo");

        DynamicLinkRequest.SocialMetaTagInfo socialMetaTagInfo;
        socialMetaTagInfo = dynamicLinkInfo.new SocialMetaTagInfo();
        socialMetaTagInfo.setSocialTitle("모야모");
        socialMetaTagInfo.setSocialDescription(CommonUtils.convertDotString(iNotification.getText(), 128));

        if(iNotification.getThumbnail() != null) {
            socialMetaTagInfo.setSocialImageLink(ServiceHost.getS3Url(iNotification.getThumbnail().getFilekey()) + "?d=500");
        } else {
            socialMetaTagInfo.setSocialImageLink(ServiceHost.getLogoUrl());
        }

        dynamicLinkInfo.setAndroidInfo(androidInfo);
        dynamicLinkInfo.setIosInfo(iosInfo);
        dynamicLinkInfo.setSocialMetaTagInfo(socialMetaTagInfo);

        Map<String, DynamicLinkRequest> dynamicLinkRequest = new HashMap<>();
        dynamicLinkRequest.put("dynamicLinkInfo", dynamicLinkInfo);
        return dynamicLinkRequest;
    }

    private String toJson(Map<String, DynamicLinkRequest> dynamicLinkRequest) throws JsonProcessingException {
        return objectMapper.writeValueAsString(dynamicLinkRequest);
    }

    private DynamicLinkResponse post(String requestJson) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> param= new HttpEntity<>(requestJson, headers);

        ResponseEntity<DynamicLinkResponse> response = restTemplate
                .exchange(remoteUrl,
                        HttpMethod.POST,
                        param,
                        new ParameterizedTypeReference<DynamicLinkResponse>() {});


        return response.getBody();
    }

    public String getDynamicLink(INotification iNotification, String code) {
        String dynamicLink = null;

        try {
            Map<String, DynamicLinkRequest> dynamicLinkRequest = build(iNotification, code);

            String requestJson = toJson(dynamicLinkRequest);
            DynamicLinkResponse dynamicLinkResponse = post(requestJson);

            DynamicLinkResponse result = Optional.of(dynamicLinkResponse).orElseGet(DynamicLinkResponse::new);
            dynamicLink = result.getShortLink();

            return dynamicLink;

        } catch (RestClientException e){
            log.error("Firebase dynamicLink API - 호출 실패", e);
        } catch (Exception e){
            log.error("Firebase dynamicLink API - 비지니스 로직 에러", e);
        }

        return dynamicLink;
    }

}
