# 모야모서버 API문서 

- REST API 서버의 기본 포멧의 정의되지 않아 결과 코드를 제외함 
- 에러 메시지 정의 안됨


## History

| 문서버전 | 작성일     | 설명             | 작성자|
| -------- | ---------- | ---------------- | --------|
| 0.1      | 2020-05-07 | 최초작성         | 박영수|
| 0.1.1      | 2020-05-11 | 사용자 프로필 조회관련 API 추가.     | 박영수|
| 0.1.2      | 2020-05-12 | 답변목록 조회 api 필드 추가(mentioned.nickname)<br>알림 읽음 처리 API 추가.<br>알림받기, 취소 API 추가.<br>신고(게시글,댓글) API 추가 | 박영수 |
| 0.1.3      | 2020-05-13 | 토큰 변경 | 박영수 |
| 0.1.4      | 2020-05-15 | 도감검색, 자동완성, 추천검색어 조회 추가  | 박영수 |
| 0.1.5      | 2020-05-21 | 게시글수정 api 추가<br> 게시글조회(/v2/search) 내글만보기(`mine`) 필터 추가 | 박영수 |
| 0.1.6      | 2020-05-22 | 답글수정 api 추가 | 박영수 |
| 0.1.7      | 2020-05-26 | 공유하기 api 추가<br> 게시글 등록 / 게시글 등록/수정 title 필드 추가(자랑하기만)<br> 검색 정렬 mostComments 추가 | 박영수 |
| 0.1.8      | 2020-06-01 | 샵 상품 검색 api 추가 [상품검색](#<code>GET</code>--/v2/shops/goods) <br> 내프로필 조회 `provider` 필드 추가 [내프로필조회](#<code>GET</code>--/v2/users/me) | 박영수 |
| 0.1.9      | 2020-06-04 | ~~~샵 접속주소 조회 API추가 [홈 이동주소 조회](#<code>GET</code>  /v2/shops/home) <br> [카트 이동주소 조회](#<code>GET</code>  /v2/shops/cart) <br> [주문목록 이동주소 조회](#<code>GET</code>  /v2/shops/orderDto)~~~ <br> [FCM 알림방송 테스트 api](#<code>GET</code>--/v2/shops/goods/test)| 박영수 |
| 0.1.10      | 2020-06-08 | 도감 공유하기 api 추가 [공유하기](#<code>GET</code>--/v2/dictionaries/{name}/share)| 박영수 |
| 0.1.11      | 2020-06-11 | 샵 접속 주소 변경 | 박영수 |
| 0.1.12      | 2020-06-15 | 검색결과 갯수조회 API 추가. <br>[검색결과 갯수 조회](#<code>GET</code>--/v2/search/count) <br> [상품 검색결과 갯수 조회](#<code>GET</code>--/v2/shops/goods/count) <br> [추천 상품 검색결과 갯수 조회](#<code>GET</code>--/v2/shops/goods/recommended/count)| 박영수 |
| 0.1.13      | 2020-06-17 | 상품검색 리뷰수 필드 추가.(`reviewCnt`) | 박영수 |
| 0.1.14      | 2020-06-23 | 가이드북 poster entity 추가.(`posters`) | 박영수 |
| 0.1.15      | 2020-07-01 | 앱 릴리즈 버전 조회 | 박영수 |
| 0.1.16      | 2020-07-06 | 쇼핑몰 마일리지, 마일리지/예치금 통합조회, 쇼핑몰 주소(mileage, refund, shipping) 추가  | 박영수 |
| 0.1.17      | 2020-07-08 | 알림수신설정 수정/조회  API 추가. [내알림설정조회](#<code>GET</code>-/v2/notifications/setting) [내알림설정수정](#<code>POST</code>-/v2/notifications/setting)  | 박영수 |
| 0.1.18      | 2020-07-13 | 상품조회 정렬 추가(`orderby`) , 사진 해상도 필드 추가(dimension) | 박영수 |
| 0.1.19      | 2020-07-30 | 게시글 정렬옵션 `sortby` 추가. [정책](#정책) 정책(개인정보취급방침, 이용약관, 위치정보이용약관) | 박영수 |
| 0.1.20      | 2020-08-03 | 댓글 사용자 언급 여러명 가능하도록 수정, 댓글에서 언급사용자(`@`) 조회 API 추가. [답글등록](#<code>POST</code>--/v2/postings/{id}/comments), [대댓글등록](#<code>POST</code>--/v2/comments/{id}/reply), [게시글참여자목록](#<code>GET</code>--/v2/postings/{id}/users)<br> - 언급 사용자는 참여자 목록을 조회해 목록에서 선택된 사용자(`@[{user-id}])`)만 유효하고 직접입력된 @닉네임은 단순 텍스트로만 저장하고 색또한 일반 텍스트와 동일합니다.<br><br>  게시글 상세 페이지 상품노출 field 추가(`goodses`) | 박영수 |
| 0.1.21      | 2020-08-04 | 알림설정 필드 추가 [내알림설정조회](#<code>GET</code>-/v2/notifications/setting) [내알림설정수정](#<code>POST</code>-/v2/notifications/setting) | 박영수 |
| 0.1.22      | 2020-08-05 | 알림목록, PUSH 알림의 `resource` 의 속성 `resourceType` 이 `shop` 일경우 `resourceId` 로 이동할 페이지 주소 조회 <br> [리소스로 이동주소 조회](#<code>GET</code>  /v2/shops/page/redirect) | 박영수 |
| 0.1.23      | 2020-08-06 | 알림설정 필드 추가 `replyNotiEnable`[내알림설정조회](#<code>GET</code>-/v2/notifications/setting) | 박영수 |
| 0.1.24      | 2020-08-12 | 알림설정 및 로그인 필드 추가. `adNotiConfirmedAt`, `adNotiAgreement` <br> - 로그인시 `adNotiAgreement` 가 null일 경우 팝업 띄움<br> - 수신 동의시 `adNotiAgreement` 필드만 업데이트 <br><br> [내알림설정조회](#<code>GET</code>-/v2/notifications/setting) | 박영수 |
| 0.1.25      | 2020-08-13 | 배너  조회 api 추가. [배너 조회](#<code>GET</code>--/v2/banners)<br> 공지사항 조회 api 추가. [공지사항 조회](#<code>GET</code>--/v2/notices) | 박영수 |
| 0.1.26      | 2020-08-18 | [정책](#정책) 공지사항 추가. | 박영수 |
| 0.1.27      | 2020-09-18 | [추천검색어]() 추천검색어 조회 수정  | 박영수 |
| 0.1.28      | 2020-09-21 | [앱 릴리즈 버전 조회](#<code>GET</code>-/v2/notices/apps/release) 수정, [클라이언트 로그 업로드](#<code>GET</code>-/v2/logs) , [내알림설정조회, 내알림설정수정](#<code>GET</code>-/v2/notifications/setting) 필드추가 (joinCommentNotiEnable) , ResourceType 추가(web - id 주소로 이동)  | 박영수 |
| 0.1.29      | 2020-09-23 | [사용자 검색](#<code>GET</code>-/v2/search/users)  | 박영수 |
| 0.1.30      | 2021-01-07 | [web 리소스로 이동주소 조회](#<code>GET</code>-/v2/webs/page/redirect)  | 박영수 |
| 0.1.31      | 2021-01-11 | [이벤트 팝업 조회](#<code>GET</code>-/v2/events (공지와 구조 동일))  | 박영수 |
| 0.1.32      | 2021-02-04 | 클리닉 게시글 등록,업데이트,조회 필드추가. (condition) | 박영수 |
| 0.1.33      | 2021-02-18 | [유사게시글조회](#<code>GET</code>--/v2/postings/{id}/similarContent) 필드추가(`offset`, `count`, `orderby`, `sortby`) <br> [대댓글등록](#<code>POST</code>--/v2/comments/{id}/:commentType) 감사인사, 채택 구분 추가 <br> <br> [채택답변조회](#<code>GET</code>--/v2/postings/{id}/comments/adopt) 추가 | 박영수 |
| 0.1.34      | 2021-02-18 | [내알림설정조회](#<code>GET</code>-/v2/notifications/setting) [내알림설정수정](#<code>POST</code>-/v2/notifications/setting) 전체 알림 설정(최상위 조건 알림설정) 필드(notiEnable)  추가  | 박영수 |
| 0.1.35      | 2021-02-22 | 프로필 조회 시 획득 뱃지의 갯수와 대표뱃지 조회 추가.<br> 프로필 조회 필드 추가(badgeCount, representBadge)  <br> <br> 뱃지 조회 api 추가. [획득뱃지조회](#<code>GET</code>--/v2/users/me/badges) <br> 대표뱃지 설정 api 추가. [내대표뱃지수정](#<code>POST</code>--/v2/users/me/badges/{id}/representBadge) <br> 다른 사용자의 뱃지 조회 api 추가. [다른사용자의뱃지조회](#<code>GET</code>--/v2/users/{id}/badges)| 허정인
| 0.1.36      | 2021-02-23 | [내알림설정조회](#<code>GET</code>-/v2/users/me/adopts) 추가  | 박영수 |
| 0.1.37      | 2021-03-29 | [랭킹조회](#<code>GET</code>-/v2/rankings), [랭킹정렬조회](#<code>GET</code>-/v2/rankings/order) 추가  | 박영수 |
| 0.1.38      | 2021-05-06 | 포토, 포토 앨범 기능 api 추가 | 허정인 |
| 0.1.39      | 2021-05-14 | 포토앨범 내 상세 조회 추가, 모아보기-포토 추가, [인기작가](#<code>GET</code>--/v2/photoAlbums/popularWriters) 추가, 사용자의 인기사진 추가 | 허정인 |
| 0.1.40      | 2021-05-26 | [포토앨범 내 포토 개수 조회](#<code>GET</code>--/v2/photoAlbums/{id}/photoCount) api 추가, 프로필 조회 필드 추가 (photoEnable) | 허정인 |

## 목차

목차
[서버정보](#서버 정보)
[API](#API)
1. [게시글조회](#게시글조회)

- [모아보기](#<code>GET</code>--/v2/home)
- [더보기](#<code>GET</code>--/v2/search)
- [검색결과 갯수 조회](#<code>GET</code>--/v2/search/count)
- [게시글상세](#<code>GET</code>--/v2/postings/{id})
- [게시글상세활동정보-(좋아요,알림받기,스크랩)](#<code>GET</code>--/v2/postings/{id}/activity)
- [게시글등록](#<code>POST</code>--/v2/postings)
- [게시글수정](#<code>PUT</code>--/v2/postings/{id})
- [게시글삭제](#<code>DELETE</code>--/v2/postings/{id})
- [좋아요](#<code>POST</code>--/v2/postings/{id}/like)
- [좋아요취소](#<code>DELETE</code>--/v2/postings/{id}/like)
- [스크랩](#<code>POST</code>--/v2/postings/{id}/scrap)
- [스크랩취소](#<code>DELETE</code>--/v2/postings/{id}/scrap)
- [신고하기](#<code>POST</code>--/v2/postings/{id}/report)
- [알림받기](#<code>POST</code>--/v2/postings/{id}/watch)
- [알림받기취소](#<code>DELETE</code>--/v2/postings/{id}/watch)
- [공유하기](#<code>POST</code>--/v2/postings/{id}/share)
- [게시글참여자목록](#<code>GET</code>--/v2/postings/{id}/users)
- [답글목록조회](#<code>GET</code>--/v2/postings/{id}/comments)
- [답글등록](#<code>POST</code>--/v2/postings/{id}/comments)
- [대댓글등록](#<code>POST</code>--/v2/comments/{id}/:commentType)
- [답글수정](#<code>PUT</code>--/v2/comments/{id})
- [답글삭제](#<code>DELETE</code>--/v2/comments/{id})
- [답글신고하기](#<code>POST</code>--/v2/comments/{id}/report)
- [유사게시글조회](#<code>GET</code>--/v2/postings/{id}/similarContent)

2. [프로필조회](#프로필조회)

- [내프로필조회](#<code>GET</code>--/v2/users/me)
- [내좋아요목록](#<code>GET</code>--/v2/users/me/likes)
- [내스크랩목록](#<code>GET</code>--/v2/users/me/scraps)
- [내게시글목록](#<code>GET</code>--/v2/users/me/postings)
- [내답변글목록](#<code>GET</code>--/v2/users/me/comments)
- [내채택된글목록](#<code>GET</code>--/v2/users/me/adopts)
- [내알림목록](#<code>GET</code>--/v2/notifications)
- [내알림설정조회](#<code>GET</code>-/v2/notifications/setting)
- [내알림설정수정](#<code>POST</code>-/v2/notifications/setting)
- [사용자 검색](#<code>GET</code>-/v2/search/users)

- [내알림전체읽음처리](#<code>POST</code>--/v2/notifications/markRead)
- [내알림개별읽음처리](#<code>POST</code>--/v2/notifications/{id}/markRead)

- [획득뱃지조회](#<code>GET</code>--/v2/users/me/badges)
- [내대표뱃지수정](#<code>POST</code>--/v2/users/me/badges/{id}/representBadge)
- [다른사용자의뱃지조회](#<code>GET</code>--/v2/users/{id}/badges)

3. [검색어](#검색어)
- [추천검색어](#<code>GET</code>--/v2/tags/recommended)
- [자동완성](#<code>GET</code>--/v2/tags/autocomplete)

4. [도감](#도감)
- [도감조회](#<code>GET</code>--/v2/dictionaries/{name})
- [공유하기](#<code>GET</code>--/v2/dictionaries/{name}/share)

5. [쇼핑몰](#쇼핑몰)
- [상품검색](#<code>GET</code>--/v2/shops/goods)
- [상품 검색결과 갯수 조회](#<code>GET</code>--/v2/shops/goods/count)
- [추천상품 검색](#<code>GET</code>--/v2/shops/goods/recommended) 
- [추천상품 검색결과 갯수 조회](#<code>GET</code>--/v2/shops/goods/recommended/count)

- [쇼핑몰 이동주소 조회](#<code>GET</code>--/v2/shops/page/{name})
- [상품 디테일 이동주소 조회](#<code>GET</code>--/v2/shops/page/goods/{id})
- [예치금 조회](#<code>GET</code>--/v2/shops/deposit)
- [마일리지 조회](#<code>GET</code>--/v2/shops/mileage)
- [예치금/마일리지 통합 조회](#<code>GET</code>--/v2/shops/wallet)

- [FCM 알림방송 테스트 api](#<code>GET</code>--/v2/shops/goods/test)

6. [공지](#공지)
- [앱 릴리즈버전 조회](#<code>GET</code>-/v2/notices/apps/release)

7. [배너](#배너)
- [배너 조회](#<code>GET</code>--/v2/banners)

8. [정책](#정책)
- [정책 조회](#<code>GET</code>--/v2/policies/page/:name)

9. [로그](#로그)
- [클라이언트 로그 업로드](#<code>GET</code>-/v2/logs) 

10. [리소스](#리소스)
- [shop 리소스로 이동주소 조회](#<code>GET</code>--/v2/shops/page/redirect)
- [통합 리소스로 이동주소 조회](#<code>GET</code>--/v2/page/redirect)

11. [랭킹](#랭킹)
- [랭킹조회](#<code>GET</code>--/v2/rankings)
- [랭킹정렬조회](#<code>GET</code>--/v2/rankings/order)

12. [FCM](#FCM)

13. [포토](#포토)

- [포토앨범 조회](#<code>GET</code>--/v2/photoAlbums?userId={userId})
- [포토앨범 상세 조회](#<code>GET</code>--/v2/photoAlbums/{photoAlbumId})
- [마이페이지 대표 사진, 인기사진](#<code>GET</code>--/v2/photoAlbums/representPhotos?userId={userId})


- [포토앨범 생성](#<code>POST</code>--/v2/photoAlbums)
- [포토앨범 수정](#<code>PUT</code>--/v2/photoAlbums/{id})
- [포토앨범 삭제](#<code>DELETE</code>--/v2/photoAlbums/{id})
- [포토앨범 내에서 포토 등록](#<code>POST</code>--/v2/photoAlbums/me/{id})
- [포토앨범 내 포토 개수 조회](#<code>GET</code>--/v2/photoAlbums/{id}/photoCount)


- [포토 등록](#<code>POST</code>--/v2/photos)
- [포토 수정](#<code>PUT</code>--/v2/photos/{id})
- [포토 삭제](#<code>PUT</code>--/v2/photos/delete)
- [포토 이동](#<code>PUT</code>--/v2/photos/move)
- [포토 복사](#<code>PUT</code>--/v2/photos/copy)
  
- [포토 조회](#<code>GET</code>--/v2/photos/{id})
- [포토 좋아요](#<code>POST</code>--/v2/photos/{id}/like)
- [포토 좋아요취소](#<code>DELETE</code>--/v2/photos/{id}/like)
- [포토 신고하기](#<code>POST</code>--/v2/photos/{id}/report)

- [포토별](#<code>GET</code>--/v2/search)
- [작가별](#<code>GET</code>--/v2/search/writerUsers)
- [인기작가](#<code>GET</code>--/v2/photos/popularWriters)


- [포토앨범 공유하기](#<code>POST</code>--/v2/photoAlbums/{id}/share)


## 서버 정보

### URL

| 구분               | |
| ------------------ | --------------------- |
| Dev                | http://moyamo-develop-rest-1302610380.ap-northeast-2.elb.amazonaws.com/     |
| Staging            | - |
| Production         | -                |

### 토큰

| 토큰 | 사용자     | 설명             | |
| -------- | ---------- | ---------------- | --------|
| Bearer a | 사용자1 |          | |
| Bearer b | 사용자2 |          | |
| Bearer c | 사용자3 |          | |
|       |  | | |




# API

### 공통 

- Header

	| attribute | description | required | default |
	| --- | --- | -------- | --- |
	| `Authorization` | 인증키 `Bearer {token}` | `true` | ---  |

- Response 

	| attribute      | description         | default                    |
	| -------------- | ------------------  | -------------------------- |
	| resultCode    | 결과 코드          | `true`   | 1000 : 정상<br>9000 : 에러 |
	| resultData | 각 결과의 {object} ||
	| resultMsg         | 결과 메시지        ||

	```
	{
		resultCode : 1000
		resultData : {Object}
		resultMsg : "메시지"
    }
  ```



### Enumeration

- PostingType

```
     - question("질문하기", Question.class),
     - boast("자랑하기", Boast.class),
     - clinic("식물클리닉", Clinic.class),
     - guidebook("가이드북", Guide.class),
     - free("자유게시판", Free.class),
     - magazine("매거진", Magazine.class),
     - photo("포토", Photo.class)

```


- ResourceType

```
  # 각 게시글 
  boast
  clinic
  free
  guide
  magazine
  question
  photo
  
  comment : 댓글
  reply : 대댓글
  likeposting : 게시글 좋아요, 
  likecomment (사용안함)
  advertisement : 광고, 
  shop : 쇼핑관련, 
  web : 웹뷰 접속
```

- EventType

```
    NEW_QUESTION
    NEW_BOAST,
    NEW_CLINIC,
    NEW_GUIDE,
    NEW_MAGAZINE,
    NEW_COMMENT,
    NEW_LIKE_POSTING,
    NEW_LIKE_COMMENT,
    NEW_AD
```

## 게시글조회 

### <code>GET</code>  /v2/home

`모아보기`

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `postingType` | 게시글 타입 | |`question`|
    | `q` | 검색어 | ||

- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `posters`  | 가이드북 포스터 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |

   * success response
   
        ```
         [
                {
                    "id": 28,
                    "text": "boast",
                    "readCount": 0,
                    "commentCount": 19,
                    "likeCount": 2,
                    "attachments": [
                        {
                            "id": 32,
                            "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                            "description" : "", #optional,
                            "dimension" : "1080,920"
                        }
                    ],
                    "posters": [
                           {
                               "id": 32,
                               "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                               "description" : "", #optional
                                "dimension" : "1080,920"
                    }],
                    "owner": {
                        "id": 1,
                        "nickname": "user1",
                        "levelInfo": {
                            "badge": "/assets/img/badges/badge0.png",
                            "level": 1,
                            "name": "일반"
                        }
                    },
                    "postingType": "boast",
                    "createdAt": "2020-04-23T15:09:53+09:00",
                    "modifiedAt": "2020-04-24T15:50:11+09:00"
                }
         ]
     ```


### <code>GET</code>  /v2/search

`더보기` 게시글 목록 조회 / 검색

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `postingType` | 게시글 타입 | |`question`|
    | `q` | 검색어 | ||
    | `offset` | orderby 가 'popular' 일 경우 | | |
    | `sinceId` | orderby 가 'id' 일 경우 timeline 조회 | | |
    | `maxId` | orderby 가 'id' 일 경우 timeline 조회 | | |
    | `count` | 목록수 | | `10`|
    | `orderby` | 정렬 (`id` or `popular` or`mostComments`) | | `id`  |
    | `sortby` | 정렬 (`desc` or `asc`) | | postingType 이 guide 일경우 `asc` 나머지는 `desc` |
    | `mine` | 내글만 보기 | | false  |
    | `mostComments` | 댓글갯수 필터 | | false  |
    | `day` | 검색기간(일) | | false  |

    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `posters`  | 가이드북 포스터 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |
       | `isScrap`  | postingType 화면에 따라 노출 여부가 다름<br> magazine, 자랑하기만 노출  |  |  |

   * success response
   
        ```
         [
                {
                    "id": 28,
                    "text": "boast",
                    "readCount": 0,
                    "commentCount": 19,
                    "likeCount": 2,
                    "attachments": [
                        {
                            "id": 32,
                            "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                            "description" : "", #optional
                            "dimension" : "1080,920" 
                        }
                    ],
                     "posters": [
                        {
                            "id": 32,
                            "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                            "description" : "", #optional
                            "dimension" : "1080,920"
                        }
                     ],
                    "owner": {
                        "id": 1,
                        "nickname": "user1",
                        "levelInfo": {
                            "badge": "/assets/img/badges/badge0.png",
                            "level": 1,
                            "name": "일반"
                        }
                    },
                    "postingType": "boast",
                    "createdAt": "2020-04-23T15:09:53+09:00",
                    "modifiedAt": "2020-04-24T15:50:11+09:00",
                    "isScrap" : false
                }
         ]
        ```


### <code>GET</code>  /v2/search/count

게시글 검색결과 갯수 조회 

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `postingType` | 게시글 타입 | |`question`|
    | `q` | 검색어 | ||
    | `sinceId` | orderby 가 'id' 일 경우 timeline 조회 | | |
    | `maxId` | orderby 가 'id' 일 경우 timeline 조회 | | |
    | `orderby` | 정렬 (`id` or `popular` or`mostComments`) | | `id`  |
    | `mine` | 내글만 보기 | | false  |
    
- Response (application/json)

   * success response
   
```
{갯수}
```



### <code>GET</code>  /v2/postings/{id}

게시글 상세 조회

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `posters`  | 가이드북 포스터 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |
       | `isLike`  | 좋아요 여부 |  |  |
       | `goodses`  | 상품 노출 필드 (리스트지만 첫번째만 노출) |  |  |

   * success response
   
```
         
        {
            "id": 28,
            "text": "boast",
            "readCount": 0,
            "commentCount": 19,
            "likeCount": 2,
            "attachments": [
                {
                    "id": 32,
                    "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                    "description" : "", #optional
                    "dimension" : "1080,920"
                }
            ],
            "posters": [
            	{
            		"id": 32,
            		"photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
            		"description" : "", #optional
                    "dimension" : "1080,920"
            	}
            ],
            "owner": {
                "id": 1,
                "nickname": "user1",
                "levelInfo": {
                    "badge": "/assets/img/badges/badge0.png",
                    "level": 1,
                    "name": "일반"
                }
            },
            "goodses": [
                {
                    "goodsNo": "1000001772",
                    "photoUrl": "http://moyamo.godomall.com/data/goods//70/01/01/1000001772/1000001772_main_074.jpg",
                    "reviewCnt": 0,
                    "resource": {
                        "resourceId": "http://moyamo-develop-rest-1302610380.ap-northeast-2.elb.amazonaws.com/v2/shops/goods/1000001772",
                        "resourceType": "shop",
                        "referenceId": "http://moyamo-develop-rest-1302610380.ap-northeast-2.elb.amazonaws.com/v2/shops/goods/1000001772",
                        "referenceType": "shop"
                    },
                    "name": "[꽃씨] 블루데이지(별청화국, Felicia) 20립",
                    "price": 1500,
                    "discountedPrice": 1500
                }
            ],
            "postingType": "boast",
            "createdAt": "2020-04-23T15:09:53+09:00",
            "modifiedAt": "2020-04-24T15:50:11+09:00",
            "isLike" : true
        }
 
```
   
### <code>GET</code>  /v2/postings/{id}/activity

게시글 활동 조회 

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `isLike`  | 좋아요 여부 |  |  |
       | `isWatch`  | 알림설정 여부 |  |  |
       | `isScrap`  | 스크랩 여부 |  |  |

   * success response
   
```  

       {
               "isLike": false,
               "isScrap": false,
               "isWatch": true
       }
       
```

### <code>POST</code>  /v2/postings

게시글 등록

- Parameter(multipart/form)

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `text` | 작성글내용 | true ||
    | `files` | 파일(multiple) | true ||
    | `descriptions` | 파일 설명(multiple) | ||
    | `postingType` | 타입 |true | |
    | `place` | clinic 추가정보 <br> INDOOR("실내"), OUTDOOR("실외"), VERANDA("베란다")|true | |
    | `water` | clinic 추가정보 <br> PERIOD("주기적으로 한 번씩"), LITTLE("조금씩 자주"), THINK("생각날 때마다 한 번 씩"), HARD_DRY("흙이 충분히 마른 후 듬뿍"), DRY("겉흙이 마른 후 듬뿍"), ETC("기타")  |true | |
    | `light` | clinic 추가정보 <br> SHADE("음지"), SUN("양지"), HALF("반양지/반음지") |true | |
    | `repotting` | clinic 추가정보 <br> UNDER_TWO_WEEKS("2주 이내"), UNDER_TWO_YEARS("2년 이내"), OVER_TWO_YEARS("2년 이후"), NONE("없음") |true | |
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |
       | `condition.place`  | clinic 추가정보<br> INDOOR("실내"), OUTDOOR("실외"), VERANDA("베란다") |  |  |
       | `condition.light`  | clinic 추가정보<br> SHADE("음지"), SUN("양지"), HALF("반양지/반음지") |  |  |
       | `condition.water`  | clinic 추가정보<br> PERIOD("주기적으로 한 번씩"), LITTLE("조금씩 자주"), THINK("생각날 때마다 한 번 씩"), HARD_DRY("흙이 충분히 마른 후 듬뿍"), DRY("겉흙이 마른 후 듬뿍")|  |  |
       | `condition.repotting`  | clinic 추가정보<br> UNDER_TWO_WEEKS("2주 이내"), UNDER_TWO_YEARS("2년 이내"), OVER_TWO_YEARS("2년 이후"), NONE("없음")|  |  |

   * success response
   
```
         
        {
            "id": 28,
            "text": "boast",
            "readCount": 0,
            "commentCount": 19,
            "likeCount": 2,
            "attachments": [
                {
                    "id": 32,
                    "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                    "description" : "", #optional
                    "dimension" : "1080,920"
                }
            ],
            "owner": {
                "id": 1,
                "nickname": "user1",
                "levelInfo": {
                    "badge": "/assets/img/badges/badge0.png",
                    "level": 1,
                    "name": "일반"
                }
            },
            "postingType": "boast",
            "createdAt": "2020-04-23T15:09:53+09:00",
            "modifiedAt": "2020-04-24T15:50:11+09:00",
            "condition": { # 클리닉만
                "place": "INDOOR",
                "light": "SHADE",
                "water": "DRY",
                "repotting": "NONE"
            }
        }
 
```

### <code>PUT</code>  /v2/postings/{id}

게시글 수정

- Parameter(multipart/form)

```
        1. attachment 수정은 files, descriptions, ids 쌍을 가집니다. (모든 키를 포함해야함)
        2. ids 는 기존 업로드 데이터를 유지할때 사용하고, 기존 attachment.id 가 없을 경우 삭제합니다.
        3. 키 쌍을 기준으로 업로드 파일을 정렬합니다.  
```

*    
    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `text` | 작성글내용 | true ||
    | `files` | 파일(multiple) | true ||
    | `descriptions` | 파일 설명(multiple) |||
    | `ids` | attachment.id (multiple) |||
    

- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |
       | `posters`  | 가이드북 포스터 |  |  |

   * success response
   
```
         
        {
            "id": 28,
            "text": "boast",
            "readCount": 0,
            "commentCount": 19,
            "likeCount": 2,
            "attachments": [
                {
                    "id": 32,
                    "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                    "description" : "", #optional
                    "dimension" : "1080,920"     
                }
            ],
             "posters": [
                     {
                         "id": 32,
                         "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                         "description" : "", #optional
                         "dimension" : "1080,920"     
                     }
                 ]
            "owner": {
                "id": 1,
                "nickname": "user1",
                "levelInfo": {
                    "badge": "/assets/img/badges/badge0.png",
                    "level": 1,
                    "name": "일반"
                }
            },
            "postingType": "boast",
            "createdAt": "2020-04-23T15:09:53+09:00",
            "modifiedAt": "2020-04-24T15:50:11+09:00"
        }
 
```

### <code>DELETE</code>  /v2/postings/{id}

게시글 삭제

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글 id |||

- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `posters`  | 가이드북 포스터 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |

   * success response
   
```
         
        {
            "id": 28,
            "text": "boast",
            "readCount": 0,
            "commentCount": 19,
            "likeCount": 2,
            "attachments": [
                {
                    "id": 32,
                    "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                    "description" : "", #optional
                    "dimension" : "1080,920"     
                },
            ],
            "posters": [
                          {
                              "id": 32,
                              "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                              "description" : "", #optional
                            "dimension" : "1080,920"     
            }],
            "owner": {
                "id": 1,
                "nickname": "user1",
                "levelInfo": {
                    "badge": "/assets/img/badges/badge0.png",
                    "level": 1,
                    "name": "일반"
                }
            },
            "postingType": "boast",
            "createdAt": "2020-04-23T15:09:53+09:00",
            "modifiedAt": "2020-04-24T15:50:11+09:00"
        }
 
```




### <code>POST</code>  /v2/postings/{id}/like

좋아요

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    
- Response (application/json)

   * success response
   
```

    true, false
    
```

### <code>DELETE</code>  /v2/postings/{id}/like

좋아요 취소

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    
- Response (application/json)

   * success response
   
```

true, false

```
   

### <code>POST</code>  /v2/postings/{id}/scrap

스크랩

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    
- Response (application/json)

   * success response
   
```

true, false

```

### <code>DELETE</code>  /v2/postings/{id}/scrap

스크랩취소

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    
- Response (application/json)

   * success response
   
```

true, false

```
   
### <code>POST</code>  /v2/postings/{id}/report

신고하기

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    | `title` | 신고항목 | ||
    | `text` | 내용 | ||
    
- Response (application/json)

   * success response
   
```
    true, false
```
   

### <code>POST</code>  /v2/postings/{id}/watch

알림받기

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||

- Response (application/json)

   * success response
   
```

true, false

```


### <code>DELETE</code>  /v2/postings/{id}/watch

알림받기 취소

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    
- Response (application/json)

   * success response
   
```

true, false

```


### <code>POST</code>  /v2/postings/{id}/share
`TODO`
공유하기 (스팩 정리안됨)

- Parameter

    | atㅏtribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||

- Response (application/json)

   * success response
    
```

        {
                "id": "e997176e-c924-40c3-b992-e54e2e5fccca",
                "resource": {
                    "resourceId": "10004",
                    "resourceType": "question",
                    "referenceId": "10004",
                    "referenceType": "question"
                },
                "deeplink": "https://devmoyamo.page.link/kPLjjM6siR6B6qt6A"
            }
            
```

   * 링크 정의 
     
```
            https://devmoyamo.page.link/kPLjjM6siR6B6qt6A
            
            -> https://link.moyamoplus.co.kr/postings/10004?postingType=question&code=7041a745-45d3-44a8-8ebd-cf179ad24f1e
```


### <code>GET</code>  /v2/postings/{id}/users

게시글 참여자 목록 (댓글 언급 닉네임 조회용)

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    | `q` | 검색어 | ||
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | 사용자ID |  |  |
       | `nickname`  | 닉네임 |  |  |

   * success response
   
        ```
        [
            {
                "id": 111,
                "nickname": "111"
            }
        ]
        ```


### <code>GET</code>  /v2/postings/{id}/comments

답글 목록 조회

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |
       | `isLike`  | 좋아요 여부 |  |  |

   * success response
   
        ```
        [
            {
                "id": 111,
                "text": "111",
                "owner": {
                    "id": 1,
                    "nickname": "user1",
                    "levelInfo": {
                        "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                        "level": 1,
                        "name": "일반"
                    }
                },
                "createdAt": "2020-05-07T08:42:46.554+09:00",
                "modifiedAt": "2020-05-07T08:42:46.554+09:00",
                "isLike": false
            }
           
        ]
        ```
    
### <code>POST</code>  /v2/postings/{id}/comments

답글 등록

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | true ||

- Parameter(multipart/form)

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `text` | 내용, 사용자 언급 `@[{user-id}]` | true | |
    | `files` | 업로드 파일 | | |     
    

- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용, `@[{user-id}]` 를 사용자 닉네임으로 대체   |  |  |
       | `plainText`  | 내용 원본 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |
       | `mentions`  | 언급 사용자 목록(id, nickname), plainText 의 `@[{user-id}]` 를 닉네임으로 대체해야 합니다. |  |  |

   * success response
   
        ```
        [
            {
                "id": 111,
                "text": "111",
                "owner": {
                    "id": 1,
                    "nickname": "user1",
                    "levelInfo": {
                        "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                        "level": 1,
                        "name": "일반"
                    }
                },
                "createdAt": "2020-05-07T08:42:46.554+09:00",
                "modifiedAt": "2020-05-07T08:42:46.554+09:00"
            }
           
        ]
        ```


### <code>POST</code>  /v2/comments/{id}/:commentType

대댓글등록

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 언급하려는 댓글id | true ||
    | `commentType` | reply(대댓글), adopt(채택), thanks(감사인사) | true ||
    
- Parameter(multipart/form)

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `text` | 내용, 사용자 언급 `@[{user-id}]` | true ||
    | `files` | 업로드 파일 | ||
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용, `@[{user-id}]` 를 사용자 닉네임으로 대체   |  |  |
       | `plainText`  | 내용 원본 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |
       | `mentioned`  | 언급된 사용자 정보 |  |  |
       
* success response
  
        ```
        [
            {
                "id": 111,
                "text": "111",
                "owner": {
                    "id": 1,
                    "nickname": "user1",
                    "levelInfo": {
                        "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                        "level": 1,
                        "name": "일반"
                    }
                },
                "createdAt": "2020-05-07T08:42:46.554+09:00",
                "modifiedAt": "2020-05-07T08:42:46.554+09:00",
                "mentioned": {
                    "nickname": "마트1(안산)"
                }
            }
           
        ]
        ```
   
     
    
    
### <code>PUT</code>  /v2/comments/{id}

댓글 수정

- Parameter(multipart/form)

```
    1. attachment 수정은 files, descriptions, ids 쌍을 가집니다. (모든 키를 포함해야함)
    2. ids 는 기존 업로드 데이터를 유지할때 사용하고, 기존 attachment.id 가 없을 경우 삭제합니다.
    3. 키 쌍을 기준으로 업로드 파일을 정렬합니다.  
```


- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 언급하려는 댓글id | true ||

- Parameter(multipart/form)

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `text` | 내용 | true ||
    | `ids` | attachment.id, 없으면 기존 이미지 삭제 |  ||
    | `files` | 업로드 파일 | ||


 * success response
   
        ```
        [
            {
                "id": 111,
                "text": "111",
                "owner": {
                    "id": 1,
                    "nickname": "user1",
                    "levelInfo": {
                        "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                        "level": 1,
                        "name": "일반"
                    }
                },
                "createdAt": "2020-05-07T08:42:46.554+09:00",
                "modifiedAt": "2020-05-07T08:42:46.554+09:00"
            }
           
        ]
        ```
     

### <code>DELETE</code>  /v2/comments/{id}

댓글 삭제

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 댓글id | true ||


 * success response
   
```
    {
        "id": 111,
        "text": "111",
        "owner": {
            "id": 1,
            "nickname": "user1",
            "levelInfo": {
                "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                "level": 1,
                "name": "일반"
            }
        },
        "createdAt": "2020-05-07T08:42:46.554+09:00",
        "modifiedAt": "2020-05-07T08:42:46.554+09:00"
    }

```

### <code>GET</code>  /v2/postings/{id}/comments/first

첫답변조회

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 게시글ID | ||

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | ID |  |  |
      | `text`  | 내용 |  |  |
      | `attachments`  | 첨부파일목록 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |
      | `isLike`  | 좋아요 여부 |  |  |

    * success response

         ```
         {
             "id": 111,
             "text": "111",
             "owner": {
                 "id": 1,
                 "nickname": "user1",
                 "levelInfo": {
                     "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                     "level": 1,
                     "name": "일반"
                 }
             },
             "createdAt": "2020-05-07T08:42:46.554+09:00",
             "modifiedAt": "2020-05-07T08:42:46.554+09:00",
             "isLike": false
         }
         ```



### <code>GET</code>  /v2/postings/{id}/comments/adopt

채택답변조회

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 게시글ID | ||

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | ID |  |  |
      | `text`  | 내용 |  |  |
      | `attachments`  | 첨부파일목록 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |
      | `isLike`  | 좋아요 여부 |  |  |

    * success response

         ```
         {
             "id": 111,
             "text": "111",
             "owner": {
                 "id": 1,
                 "nickname": "user1",
                 "levelInfo": {
                     "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                     "level": 1,
                     "name": "일반"
                 }
             },
             "createdAt": "2020-05-07T08:42:46.554+09:00",
             "modifiedAt": "2020-05-07T08:42:46.554+09:00",
             "isLike": false
         }
         ```



### <code>POST</code>  /v2/comments/{id}/report

댓글 신고하기
     
- Parameter
  
     | attribute| description | required | default |
     | --- | --- | -------- | --- |
     | `id` | 댓글 ID | ||
     | `title` | 신고항목 | ||
     | `text` | 내용 | ||

- Response (application/json)   
    * success response
        
```
true, false
```     

 
### <code>GET</code>  /v2/postings/{id}/similarContent

유사 게시글

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id` | 게시글ID | ||
    | `offset` |  | | `0` |
    | `count` |  | | `5`|
    | `orderby` | 정렬 (`id` or `popular` or`mostComments`) | | `id`  |
    | `sortby` | 정렬 (`desc` or `asc`) | | postingType 이 guide 일경우 `asc` 나머지는 `desc` |
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `posters`  | 가이드북 포스터 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |

   * success response
   
        ```
        [
            {
                "id": 28,
                "text": "boast",
                "readCount": 0,
                "commentCount": 19,
                "likeCount": 2,
                "attachments": [
                    {
                        "id": 32,
                        "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                        "description" : "", #optional
                        "dimension" : "1080,920"     
                    }
                ],
                "posters": [
                	{
                		"id": 32,
                		"photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                		"description" : "", #optional
                        "dimension" : "1080,920"     
                	}
                ],
                "owner": {
                    "id": 1,
                    "nickname": "user1",
                    "levelInfo": {
                        "badge": "/assets/img/badges/badge0.png",
                        "level": 1,
                        "name": "일반"
                    }
                },
                "postingType": "boast",
                "createdAt": "2020-04-23T15:09:53+09:00",
                "modifiedAt": "2020-04-24T15:50:11+09:00"
            }
        ]
        ```


## 프로필조회     

### <code>GET</code>  /v2/users/me
내 프로필 조회


- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | 사용자 ID |  |  |
       | `nickname`  | 내용 |  |  |
       | `photoUrl`  | 아바타 이미지 |  |  |
       | `levelInfo`  | 레벨정보 |  |  |
       | `activity.postingCount`  | 포스팅 갯수 |  |  |
       | `activity.commentCount`  | 답변 게시글 갯수 |  |  |
       | `activity.adoptedCount`  | 채택 갯수 |  |  |
       | `security.email`  | 이메일 |  |  |
       | `security.phoneNumber`  | 전화번호 |  |  |
       | `adoptedCount`  | 채택된글수 |  |  |
       | `badgeCount`  | 뱃지수 |  |  |
       | `representBadge`  | 대표 뱃지 |  |  |
       | `representBadge.id` | 대표 뱃지의 id | | |
       | `representBadge.title` | 대표 뱃지의 타이틀 | |
       | `representBadge.description1` | 대표 뱃지의 설명1 | |
       | `representBadge.description2` | 대표 뱃지의 설명2 | |    
       | `representBadge.imageUrl` | 대표 뱃지의 이미지 url | |

   * success response
   
```
    {
        "id": 1,
        "nickname": "user4",
        "levelInfo": {
            "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
            "level": 1,
            "name": "일반"
        },
        "activity": {
          "postingCount": 12,
          "commentCount": 3,
          "adoptedCount" : 1
        },
        "photoUrl": null,
        "security": {
            "email": null,
            "phoneNumber": null
        },
        "provider": "email",
        "adopedCount" : 1,
        "badgeCount" : 6,
        "representBadge" : {
            "id" : 2,
            "title" : "댓글 만사마",
            "description1" : "이름이 모야에서 만개의 댓글을 남기셨군요!",
            "description2" : "식물 전문가로 이름을 날리시기 시작했습니다!",
            "imageUrl" : 이미지 url
        }
    }
```

### <code>POST</code>  ~~/v2/users/me~~
~~내 프로필 업데이트~~ 업데이트 항목별  api 추가예정 

- Parameter(multipart/form)

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `nickname` | 닉네임 | ||
    | `avatar` | 이미지 파일 | ||
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | 사용자 ID |  |  |
       | `nickname`  | 내용 |  |  |
       | `photoUrl`  | 아바타 이미지 |  |  |
       | `levelInfo`  | 레벨정보 |  |  |

   * success response
   
```
    {
            "id": 1,
            "nickname": "user4",
            "levelInfo": {
                "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                "level": 1,
                "name": "일반"
            },
            "photoUrl": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/users/2020/05/11/3378eb45-69df-4f61-aea3-c64299bd78c5.png"
        }
```
  
     
### <code>GET</code>  /v2/users/me/likes

좋아요 목록 조회

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `postingType` | 타입 | | |
    | `sinceId` |  | | |
    | `maxId` |  | | |
    | `count` |  | | |
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `timelineId`  | 타임라인 조회시 이 필드를 사용(sinceId, maxId) |  |  |
       | `id`  | 리소스 조회용 ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |

   * success response
   
```
        [
            {
                "id": 28,
                "text": "boast",
                "readCount": 0,
                "commentCount": 19,
                "likeCount": 2,
                "attachments": [
                    {
                        "id": 32,
                        "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                        "description" : "", #optional
                        "dimension" : "1080,920"     
                    }
                ],
                "owner": {
                    "id": 1,
                    "nickname": "user1",
                    "levelInfo": {
                        "badge": "/assets/img/badges/badge0.png",
                        "level": 1,
                        "name": "일반"
                    }
                },
                "postingType": "boast",
                "createdAt": "2020-04-23T15:09:53+09:00",
                "modifiedAt": "2020-04-24T15:50:11+09:00"
            }
        ]
```


### <code>GET</code>  /v2/users/me/scraps

스크랩 목록 조회

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `postingType` | 타입 | | |
    | `sinceId` |  | | |
    | `maxId` |  | | |
    | `count` |  | | |
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `timelineId`  | 타임라인 조회시 이 필드를 사용(sinceId, maxId) |  |  |
       | `id`  | 리소스 조회용 ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |

   * success response
   
        ```
        [
            {
                "id": 28,
                "text": "boast",
                "readCount": 0,
                "commentCount": 19,
                "likeCount": 2,
                "attachments": [
                    {
                        "id": 32,
                        "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                        "description" : "" #optional,
                        "dimension" : "1080,920"     
                    }
                ],
                "owner": {
                    "id": 1,
                    "nickname": "user1",
                    "levelInfo": {
                        "badge": "/assets/img/badges/badge0.png",
                        "level": 1,
                        "name": "일반"
                    }
                },
                "postingType": "boast",
                "createdAt": "2020-04-23T15:09:53+09:00",
                "modifiedAt": "2020-04-24T15:50:11+09:00"
            }
        ]
        ```



### <code>GET</code>  /v2/users/me/postings

작성 게시글 목록 조회

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `sinceId` |  | | |
    | `maxId` |  | | |
    | `count` |  | | |
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | 리소스 조회용 ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |

   * success response
   
        ```
        [
            {
                "id": 28,
                "text": "boast",
                "readCount": 0,
                "commentCount": 19,
                "likeCount": 2,
                "attachments": [
                    {
                        "id": 32,
                        "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                        "description" : "", #optional
                        "dimension" : "1080,920"     
                    }
                ],
                "owner": {
                    "id": 1,
                    "nickname": "user1",
                    "levelInfo": {
                        "badge": "/assets/img/badges/badge0.png",
                        "level": 1,
                        "name": "일반"
                    }
                },
                "postingType": "boast",
                "createdAt": "2020-04-23T15:09:53+09:00",
                "modifiedAt": "2020-04-24T15:50:11+09:00"
            }
        ]
        ```



### <code>GET</code>  /v2/users/me/comments

작성 답변글 목록 조회

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `sinceId` |  | | |
    | `maxId` |  | | |
    | `count` |  | | |
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | 리소스 조회용 ID |  |  |
       | `text`  | 내용 |  |  |
       | `readCount`  | 읽음수 |  |  |
       | `commentCount`  | 답변수 |  |  |
       | `likeCount`  | 좋아요수 |  |  |
       | `attachments`  | 첨부파일목록 |  |  |
       | `owner`  | 글쓴이 |  |  |
       | `postingType`  | 게시글타입 |  |  |
       | `createdAt`  | 생성일시 |  |  |
       | `modifiedAt`  | 수정일시 |  |  |

   * success response
   
        ```
        [
            {
                "id": 28,
                "text": "boast",
                "readCount": 0,
                "commentCount": 19,
                "likeCount": 2,
                "attachments": [
                    {
                        "id": 32,
                        "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                        "description" : "", #optional
                        "dimension" : "1080,920"     
                    }
                ],
                "owner": {
                    "id": 1,
                    "nickname": "user1",
                    "levelInfo": {
                        "badge": "/assets/img/badges/badge0.png",
                        "level": 1,
                        "name": "일반"
                    }
                },
                "postingType": "boast",
                "createdAt": "2020-04-23T15:09:53+09:00",
                "modifiedAt": "2020-04-24T15:50:11+09:00"
            }
        ]
        ```

### <code>GET</code>  /v2/users/me/adopts

채택된글목록

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `sinceId` |  | | |
  | `maxId` |  | | |
  | `count` |  | | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `timelineId`  | 타임라인 조회시 이 필드를 사용(sinceId, maxId) |  |  |
      | `id`  | 리소스 조회용 ID |  |  |
      | `text`  | 내용 |  |  |
      | `readCount`  | 읽음수 |  |  |
      | `commentCount`  | 답변수 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments`  | 첨부파일목록 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |

    * success response

         ```
         [
             {
                 "id": 28,
                 "text": "boast",
                 "readCount": 0,
                 "commentCount": 19,
                 "likeCount": 2,
                 "attachments": [
                     {
                         "id": 32,
                         "photoUrl": "posting/2020/04/23/b36606a5-9cba-4820-940f-c662b3cecdb8.png"
                         "description" : "" #optional,
                         "dimension" : "1080,920"     
                     }
                 ],
                 "owner": {
                     "id": 1,
                     "nickname": "user1",
                     "levelInfo": {
                         "badge": "/assets/img/badges/badge0.png",
                         "level": 1,
                         "name": "일반"
                     }
                 },
                 "postingType": "boast",
                 "createdAt": "2020-04-23T15:09:53+09:00",
                 "modifiedAt": "2020-04-24T15:50:11+09:00"
             }
         ]
         ```



### <code>GET</code> /v2/search/users

사용자 검색 (페이징 처리 없이 20개 제한)

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `q` | 검색어 | ||
    
- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `id`  | ID |  |  |
       | `nickname`  | 닉네임 |  |  |
       | `photoUrl`  | 썸네일 |  |  |
       | `level`  | 레벨 |  |  |
       | `role`  |  |  |  |
       | `status`  |  |  |  |
       | `levelInfo`  | 레벨정보 |  |  |
       

   * success response
   
        ```
         {
             "resultCode": 1000,
             "resultData": [
                 {
                     "id": 1,
                     "nickname": "모야모",
                     "photoUrl": null,
                     "level": 6,
                     "role": "expert",
                     "status": "normal",
                     "levelInfo": {
                         "badge": "http://d1ujq2dpv14gay.cloudfront.net/commons/badges/badge5.png",
                         "level": 6,
                         "name": "신"
                     }
                 },
                 {
                     "id": 54242,
                     "nickname": "모야모야모",
                     "photoUrl": null,
                     "level": 1,
                     "role": null,
                     "status": "normal",
                     "levelInfo": {
                         "badge": "http://d1ujq2dpv14gay.cloudfront.net/commons/badges/badge0.png",
                         "level": 1,
                         "name": "일반"
                     }
                 }
         ]
        ```




## 알림

### <code>GET</code>  /v2/notifications

알림목록조회

- Parameter

     | attribute| description | required | default |
     | --- | --- | -------- | --- |
     | `sinceId`  |  |  |  |
     | `maxId`  |  |  |  |
     | `count`  |  |  |  |
     
- Response (application/json)

    * EventType
    
        ```
            NEW_QUESTION
            NEW_BOAST,
            NEW_CLINIC,
            NEW_GUIDE,
            NEW_MAGAZINE,
            NEW_COMMENT,
            NEW_LIKE_POSTING,
            NEW_LIKE_COMMENT,
            NEW_AD
        ```


  
* success response

    * 필드
   
    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `id`  | timeline ID |  |  |
    | `title`  | 제목  |  |  |
    | `description`  | 설명  |  |  |
    | `eventType`  | 타입  |  |  |
    | `photoUrl`  | 이미지 |  |  |
    | `owner`  | 상대유저 |  |  |
    | `resource.resourceId`  | 리소스ID |  |  |
    | `resource.resourceType`  | 리소스타입 |  |  |
    | `resource.referenceId`  | 알림클릭시 이동할 디테일ID |  |  |
    | `resource.referenceType`  | 알림클릭시 이동할 페이지타입|  |  |
    | `unread`  | 안읽음여부 |  |  |
  
```
         [
                {
                    "id": 112,
                    "title": "모야모1님이 새 댓글을 남겼습니다.",
                    "description": "111",
                    "eventType": "NEW_COMMENT",
                    "photoUrl": "posting/2020/05/11/2da7555a-4e16-457a-a451-3eb0cc7b9f44.png?d=50x50",
                    "resource": {
                        "resourceId": "135",
                        "resourceType": "comment",
                        "referenceId": "93",
                        "referenceType": "question"
                    },
                    "owner": {
                         "id": 2,
                         "nickname": "모야모1",
                         "role": "expert",
                         "levelInfo": {
                             "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                             "level": 1,
                             "name": "일반"
                         },
                         "photoUrl": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/users/2020/05/11/aeba4282-7f6b-486b-80ee-6f3cc7ffa135.png"
                    },
                    "unread": true
                },
                {
                    "id": 109,
                    "title": "마트1(안산)님이 새 댓글을 남겼습니다.",
                    "description": "111",
                    "eventType": "NEW_COMMENT",
                    "photoUrl": "posting/2020/04/22/0d80d769-b218-4c8c-80d2-df7bd555e2c1.png?d=50x50",
                    "resource": {
                        "resourceId": "133",
                        "resourceType": "comment",
                        "referenceId": "2",
                        "referenceType": "question"
                    },
                     "owner": {
                         "id": 2,
                         "nickname": "모야모1",
                         "role": "expert",
                         "levelInfo": {
                             "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                             "level": 1,
                             "name": "일반"
                         },
                         "photoUrl": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/users/2020/05/11/aeba4282-7f6b-486b-80ee-6f3cc7ffa135.png"
                     },
                     "unread": true
                },
                {
                    "id": 108,
                    "title": "모야모1님이 새 댓글을 남겼습니다.",
                    "description": "111",
                    "eventType": "NEW_COMMENT",
                    "photoUrl": "posting/2020/04/22/0d80d769-b218-4c8c-80d2-df7bd555e2c1.png?d=50x50",
                    "resource": {
                        "resourceId": "132",
                        "resourceType": "comment",
                        "referenceId": "2",
                        "referenceType": "question"
                    },
                    "owner": {
                         "id": 2,
                         "nickname": "모야모1",
                         "role": "expert",
                         "levelInfo": {
                             "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge0.png",
                             "level": 1,
                             "name": "일반"
                         },
                         "photoUrl": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/users/2020/05/11/aeba4282-7f6b-486b-80ee-6f3cc7ffa135.png"
                    },
                    "unread": true
                } 
        ]
```


### <code>POST</code>  /v2/notifications/markRead

알림전체읽음 처리

- Parameter

- Response (application/json)



### <code>POST</code>  /v2/notifications/{id}/markRead

알림 읽음 처리

- Response (application/json)



### <code>GET</code> /v2/notifications/setting

내알림설정조회

- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `notiEnable` | 전체 알림 여부 boolean  | | |
       | `adNotiEnable` | 광고 알림 여부 boolean | | |
       | `postingNotiEnable` | 추천 게시물 알림 여부 boolean | | |
       | `commentNotiEnable` | 답글 알림 여부 boolean | | |
       | `replyNotiEnable` | 대댓글 알림 여부 boolean | | |
       | `likeNotiEnable` | 좋아 알림 여부 boolean | | |
       | `shopNotiEnable` | 결제, 배송정보 알림 여부 boolean | | |
       | `mentionNotiEnable` | 댓글 언급 알림 여부 boolean | | |
       | `adNotiAgreement` | 광고, 마케팅 동의 여부 boolean(true, false, null), null 일 경우 팝업 알림 | | |
       | `adNotiConfirmedAt` | 광고, 마케팅 알림 설정 날짜 | | |
       | `joinCommentNotiEnable` | 참여한 게시글의 댓글 모두 받기 | | |
       | `badgeNotiEnable` | 뱃지 알림 여부 boolean | | |
       | `adoptNotiEnable` | 채택 알림 여부 boolean | | |
       
    

### <code>POST</code> /v2/notifications/setting

내알림설정수정

- Parameter(application/json)

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `notiEnable` |  전체 알림 여부 boolean  | | |
    | `adNotiEnable` | 광고 알림 여부 boolean | | |
    | `postingNotiEnable` | 추천 게시물 알림 여부 boolean | | |
    | `commentNotiEnable` | 답글 알림 여부 boolean | | |
    | `replyNotiEnable` | 대댓글 알림 여부 boolean | | |
    | `likeNotiEnable` | 좋아 알림 여부 boolean | | |
    | `shopNotiEnable` | 결제, 배송정보 알림 여부 boolean | | |
    | `mentionNotiEnable` | 댓글 언급 알림 여부 boolean | | |
    | `adNotiAgreement` | 광고, 마케팅 동의 여부 boolean | | |
    | `joinCommentNotiEnable` | 참여한 게시글의 댓글 모두 받기 | | |
   

- Response (application/json)

   * 필드
   
       | attribute| description | required | default |
       | --- | --- | -------- | --- |
       | `notiEnable` | 전체 알림 여부 boolean | | |
       | `adNotiEnable` | 광고 알림 여부 boolean | | |
       | `postingNotiEnable` | 추천 게시물 알림 여부 boolean | | |
       | `commentNotiEnable` | 답글 알림 여부 boolean | | |
       | `replyNotiEnable` | 대댓글 알림 여부 boolean | | |
       | `likeNotiEnable` | 좋아 알림 여부 boolean | | |
       | `shopNotiEnable` | 결제, 배송정보 알림 여부 boolean | | |
       | `mentionNotiEnable` | 댓글 언급 알림 여부 boolean | | |
       | `adNotiAgreement` | 광고, 마케팅 동의 여부 boolean(true, false, null), null 일 경우 팝업 알림 | | |
       | `adNotiConfirmedAt` | 광고, 마케팅 알림 설정 날짜 | | |


## 뱃지

### <code>GET</code>  /v2/users/me/badges

획득 뱃지 조회

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `allBadges` | 모든 뱃지 | |
      | `allBadges.id` | 뱃지 ID | |
      | `allBadges.title` | 뱃지의 타이틀 | |
      | `allBadges.description1` | 대표 뱃지의 설명1 | |
      | `allBadges.description2` | 대표 뱃지의 설명2 | |
      | `allBadges.representable` | 대표 뱃지로 설정 가능성 여부 boolean | |
      | `allBadges.currentRepresent` | 현재 대표 뱃지 확인 여부 boolean  | |
      | `allBadges.imageUrl` | 뱃지의 이미지 url | |

* success response
```
    [
        {
            "allBadges" : [
                {
                    "id": 2,
                    "title" : "댓글 만사마",
                    "description1" : "이름이 모야에서 만개의 댓글을 남기셨군요!",
                    "description2" : "식물 전문가로 이름을 날리시기 시작했습니다!",
                    "representable" : true,
                    "currentRepresent": true,
                    "imageUrl" : 이미지 url
                },
                {
                    "id": 3,
                    "title" : "댓글 십만사마",
                    "description1" : "이름이 모야에서 십만개의 댓글을 남기셨군요!",
                    "description2" : "당신은 손꼽히는 식물전문가!",
                    "representable" : false,
                    "currentRepresent": false,
                    "imageUrl" : 이미지 url
                }
            ]
        }
    ]
```


### <code>POST</code>  /v2/users/me/badges/{id}/representBadge

내 대표 뱃지 수정

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 뱃지 ID | | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `allBadges` | 모든 뱃지 | |
      | `allBadges.id` | 뱃지 ID | |
      | `allBadges.title` | 뱃지의 타이틀 | |
      | `allBadges.description1` | 대표 뱃지의 설명1 | |
      | `allBadges.description2` | 대표 뱃지의 설명2 | |
      | `allBadges.representable` | 대표 뱃지로 설정 가능성 여부 boolean | |
      | `allBadges.currentRepresent` | 현재 대표 뱃지 확인 여부 boolean  | |
      | `allBadges.imageUrl` | 뱃지의 이미지 url | |
    
* success response
```
    [
        {
            "allBadges" : [
                {
                    "id": 2,
                    "title" : "댓글 만사마",
                    "description1" : "이름이 모야에서 만개의 댓글을 남기셨군요!",
                    "description2" : "식물 전문가로 이름을 날리시기 시작했습니다!",
                    "representable" : true,
                    "currentRepresent": true,
                    "imageUrl" : 이미지 url
                },
                {
                    "id": 3,
                    "title" : "댓글 십만사마",
                    "description1" : "이름이 모야에서 십만개의 댓글을 남기셨군요!",
                    "description2" : "당신은 손꼽히는 식물전문가!",
                    "representable" : false,
                    "currentRepresent": false,
                    "imageUrl" : 이미지 url
                }
            ]
        }
    ]
```

### <code>GET</code>  /v2/users/{id}/badges

다른 사용자의 뱃지 조회

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 사용자 ID | | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `allBadges` | 모든 뱃지 | |
      | `allBadges.id` | 뱃지 ID | |
      | `allBadges.title` | 뱃지의 타이틀 | |
      | `allBadges.description1` | 대표 뱃지의 설명1 | |
      | `allBadges.description2` | 대표 뱃지의 설명2 | |
      | `allBadges.representable` | 대표 뱃지로 설정 가능성 여부 boolean | |
      | `allBadges.currentRepresent` | 현재 대표 뱃지 확인 여부 boolean  | |
      | `allBadges.imageUrl` | 뱃지의 이미지 url | |

* success response
```
    [
        {
            "allBadges" : [
                {
                    "id": 2,
                    "title" : "댓글 만사마",
                    "description1" : "이름이 모야에서 만개의 댓글을 남기셨군요!",
                    "description2" : "식물 전문가로 이름을 날리시기 시작했습니다!",
                    "representable" : true,
                    "currentRepresent": true,
                    "imageUrl" : 이미지 url
                },
                {
                    "id": 3,
                    "title" : "댓글 십만사마",
                    "description1" : "이름이 모야에서 십만개의 댓글을 남기셨군요!",
                    "description2" : "당신은 손꼽히는 식물전문가!",
                    "representable" : false,
                    "currentRepresent": false,
                    "imageUrl" : 이미지 url
                }
            ]
        }
    ]
```


## 검색어

### <code>GET</code>  /v2/tags/recommended

추천검색어

- Parameter

     | attribute| description | required | default |
     | --- | --- | -------- | --- |
     | ~~`postingType`~~  |  |  |  |
     | `type`  | question,boast,magazine,clinic,free,guidebook,shop,dictionary |  |  |
     
- Response (application/json)
  
    ```
    
        [
            "검색어1",
            "검색어2"
        ]
        
    ```


### <code>GET</code>  /v2/tags/autocomplete

자동완성

- Parameter

     | attribute| description | required | default |
     | --- | --- | -------- | --- |
     | `postingType`  |  |  |  |
     | `q`  | 검색어 |  |  |
     
- Response (application/json)
  
    ```
    
        [
            "검색어1",
            "검색어2"
        ]
        
    ```
    
## 도감

### <code>GET</code>  /v2/dictionaries/{name}

도감 조회

- Parameter
  
- Response (application/json)
  
    ``` 
        {도감URL}
    ```


### <code>GET</code>  /v2/dictionaries/{name}/share

도감 조회

- Parameter
  
- Response (application/json)
 * success response
        ```
        {
                "id": "e997176e-c924-40c3-b992-e54e2e5fccca",
                "resource": {
                    "resourceId": "장미",
                    "resourceType": "dictionary",
                    "referenceId": "장미",
                    "referenceType": "dictionary"
                },
                "deeplink": "https://devmoyamo.page.link/AfYUEt4cgHGuLUE26"
            }
        ```

  




## 쇼핑몰

### <code>GET</code>  /v2/shops/goods

상품 목록 검색 

- Parameter

     | attribute| description | required | default |
     | --- | --- | -------- | --- |
     | `offset`  |  |  | 0 |
     | `count`  |  |  | 10 |
     | `q`  | 검색어 |  |  |
     | `orderby`  | 정렬 `id` or `popular` |  | `id` |
  
- Response (application/json)
  
    * 필드
    
    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `goodsNo`  | 상품 ID |  |  |
    | `name`  | 상품이름 |  |  |
    | `photoUrl`  | 상품 이미지  |  |  |
    | `price`  | 정가  |  |  |
    | `discountedPrice`  | 할인가격  |  |  |
    | `reviewCnt`  | 리뷰수  |  |  |
  
    ``` 
        [
               {
                   "goodsNo": "1000000069",
                   "name": "[채소씨앗] 아마란스 100립",
                   "price": 1000.00,
                   "photoUrl": "http://moyamo.godomall.com/dataDto/goods//17/01/20/1000000069/1000000069Main.jpg",
                   "discountedPrice": 1000.00,
                   "reviewCnt" : 10
               },
               {
                   "goodsNo": "1000004454",
                   "name": "[채소씨앗] 프렌치래디쉬 100립",
                   "price": 1500.00,
                   "photoUrl": "http://moyamo.godomall.com/dataDto/goods/18/02/07/1000004454/1000004454_main_042.jpg",
                   "discountedPrice": 1500.00,
                    "reviewCnt" : 10
               }
        ]
    
    ```

### <code>GET</code>  /v2/shops/goods/count

검색결과 갯수 조회 

- Parameter

     | attribute| description | required | default |
     | --- | --- | -------- | --- |
     | `offset`  |  |  | 0 |
     | `count`  |  |  | 10 |
     | `q`  | 검색어 |  |  |


- Response (application/json)
  
   * success response
   
        ```
        {갯수}
        ```

  

### <code>GET</code>  /v2/shops/goods/recommended

추천 상품 목록 검색 

- Parameter

     | attribute| description | required | default |
     | --- | --- | -------- | --- |
     | `offset`  |  |  | 0 |
     | `count`  |  |  | 10 |
     | `q`  | 검색어 |  |  |
     | `orderby`  | 정렬 `id` or `popular` |  | `id` |
  
- Response (application/json)
  
    * 필드
    
    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `goodsNo`  | 상품 ID |  |  |
    | `name`  | 상품이름 |  |  |
    | `photoUrl`  | 상품 이미지  |  |  |
    | `price`  | 정가  |  |  |
    | `discountedPrice`  | 할인가격  |  |  |
  
    ``` 
        [
               {
                   "goodsNo": "1000000069",
                   "name": "[채소씨앗] 아마란스 100립",
                   "price": 1000.00,
                   "photoUrl": "http://moyamo.godomall.com/dataDto/goods//17/01/20/1000000069/1000000069Main.jpg",
                   "discountedPrice": 1000.00
               },
               {
                   "goodsNo": "1000004454",
                   "name": "[채소씨앗] 프렌치래디쉬 100립",
                   "price": 1500.00,
                   "photoUrl": "http://moyamo.godomall.com/dataDto/goods/18/02/07/1000004454/1000004454_main_042.jpg",
                   "discountedPrice": 1500.00
               }
        ]
    
    ```

### <code>GET</code>  /v2/shops/goods/recommended/count

검색결과 갯수 조회 

- Parameter

     | attribute| description | required | default |
     | --- | --- | -------- | --- |
     | `offset`  |  |  | 0 |
     | `count`  |  |  | 10 |
     | `q`  | 검색어 |  |  |


- Response (application/json)
  
   * success response
   
        ```
        {갯수}
        ```
   

### <code>GET</code>  /v2/shops/deposit 

 예치금 조회 

 - Parameter

 - Response (application/json)

    * 필드
    
        | attribute| description | required | default |
        | --- | --- | -------- | --- |
        | `deposit`  | 잔액 (bigdecimal) |  |  |

     ```
        {
            "deposit" : 1000 
        }        
     ```

### <code>GET</code>  /v2/shops/mileage 

 마일리지 조회 

 - Parameter

 - Response (application/json)

    * 필드
    
        | attribute| description | required | default |
        | --- | --- | -------- | --- |
        | `mileage`  | 잔액 (bigdecimal) |  |  |

     ```
        {
            "mileage" : 1000 
        }        
     ```



### <code>GET</code>  /v2/shops/wallet 

 마일리지, 예치금  조회 

 - Parameter

 - Response (application/json)

    * 필드
    
        | attribute| description | required | default |
        | --- | --- | -------- | --- |
        | `mileage`  | 잔액 (bigdecimal) |  |  |
        | `deposit`  | 잔액 (bigdecimal) |  |  |

     ```
        {
            "mileage" : 1000,
            "deposit" : 1000 
        }        
     ```



### <code>GET</code>  /v2/shops/page/{name} 

샵 페이지 주소 조회 

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `name`  |    |  | `home` |


- Name

    | attribute| description |
    | --- | --- |
    | `home`  |  홈  |
    | `cart`  |  장바구니  |
    | `coupon`  |  쿠폰  |
    | `wish`  |  찜한 상품  |
    | `review`  |  내가 쓴 후기  |
    | `cancel`  |  취소/반품/교환  |
    | `order`  |  주문 목록  |
    | `deposit`  |  예치금  |
    | `qa`  |  나의 문의 내역  |
    | `recommended`  | 추천상품 |
    | `mileage`  | 마일리지 |
    | `refund`  | 환불/입금처리 |
    | `shipping`  | 배송지관리 |
    

  

- Response (application/json)

    ```
        {접속주소}
    ```

### <code>GET</code>  /v2/shops/page/goods/{id} 

 상품디테일 이동 

 - Parameter

 - Response (application/json)

     ```
         {접속주소}
     ```



### <code>GET</code>  /v2/shops/goods/test 

FCM 알림방송 테스트 api (결제완료, 배송중, 배송완료)

 - Parameter

 - Response (application/json)

 

## 공지사항 


### <code>GET</code>  /v2/notices 

공지사항 목록 조회 

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    

- Response (application/json)

    * 필드
    
        | attribute| description | required | default |
        | --- | --- | -------- | --- |
        | `title`  | 제목 |  |  |
        | `description`  | 설명 |  |  |
        | `interval`  | 노출 반복 일수(0: 한번만 노출, 1: 1일에 한번, 7: 1주일에 한번) |  |  |
        | `popup`  | 팝업 여부 |  |  |
        | `url`  | 링크 주소 |  |  |

    ```  
         [
            {
              "id": 1,
              "title": "공지",
              "description": "공지내용",
              "interval": 0,
              "status": "open",
              "popup": true,
              "url": ""
            }
        ]
    
    ```



### <code>GET</code> /v2/notices/apps/release 

앱 릴리즈 버전 조회 

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `osType`  |    |  | `android`, `ios` |
    | `version`  |    |  | 클라이언트 현재 버전 |


- Response (application/json)

    * 필드
        | attribute| description | required | default |
        | --- | --- | -------- | --- |
        | `version`  | 버전 |  |  |
        | `forceUpdate`  | 필수 업데이트 여부 |  |  |
        | `needUpdate`  | 업데이트 여부를  서버에서 확인 |  |  |

    ```
         # 없으면 null
    
         {
            "version": "5.1.10",
            "forceUpdate": true,
            "needUpdate": true
         }
    
    ```



## 배너 조회 


### <code>GET</code>  /v2/banners 

배너 목록 조회 

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    


- Response (application/json)

    * 필드
    
        | attribute| description | required | default |
        | --- | --- | -------- | --- |
        | `title`  |  |  |  |
        | `resource`  |  |  |  |
        | `배너 이미지`  |  |  |  |

    ```
         # 없으면 null
    
         [
            {
                "title": "title",
                "resource": {
                  "resourceId": "139",
                  "resourceType": "boast",
                  "referenceId": "139",
                  "referenceType": "boast"
                },
                "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/banners/banner2.jpg`
            }
        ]
  
    
    ```


## 정책

### <code>GET</code>  /v2/policies/page/:name

앱 릴리즈 버전 조회 

- Parameter

    | attribute| description | required | default |
    | --- | --- | -------- | --- |
    | `name`  |  `location` : 위치 <br> `terms` : 이용약관<br> `privacy` : 개인정보 취급방침 <br> `notice` : 공지사항 | `notice`  |  |


- Response (application/json)

     ```
         {접속주소}
     ```






## 로그

### <code>GET</code> /v2/logs

클라이언트 로그 업로드(json) 

- Parameter(application/json)

    | attribute| description | required | default |
    | --- | --- | -------- | --- |


- Response (application/json)

     ```
         null
     ```

## 리소스

### <code>GET</code>  /v2/shops/page/redirect

shop 리소스로 이동주소 조회
(알림목록, PUSH 알림의 `resource` 의 속성 `resourceType` 이 `shop` 일 경우 `resourceId` 로 이동할 페이지 주소 조회)

[FCM 알림방송 테스트 api](#<code>GET</code>  /v2/shops/goods/test) 로 알림 테스트 가능

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `resourceId`  |  알림목록, PUSH 알림의 resource.resourceId   |  | |

- Response (application/json)

    ```
        {접속주소}
    ```


### <code>GET</code> /v2/page/redirect

공통 리소스로 이동주소 조회

** 주의 referenceId, referenceType 으로 동작함

(공지팝업, 알림목록, PUSH 알림의 `resource` 의 속성 `referenceType`, `referenceId` 로 이동할 페이지 주소 조회)

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `resourceId`  |  알림목록, PUSH 알림의 resource.resourceId (* web 주소일수 있으므로 url encoding 필요)  |  | |
  | `resourceType`  |  referenceType |  | |

- Response (application/json)

    ```
        {접속주소}
    ```

## 이벤트

### <code>GET</code>  /v2/events

이벤트 팝업 조회

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |


- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `title`  | 제목 |  |  |
      | `description`  | 설명 |  |  |
      | `interval`  | 노출 반복 일수(0: 한번만 노출, 1: 1일에 한번, 7: 1주일에 한번) |  |  |
      | `popup`  | 팝업 여부 |  |  |
      | `url`  | 링크 주소 |  |  |

    ```
        
  
         [
            {
              "id": 1,
              "title": "공지",
              "description": "공지내용",
              "interval": 0,
              "status": "open",
              "popup": true,
              "url" : "" # 없으면 이동안함
            }
        ]
    
    ```


## 랭킹

### <code>GET</code>  /v2/rankings

랭킹조회

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |


- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `date`  | 분석기준일 |  |  |
      | `keyword.polularity`  | 인기검색어 |  |  |
      | `keyword.polularity.rank`  | 순위 |  |  |
      | `keyword.polularity.keyword`  | 검색어 |  |  |
      | `keyword.polularity.fluctuation`  | +(순위오름), -(순위내림), 0(순위같음), null(신규)     |  |  |
      | `user.question`  | 질문 사용자순위 |  |  |
      | `user.question.rank`  | 순위 |  |  |
      | `user.question.id`  | 사용자id |  |  |
      | `user.question.keyword`  | 닉네임 |  |  |
      | `user.question.thunbnail`  | 이미지 |  |  |
      | `user.question.fluctuation`  | +(순위오름), -(순위내림), 0(순위같음), null(신규)     |  |  |
      | `user.clinic`  | 클리닉 사용자순위 |  |  |
      | `user.clinic.rank`  | 순위 |  |  |
      | `user.clinic.id`  | 사용자id |  |  |
      | `user.clinic.keyword`  | 닉네임 |  |  |
      | `user.clinic.thunbnail`  | 이미지 |  |  |
      | `user.clinic.fluctuation`  | +(순위오름), -(순위내림), 0(순위같음), null(신규)     |  |  |
      | `posting`  | 인기게시글(자유수다, 자랑하기) 사용자순위 |  |  |
      | `posting.rank`  | 순위 |  |  |
      | `posting.id`  | 게시글id |  |  |
      | `posting.postingType`  | 게시글타입 |  |  |
      | `posting.readCount`  | 읽음수 |  |  |
      | `posting.commentCount`  | 댓글수 |  |  |
      | `posting.thunbnail`  | 이미지 |  |  |
      | `posting.likeCount`  | 좋아요수 |  |  |
      | `posting.fluctuation`  | +(순위오름), -(순위내림), 0(순위같음), null(신규)     |  |  |
      | `goods`  |  인기상품 순위  |  |  |
      | `goods.rank`  | 순위 |  |  |
      | `goods.id`  | 사용자id |  |  |
      | `goods.keyword`  | 닉네임 |  |  |
      | `goods.fluctuation`  | +(순위오름), -(순위내림), 0(순위같음), null(신규)     |  |  |
      | `goods.price`  | 가격(원) |  |  |
      | `popup`  | 팝업 여부 |  |  |
      | `url`  | 링크 주소 |  |  |

    ```
    {
        "date": "03.18~03.24",
        "keyword": {
            "popularity": [
                {
                    "thumbnail": null,
                    "rank": 1,
                    "keyword": "#댓글",
                    "fluctuation": 1
                },
                {
                    "thumbnail": null,
                    "rank": 2,
                    "keyword": "#수저",
                    "fluctuation": 9
                },
                {
                    "thumbnail": null,
                    "rank": 3,
                    "keyword": "#몰라요",
                    "fluctuation": 13
                },
                {
                    "thumbnail": null,
                    "rank": 4,
                    "keyword": "#검사",
                    "fluctuation": 8
                },
                {
                    "thumbnail": null,
                    "rank": 5,
                    "keyword": "#감사",
                    "fluctuation": 12
                },
                {
                    "thumbnail": null,
                    "rank": 6,
                    "keyword": "#abc",
                    "fluctuation": 3
                }
            ]
        },
        "user": {
            "question": [
                {
                    "id": "1235910",
                    "thumbnail": null,
                    "rank": 1,
                    "keyword": "빠아악2",
                    "fluctuation": 6
                },
                {
                    "id": "1235614",
                    "thumbnail": null,
                    "rank": 2,
                    "keyword": "까망까망이",
                    "fluctuation": -1
                },
                {
                    "id": "1235591",
                    "thumbnail": "http://d1ujq2dpv14gay.cloudfront.net/dev/users/2020/09/18/b7f62f04-d39d-43d3-8814-5af0fa379f1c.jpg?d=100x100",
                    "rank": 3,
                    "keyword": "초딩카카오오오오오오오오",
                    "fluctuation": 0
                },
                {
                    "id": "284751",
                    "thumbnail": null,
                    "rank": 4,
                    "keyword": "빠아악",
                    "fluctuation": 0
                }
            ],
            "clinic": [
                {
                    "id": "1235906",
                    "thumbnail": null,
                    "rank": 1,
                    "keyword": "hjnaver",
                    "fluctuation": 4
                },
                {
                    "id": "1235915",
                    "thumbnail": "http://d1ujq2dpv14gay.cloudfront.net/dev/users/2021/03/23/ff595dc1-7f3a-423d-94f0-9748ef958911.jpg?d=100x100",
                    "rank": 2,
                    "keyword": "형진얼굴",
                    "fluctuation": 5
                },
                {
                    "id": "1235869",
                    "thumbnail": null,
                    "rank": 3,
                    "keyword": "ddcv",
                    "fluctuation": null
                },
                {
                    "id": "1235614",
                    "thumbnail": null,
                    "rank": 4,
                    "keyword": "까망까망이",
                    "fluctuation": 0
                },
                {
                    "id": "1235613",
                    "thumbnail": "http://d1ujq2dpv14gay.cloudfront.net/dev/users/2021/03/15/b4ca7c4f-2a91-4735-ae6f-c5536876f6ac.jpg?d=100x100",
                    "rank": 5,
                    "keyword": "에반류",
                    "fluctuation": -4
                },
                {
                    "id": "284751",
                    "thumbnail": null,
                    "rank": 6,
                    "keyword": "빠아악",
                    "fluctuation": 2
                }
            ]
        },
        "posting": [
            {
                "id": "2002082",
                "text": "12346😚🎊🐥😛🐗",
                "postingType": "free",
                "readCount": 38,
                "commentCount": 17,
                "likeCount": 0,
                "thumbnail": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/03/15/d07668ea-a109-4c7f-9921-959cce28bc98.jpg?d=100x100",
                "rank": 1,
                "fluctuation": null
            },
            {
                "id": "2002082",
                "text": "12346😚🎊🐥😛🐗",
                "postingType": "free",
                "readCount": 38,
                "commentCount": 17,
                "likeCount": 0,
                "thumbnail": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/03/15/d07668ea-a109-4c7f-9921-959cce28bc98.jpg?d=100x100",
                "rank": 2,
                "fluctuation": null
            }
        ],
        "goods": [
            {
                "id": "1000010023",
                "thumbnail": "http://d1ujq2dpv14gay.cloudfront.net/dev/goods/21/03/11/1000010023/1000000235_main_030.png?d=100x100",
                "rank": 1,
                "keyword": "[꽃모종] 다이아시아_핑크퀸 10cm 화분",
                "fluctuation": null,
                "price": 3500.00
            },
            {
                "id": "1000010021",
                "thumbnail": "http://d1ujq2dpv14gay.cloudfront.net/dev/goods/21/03/11/1000010021/1000010021_main_030.jpg?d=100x100",
                "rank": 2,
                "keyword": "[꽃씨] 백일홍_엘레강스 살몬로즈 20립",
                "fluctuation": null,
                "price": 1500.00
            }
        ]
    }
    ```

### <code>GET</code>  /v2/rankings/order

랭킹정렬조회

Array 순서에 따라 랭킹 순서 변경 

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |


- Response (application/json)
  
    ```
    [
        "user",
        "keyword",
        "posting",
        "goods"
    ]
    ```



## FCM
```
알림목록과 동일하게 referenceId, referenceType 으로 컨텐츠 파악해 디테일로 이동

referenceType
    - 게시글
        * question
        * boast
        * clinic
        * free
        * magazine
        * guidebook
        
    - 모야모샵
        * shop
            https://.../v2/shops/orderDto referenceId 의 주소로 api 호출하고 결과의 주소로 접속 

```


### 댓글

```
{
  "to": "c4HcqwioXet5YRmQO8Db3m:APA91bE0w1QqmnttkSJqt3HAiZF6lMJ96kIMm6E59W46BCVlzeFtrXkNhZP2JOWb-vR9gehswBv2aQDgEzvaHB-49X64GcWJ2NqdBlmiJXTTSuoTuhLVGc1lg3F_q1SecD2aYG9AfuNy",
  "notification": {
    "title": "모야모님이 새 댓글을 남겼습니다.",
    "body": "111124",
    "badge": 1,
    "click_action": ".MainActivity"
  },
  "dataDto": {
    "value": {
      "id": 252,
      "title": "모야모님이 새 댓글을 남겼습니다.",
      "description": "111124",
      "eventType": "NEW_COMMENT",
      "photoUrl": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/attachments/2014/10/31/2a2a4170-5aa5-495b-b72e-cd37c3bdcaa6.jpg?d=50x50",
      "owner": {
        "id": 1,
        "nickname": "모야모",
        "role": "expert",
        "levelInfo": {
          "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge5.png",
          "level": 6,
          "name": "신"
        },
        "photoUrl": null
      },
      "unread": true,
      "resource": {
        "resourceId": "7886505",
        "resourceType": "comment",
        "referenceId": "117",
        "referenceType": "question"
      }
    },
    "imageUrlPath": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/attachments/2014/10/31/2a2a4170-5aa5-495b-b72e-cd37c3bdcaa6.jpg?d=50x50",
    "targetBadge": 1
  }
}
```

### 배송정보
```
{
  "to": "1",
  "notification": {
    "title": "모야모샵",
    "body": null,
    "badge": 3,
    "click_action": ".MainActivity"
  },
  "dataDto": {
    "value": {
      "id": 251,
      "title": "모야모샵",
      "description": null,
      "eventType": "NEW_SHOP",
      "photoUrl": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/http://m.moyamo.godomall.com/dataDto/goods/20/05/18/1000007880/1000007880_main_092.jpg?d=50x50",
      "owner": {
        "id": 1,
        "nickname": "모야모",
        "role": "expert",
        "levelInfo": {
          "badge": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/badges/badge5.png",
          "level": 6,
          "name": "신"
        },
        "photoUrl": null
      },
      "unread": true,
      "resource": {
        "resourceId": "/v2/shops/orders",
        "resourceType": "shop",
        "referenceId": "/v2/shops/orders",
        "referenceType": "shop"
      }
    },
    "imageUrlPath": "https://moyamo-test.s3.ap-northeast-2.amazonaws.com/http://m.moyamo.godomall.com/dataDto/goods/20/05/18/1000007880/1000007880_main_092.jpg?d=50x50",
    "targetBadge": 3
  }
}

```

[내알림설정수정]: 






## 포토


### <code>GET</code>  /v2/photoAlbums?userId={userId}

포토앨범 조회

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `userId` | 사용자 ID | false | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | 포토앨범 id |  |  |
      | `name`  | 포토앨범 이름 |  |  |
      | `representPhoto`  | 해당 포토앨범의 대표 포토 |  |  |
      | `representPhoto.id`  | 대표 포토의 id |  |  |
      | `representPhoto.attachments.photoUrl`  | 대표 포토의 이미지 링크 주소 |  |  |
      | `photoCnt` | 포토 앨범에 속한 총 포토 개수 | | |

    ```
        
  
         [
            {
                "id": 31,
                "name": "전체",
                "isDelete": false,
                "representPhoto": {
                    "id": 2002805,
                    "title": null,
                    "text": "속도가 빠르지요? 1",
                    "readCount": 0,
                    "commentCount": 0,
                    "likeCount": 0,
                    "scrapCount": 0,
                    "reportCount": 0,
                    "goodses": [],
                    "resource": null,
                    "attachments": [
                        {
                            "id": 2648459,
                            "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/60cfcab7-0887-4d36-892f-fabd39faca57.png"
                        }
                    ],
                    "posters": null,
                    "owner": {
                        "id": 39,
                        "nickname": "테스트",
                        "photoUrl": null,
                        "level": 2,
                        "role": "user",
                        "status": "normal",
                        "levelInfo": {
                            "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                            "level": 2,
                            "name": "초수"
                        },
                        "activity": {
                            "postingCount": 223,
                            "commentCount": 11,
                            "adoptedCount": 1
                        },
                        "provider": "phone",
                        "createdAt": "2014-11-01T02:57:10+09:00",
                        "badgeCount": 0,
                        "representBadge": null,
                        "totalPhotosCnt": 1,
                        "totalPhotosLikeCnt": 0,
                        "newbie": false
                    },
                    "isDelete": false,
                    "isBlind": false,
                    "postingType": "photo",
                    "createdAt": "2021-05-07T15:02:05+09:00",
                    "modifiedAt": "2021-05-07T15:02:05+09:00",
                    "youtubeId": null,
                    "orgAttachments": [
                        {
                            "id": 2648459,
                            "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/60cfcab7-0887-4d36-892f-fabd39faca57.png"
                        }
                    ],
                    "adopt": false,
                    "orgText": "속도가 빠르지요? 1",
                    "orgPosters": null
                },
                "photoCnt": 1
            },
            {
                "id": 32,
                "name": "새 앨범",
                "isDelete": false,
                "representPhoto": null,
                "photoCnt": 0
            }
        ]
    
    ```


### <code>GET</code>  /v2/photoAlbums/{photoAlbumId}

포토앨범 상세 조회

- Parameter (application/json)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `photoAlbumId` | 포토앨범 ID | | |
  | `sinceId` |  | |
  | `maxId` |  | | |
  | `orderby` | 정렬 순서 ( id : 최신순,  popular : 인기순 ) | | id |
  | `offset` | | | 0 |
  | `count`  | | | 10 |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | 게시글 ID |  |  |
      | `text`  | 내용 |  |  |
      | `readCount`  | 읽음수 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments.photoUrl`  | 첨부파일목록 : 이미지 경로 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |
      | `timelineId` | 타임라인 조회시 이 필드를 사용(sinceId, maxId) | | |
      | `isLike` | 좋아요 여부 | | |

    ```
        
  
         [
            {
                "id": 2002845,
                "title": null,
                "text": "금손4",
                "readCount": 0,
                "commentCount": 0,
                "likeCount": 0,
                "scrapCount": 0,
                "reportCount": 0,
                "goodses": [],
                "resource": null,
                "attachments": [
                    {
                        "id": 2648500,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/12/75e1fc63-9226-4170-8407-00ca4065aabf.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 1,
                    "nickname": "모야모",
                    "photoUrl": null,
                    "level": 6,
                    "role": "admin",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge5.png",
                        "level": 6,
                        "name": "신"
                    },
                    "activity": {
                        "postingCount": 13,
                        "commentCount": 2,
                        "adoptedCount": 0
                    },
                    "provider": "phone",
                    "createdAt": "2014-10-20T22:25:36+09:00",
                    "badgeCount": 2,
                    "representBadge": null,
                    "totalPhotosCnt": 5,
                    "totalPhotosLikeCnt": 1,
                    "newbie": false
                },
                "isDelete": false,
                "isBlind": false,
                "postingType": "photo",
                "createdAt": "2021-05-12T15:44:21+09:00",
                "modifiedAt": "2021-05-12T15:44:21+09:00",
                "timelineId": 39,
                "youtubeId": null,
                "orgPosters": null,
                "orgText": "금손4",
                "orgAttachments": [
                    {
                        "id": 2648500,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/12/75e1fc63-9226-4170-8407-00ca4065aabf.png"
                    }
                ],
                "adopt": false,
                "isLike": false
            },
            {
                "id": 2002843,
                "title": null,
                "text": "금손 3",
                "readCount": 0,
                "commentCount": 0,
                "likeCount": 0,
                "scrapCount": 0,
                "reportCount": 0,
                "goodses": [],
                "resource": null,
                "attachments": [
                    {
                        "id": 2648498,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/12/7e98b9f0-8c88-490d-a685-90a79af2031a.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 1,
                    "nickname": "모야모",
                    "photoUrl": null,
                    "level": 6,
                    "role": "admin",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge5.png",
                        "level": 6,
                        "name": "신"
                    },
                    "activity": {
                        "postingCount": 13,
                        "commentCount": 2,
                        "adoptedCount": 0
                    },
                    "provider": "phone",
                    "createdAt": "2014-10-20T22:25:36+09:00",
                    "badgeCount": 2,
                    "representBadge": null,
                    "totalPhotosCnt": 5,
                    "totalPhotosLikeCnt": 1,
                    "newbie": false
                },
                "isDelete": false,
                "isBlind": false,
                "postingType": "photo",
                "createdAt": "2021-05-12T14:43:41+09:00",
                "modifiedAt": "2021-05-12T14:43:41+09:00",
                "timelineId": 37,
                "youtubeId": null,
                "orgPosters": null,
                "orgText": "금손 3",
                "orgAttachments": [
                    {
                        "id": 2648498,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/12/7e98b9f0-8c88-490d-a685-90a79af2031a.png"
                    }
                ],
                "adopt": false,
                "isLike": false
            }
        ]
    
    ```


### <code>GET</code>  /v2/photoAlbums/representPhotos?userId={userId}

마이페이지 대표 사진, 인기사진

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `userId` | 사용자 ID | | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | 게시글 ID |  |  |
      | `text`  | 내용 |  |  |
      | `readCount`  | 읽음수 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments.photoUrl`  | 첨부파일목록 : 이미지 경로 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |
      | `isLike` | 좋아요 여부 | | |

    ```
        
  
         [
            {
                "id": 2002807,
                "title": null,
                "text": "속도가 빠르지요? 3",
                "readCount": 2,
                "commentCount": 0,
                "likeCount": 2,
                "scrapCount": 0,
                "reportCount": 0,
                "goodses": [],
                "resource": null,
                "attachments": [
                    {
                        "id": 2648461,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/13b137ee-0e4e-4760-bdc3-e214bd16896c.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 39,
                    "nickname": "테스트",
                    "photoUrl": null,
                    "level": 2,
                    "role": "user",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                        "level": 2,
                        "name": "초수"
                    },
                    "activity": {
                        "postingCount": 226,
                        "commentCount": 11,
                        "adoptedCount": 1
                    },
                    "provider": "phone",
                    "createdAt": "2014-11-01T02:57:10+09:00",
                    "badgeCount": 0,
                    "representBadge": null,
                    "totalPhotosCnt": 4,
                    "totalPhotosLikeCnt": 3,
                    "newbie": false
                },
                "isDelete": false,
                "isBlind": false,
                "postingType": "photo",
                "createdAt": "2021-05-07T15:42:03+09:00",
                "modifiedAt": "2021-05-07T15:42:03+09:00",
                "youtubeId": null,
                "orgAttachments": [
                    {
                        "id": 2648461,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/13b137ee-0e4e-4760-bdc3-e214bd16896c.png"
                    }
                ],
                "adopt": false,
                "orgText": "속도가 빠르지요? 3",
                "orgPosters": null,
                "isLike": true
            },
            {
                "id": 2002805,
                "title": null,
                "text": "속도가 빠르지요? 1",
                "readCount": 1,
                "commentCount": 0,
                "likeCount": 1,
                "scrapCount": 0,
                "reportCount": 0,
                "goodses": [],
                "resource": null,
                "attachments": [
                    {
                        "id": 2648459,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/60cfcab7-0887-4d36-892f-fabd39faca57.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 39,
                    "nickname": "테스트",
                    "photoUrl": null,
                    "level": 2,
                    "role": "user",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                        "level": 2,
                        "name": "초수"
                    },
                    "activity": {
                        "postingCount": 226,
                        "commentCount": 11,
                        "adoptedCount": 1
                    },
                    "provider": "phone",
                    "createdAt": "2014-11-01T02:57:10+09:00",
                    "badgeCount": 0,
                    "representBadge": null,
                    "totalPhotosCnt": 4,
                    "totalPhotosLikeCnt": 3,
                    "newbie": false
                },
                "isDelete": false,
                "isBlind": false,
                "postingType": "photo",
                "createdAt": "2021-05-07T15:02:05+09:00",
                "modifiedAt": "2021-05-07T15:02:05+09:00",
                "youtubeId": null,
                "orgAttachments": [
                    {
                        "id": 2648459,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/60cfcab7-0887-4d36-892f-fabd39faca57.png"
                    }
                ],
                "adopt": false,
                "orgText": "속도가 빠르지요? 1",
                "orgPosters": null,
                "isLike": true
            },
            {
                "id": 2002810,
                "title": null,
                "text": "속도가 빠르지요? 2",
                "readCount": 0,
                "commentCount": 0,
                "likeCount": 0,
                "scrapCount": 0,
                "reportCount": 0,
                "goodses": [],
                "resource": null,
                "attachments": [
                    {
                        "id": 2648465,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/10/61933772-54e3-4944-9781-84a32a950a49.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 39,
                    "nickname": "테스트",
                    "photoUrl": null,
                    "level": 2,
                    "role": "user",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                        "level": 2,
                        "name": "초수"
                    },
                    "activity": {
                        "postingCount": 226,
                        "commentCount": 11,
                        "adoptedCount": 1
                    },
                    "provider": "phone",
                    "createdAt": "2014-11-01T02:57:10+09:00",
                    "badgeCount": 0,
                    "representBadge": null,
                    "totalPhotosCnt": 4,
                    "totalPhotosLikeCnt": 3,
                    "newbie": false
                },
                "isDelete": false,
                "isBlind": false,
                "postingType": "photo",
                "createdAt": "2021-05-10T08:44:49+09:00",
                "modifiedAt": "2021-05-10T08:44:49+09:00",
                "youtubeId": null,
                "orgAttachments": [
                    {
                        "id": 2648465,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/10/61933772-54e3-4944-9781-84a32a950a49.png"
                    }
                ],
                "adopt": false,
                "orgText": "속도가 빠르지요? 2",
                "orgPosters": null,
                "isLike": false
            },
            {
                "id": 2002811,
                "title": null,
                "text": "속도가 빠르지요? 4",
                "readCount": 0,
                "commentCount": 0,
                "likeCount": 0,
                "scrapCount": 0,
                "reportCount": 0,
                "goodses": [],
                "resource": null,
                "attachments": [
                    {
                        "id": 2648466,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/10/48ac10d4-b521-402f-9eb5-5efe554f7551.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 39,
                    "nickname": "테스트",
                    "photoUrl": null,
                    "level": 2,
                    "role": "user",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                        "level": 2,
                        "name": "초수"
                    },
                    "activity": {
                        "postingCount": 226,
                        "commentCount": 11,
                        "adoptedCount": 1
                    },
                    "provider": "phone",
                    "createdAt": "2014-11-01T02:57:10+09:00",
                    "badgeCount": 0,
                    "representBadge": null,
                    "totalPhotosCnt": 4,
                    "totalPhotosLikeCnt": 3,
                    "newbie": false
                },
                "isDelete": false,
                "isBlind": false,
                "postingType": "photo",
                "createdAt": "2021-05-10T09:08:07+09:00",
                "modifiedAt": "2021-05-10T09:08:07+09:00",
                "youtubeId": null,
                "orgAttachments": [
                    {
                        "id": 2648466,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/10/48ac10d4-b521-402f-9eb5-5efe554f7551.png"
                    }
                ],
                "adopt": false,
                "orgText": "속도가 빠르지요? 4",
                "orgPosters": null,
                "isLike": false
            }
        ]
    
    ```



### <code>POST</code>  /v2/photoAlbums

포토앨범 생성 

- Parameter (application/json)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `name` | 생성할 포토앨범의 이름 | true | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id` | 포토앨범 ID | | |
      | `name` | 포토앨범의 이름 | | |
      | `representPhoto` | 포토앨범의 대표포토 | | |
      | `photoCnt` | 포토앨범에 들어있는 포토수 | | |

    ```
        
  
         [
            {
                "id": 41,
                "name": "새 앨범 3",
                "isDelete": false,
                "representPhoto": null,
                "photoCnt": 0
            }
        ]
    
    ```


### <code>PUT</code>  /v2/photoAlbums/{id}

포토앨범 수정

- Parameter (application/json)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 수정할 포토앨범의 ID | | | 
  | `name` | 수정 후 포토앨범의 이름 | true | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |


    ```
        
  
         [
            true
        ]
    
    ```


### <code>DELETE</code>  /v2/photoAlbums/{id}

포토앨범 삭제

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 삭제할 포토앨범의 ID | | | 

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |


    ```
        
  
         [
            true
        ]
    
    ```



### <code>POST</code>  /v2/photoAlbums/me/{id}

포토앨범 내에서 포토 등록 : 여러개 한번에 가능

- Parameter (multipart/form)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 현재 포토앨범 ID | | |
  | `postingType` | 타입 |true | |
  | `texts` | 작성글내용 |  ||
  | `files` | 파일(multiple) | true ||
  | `albumNames` | 앨범명 | | |
  
- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | 게시글 ID |  |  |
      | `text`  | 내용 |  |  |
      | `readCount`  | 읽음수 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments.photoUrl`  | 첨부파일목록 : 이미지 경로 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |

    ```
        
  
    [
        {
            "id": 2002819,
            "title": null,
            "text": "미소 2",
            "readCount": 0,
            "commentCount": 0,
            "likeCount": 0,
            "scrapCount": 0,
            "resource": null,
            "attachments": [
                {
                    "id": 2648474,
                    "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/10/f492efc8-4017-4d82-9a91-3edff10fad48.png"
                }
            ],
            "posters": null,
            "owner": {
                "id": 1,
                "nickname": "모야모",
                "photoUrl": null,
                "level": 6,
                "role": "admin",
                "status": "normal",
                "levelInfo": {
                    "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge5.png",
                    "level": 6,
                    "name": "신"
                },
                "badgeCount": 2,
                "representBadge": null,
                "totalPhotosCnt": 1,
                "totalPhotosLikeCnt": 0,
                "newbie": false
            },
            "postingType": "photo",
            "createdAt": "2021-05-10T13:01:37.339+09:00",
            "modifiedAt": "2021-05-10T13:01:37.339+09:00",
            "youtubeId": null,
            "adopt": false
        },
        {
            "id": 2002820,
            "title": null,
            "text": "미소 3",
            "readCount": 0,
            "commentCount": 0,
            "likeCount": 0,
            "scrapCount": 0,
            "resource": null,
            "attachments": [
                {
                    "id": 2648475,
                    "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/10/d362f877-70f9-4b08-97c8-8ae9593e755f.png"
                }
            ],
            "posters": null,
            "owner": {
                "id": 1,
                "nickname": "모야모",
                "photoUrl": null,
                "level": 6,
                "role": "admin",
                "status": "normal",
                "levelInfo": {
                    "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge5.png",
                    "level": 6,
                    "name": "신"
                },
                "badgeCount": 2,
                "representBadge": null,
                "totalPhotosCnt": 1,
                "totalPhotosLikeCnt": 0,
                "newbie": false
            },
            "postingType": "photo",
            "createdAt": "2021-05-10T13:01:37.52+09:00",
            "modifiedAt": "2021-05-10T13:01:37.52+09:00",
            "youtubeId": null,
            "adopt": false
        }
    ]
    
    ```

### <code>GET</code>  /v2/photoAlbums/{id}/photoCount

포토앨범 내 포토 개수 조회

- Parameter (multipart/form)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 현재 포토앨범 ID | | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |


    ```
        
  
    {
        2   
    }
    
    ```




### <code>POST</code>  /v2/photos

포토 등록 : 여러개 한번에 가능

- Parameter (multipart/form)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `postingType` | 타입 |true | |
  | `texts` | 작성글내용 |  ||
  | `files` | 파일(multiple) | true ||
  | `albumNames` | 앨범명 | | |
  
- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | 게시글 ID |  |  |
      | `text`  | 내용 |  |  |
      | `readCount`  | 읽음수 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments.photoUrl`  | 첨부파일목록 : 이미지 경로 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |
    
    ```
        
  
    [
        {
            "id": 2002806,
            "title": null,
            "text": "속도가 빠르지요? 2",
            "readCount": 0,
            "commentCount": 0,
            "likeCount": 0,
            "scrapCount": 0,
            "resource": null,
            "attachments": [
                {
                    "id": 2648460,
                    "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/f7f4fb30-90cd-4877-8b18-70ac36cbe6e5.png"
                }
            ],
            "posters": null,
            "owner": {
                "id": 39,
                "nickname": "테스트",
                "photoUrl": null,
                "level": 2,
                "role": "user",
                "status": "normal",
                "levelInfo": {
                    "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                    "level": 2,
                    "name": "초수"
                },
                "badgeCount": 0,
                "representBadge": null,
                "totalPhotosCnt": 1,
                "totalPhotosLikeCnt": 0,
                "newbie": false
            },
            "postingType": "photo",
            "createdAt": "2021-05-07T15:42:02.496+09:00",
            "modifiedAt": "2021-05-07T15:42:02.496+09:00",
            "youtubeId": null,
            "adopt": false
        },
        {
            "id": 2002807,
            "title": null,
            "text": "속도가 빠르지요? 3",
            "readCount": 0,
            "commentCount": 0,
            "likeCount": 0,
            "scrapCount": 0,
            "resource": null,
            "attachments": [
                {
                    "id": 2648461,
                    "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/13b137ee-0e4e-4760-bdc3-e214bd16896c.png"
                }
            ],
            "posters": null,
            "owner": {
                "id": 39,
                "nickname": "테스트",
                "photoUrl": null,
                "level": 2,
                "role": "user",
                "status": "normal",
                "levelInfo": {
                    "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                    "level": 2,
                    "name": "초수"
                },
                "badgeCount": 0,
                "representBadge": null,
                "totalPhotosCnt": 1,
                "totalPhotosLikeCnt": 0,
                "newbie": false
            },
            "postingType": "photo",
            "createdAt": "2021-05-07T15:42:02.637+09:00",
            "modifiedAt": "2021-05-07T15:42:02.637+09:00",
            "youtubeId": null,
            "adopt": false
        }
    ]
    
    ```


### <code>PUT</code>  /v2/photos/{id}

포토 수정 (application/json)

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 수정할 포토 게시글의 ID | | | 
  | `text` | 수정 후 포토 게시글 본문 내용 | | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | 게시글 ID |  |  |
      | `text`  | 내용 |  |  |
      | `readCount`  | 읽음수 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments.photoUrl`  | 첨부파일목록 : 이미지 경로 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |


    ```
        
  
         [
            {
                "id": 2002806,
                "title": null,
                "text": "속도가 빠르죠? 2",
                "readCount": 0,
                "commentCount": 0,
                "likeCount": 0,
                "scrapCount": 0,
                "resource": null,
                "attachments": [
                    {
                        "id": 2648460,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/f7f4fb30-90cd-4877-8b18-70ac36cbe6e5.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 39,
                    "nickname": "테스트",
                    "photoUrl": null,
                    "level": 2,
                    "role": "user",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                        "level": 2,
                        "name": "초수"
                    },
                    "badgeCount": 0,
                    "representBadge": null,
                    "totalPhotosCnt": 3,
                    "totalPhotosLikeCnt": 0,
                    "newbie": false
                },
                "postingType": "photo",
                "createdAt": "2021-05-07T15:42:02+09:00",
                "modifiedAt": "2021-05-07T15:47:14+09:00",
                "youtubeId": null,
                "adopt": false
            }
        ]
    
    ```


### <code>PUT</code>  /v2/photos/delete

포토 삭제 : 여러개 한번에 가능

- Parameter (application/json)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 삭제할 포토 게시글의 ID | false | | 
  | `albumName` | 삭제할 포토 게시글이 위치한 앨범명 | | `전체` |
  | `all` | 전체 선택 여부 boolean | | `false` |
  
- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | 게시글 ID |  |  |
      | `text`  | 내용 |  |  |
      | `readCount`  | 읽음수 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments.photoUrl`  | 첨부파일목록 : 이미지 경로 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |


    ```
        
  
         [
            {
                "id": 2002806,
                "title": null,
                "text": "속도가 빠르죠? 2",
                "readCount": 0,
                "commentCount": 0,
                "likeCount": 0,
                "scrapCount": 0,
                "resource": null,
                "attachments": [
                    {
                        "id": 2648460,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/f7f4fb30-90cd-4877-8b18-70ac36cbe6e5.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 39,
                    "nickname": "테스트",
                    "photoUrl": null,
                    "level": 2,
                    "role": "user",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                        "level": 2,
                        "name": "초수"
                    },
                    "badgeCount": 0,
                    "representBadge": null,
                    "totalPhotosCnt": 3,
                    "totalPhotosLikeCnt": 0,
                    "newbie": false
                },
                "postingType": "photo",
                "createdAt": "2021-05-07T15:42:02+09:00",
                "modifiedAt": "2021-05-07T15:48:30+09:00",
                "youtubeId": null,
                "adopt": false
            }
        ]
    
    ```  



### <code>PUT</code>  /v2/photos/move

포토 이동 : 여러개 한번에 가능

- Parameter (application/json)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 이동할 포토 게시글의 ID | false | | 
  | `beforeAlbumName` | 이동할 포토 게시글이 위치한 앨범명 | true |  |
  | `afterAlbumName` | 포토 게시글이 이동 될 앨범명 | true |  |
  | `all` | 전체 선택 여부 boolean | | `false` |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | 게시글 ID |  |  |
      | `text`  | 내용 |  |  |
      | `readCount`  | 읽음수 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments.photoUrl`  | 첨부파일목록 : 이미지 경로 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |


    ```
        
  
         [
            {
                "id": 2002807,
                "title": null,
                "text": "속도가 빠르지요? 3",
                "readCount": 0,
                "commentCount": 0,
                "likeCount": 0,
                "scrapCount": 0,
                "resource": null,
                "attachments": [
                    {
                        "id": 2648461,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/13b137ee-0e4e-4760-bdc3-e214bd16896c.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 39,
                    "nickname": "테스트",
                    "photoUrl": null,
                    "level": 2,
                    "role": "user",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                        "level": 2,
                        "name": "초수"
                    },
                    "badgeCount": 0,
                    "representBadge": null,
                    "totalPhotosCnt": 2,
                    "totalPhotosLikeCnt": 0,
                    "newbie": false
                },
                "postingType": "photo",
                "createdAt": "2021-05-07T15:42:03+09:00",
                "modifiedAt": "2021-05-07T15:42:03+09:00",
                "youtubeId": null,
                "adopt": false
            }
        ]
    
    ```  


### <code>PUT</code>  /v2/photos/copy

포토 복사 : 여러개 한번에 가능

- Parameter (application/json)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 복사할 포토 게시글의 ID | false | | 
  | `afterAlbumNames` | 포토 게시글이 복사 될 앨범명 | true |  |
  | `all` | 전체 선택 여부 boolean | | `false` |
  | `currentAlbumName` | 현재 앨범명 (전체 선택 시 알아야 하는 현재 앨범명) | false | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | 게시글 ID |  |  |
      | `text`  | 내용 |  |  |
      | `readCount`  | 읽음수 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments.photoUrl`  | 첨부파일목록 : 이미지 경로 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |


    ```
        
  
         [
            {
                "id": 2002807,
                "title": null,
                "text": "속도가 빠르지요? 3",
                "readCount": 0,
                "commentCount": 0,
                "likeCount": 0,
                "scrapCount": 0,
                "reportCount": 0,
                "goodses": [],
                "resource": null,
                "attachments": [
                    {
                        "id": 2648461,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/13b137ee-0e4e-4760-bdc3-e214bd16896c.png"
                    }
                ],
                "posters": null,
                "owner": {
                    "id": 39,
                    "nickname": "테스트",
                    "photoUrl": null,
                    "level": 2,
                    "role": "user",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                        "level": 2,
                        "name": "초수"
                    },
                    "activity": {
                        "postingCount": 224,
                        "commentCount": 11,
                        "adoptedCount": 1
                    },
                    "provider": "phone",
                    "createdAt": "2014-11-01T02:57:10+09:00",
                    "badgeCount": 0,
                    "representBadge": null,
                    "totalPhotosCnt": 2,
                    "totalPhotosLikeCnt": 0,
                    "newbie": false
                },
                "isDelete": false,
                "isBlind": false,
                "postingType": "photo",
                "createdAt": "2021-05-07T15:42:03+09:00",
                "modifiedAt": "2021-05-07T15:42:03+09:00",
                "youtubeId": null,
                "orgAttachments": [
                    {
                        "id": 2648461,
                        "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/13b137ee-0e4e-4760-bdc3-e214bd16896c.png"
                    }
                ],
                "orgText": "속도가 빠르지요? 3",
                "orgPosters": null,
                "adopt": false
            }
        ]
    
    ```  

### <code>GET</code>  /v2/photos/{id}

포토 조회

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 게시글ID | ||

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id`  | ID |  |  |
      | `text`  | 내용 |  |  |
      | `likeCount`  | 좋아요수 |  |  |
      | `attachments`  | 첨부파일목록 |  |  |
      | `owner`  | 글쓴이 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |
      | `isLike`  | 좋아요 여부 |  |  |
    
```
    {
        "id": 2002845,
        "title": null,
        "text": "금손4",
        "readCount": 1,
        "commentCount": 0,
        "likeCount": 0,
        "scrapCount": 0,
        "goodses": [],
        "resource": null,
        "attachments": [
            {
                "id": 2648500,
                "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/12/75e1fc63-9226-4170-8407-00ca4065aabf.png"
            }
        ],
        "posters": null,
        "owner": {
            "id": 1,
            "nickname": "모야모",
            "photoUrl": null,
            "level": 6,
            "role": "admin",
            "status": "normal",
            "levelInfo": {
                "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge5.png",
                "level": 6,
                "name": "신"
            },
            "badgeCount": 2,
            "representBadge": null,
            "totalPhotosCnt": 5,
            "totalPhotosLikeCnt": 1,
            "newbie": false
        },
        "postingType": "photo",
        "createdAt": "2021-05-12T15:44:21+09:00",
        "modifiedAt": "2021-05-17T10:12:07+09:00",
        "youtubeId": null,
        "adopt": false,
        "isLike": false
    }
```


### <code>POST</code>  /v2/photos/{id}/like

포토 좋아요

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 게시글ID | ||

- Response (application/json)

    * success response

```
    true
```


### <code>DELETE</code>  /v2/photos/{id}/like

포토 좋아요취소

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 게시글ID | ||

- Response (application/json)

    * success response

```
    true
```

### <code>POST</code>  /v2/photos/{id}/report

포토 신고하기

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 게시글ID | ||
  | `title` | 신고항목 | ||
  | `text` | 내용 | ||

- Response (application/json)

    * success response

```
    true, false
```

### <code>GET</code>  /v2/search/writerUsers

작가별

- Parameter (application/json)

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `orderby` | 정렬 순서 ( id : 최신순,  photoCount : 사진 많은순, photoLikeCount : 인기순 ) | | id | 
  | `sinceId` |  | | |
  | `maxId` |  | | |
  | `offset` | | | 0 |
  | `count`  | | | 10 |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `timelineId`  | 타임라인 조회시 이 필드를 사용(sinceId, maxId) |  |  |
      | `user` | 사용자 | | |
      | `user.id` | 사용자 ID | | |
      | `user.nickname` | 사용자 닉네임 | | |
      | `user.photoUrl` | 사용자 사진 url | | |
      | `user.totalPhotosCnt` | 총 포토 갯수 | | |
      | `user.totalPhotosLikeCnt` | 총 하트 개수(포토만) | | |
      | `photos` | 대표 포토들 | | |
      | `photos.id`  | 게시글 ID |  |  |
      | `photos.attachments.photoUrl`  | 첨부파일목록 : 이미지 경로 |  |  |
      | `postingType`  | 게시글타입 |  |  |
      | `createdAt`  | 생성일시 |  |  |
      | `modifiedAt`  | 수정일시 |  |  |


    ```
        
  
         [
            {
                "timelineId": 24,
                "user": {
                    "id": 39,
                    "nickname": "테스트",
                    "photoUrl": null,
                    "level": 2,
                    "role": "user",
                    "status": "normal",
                    "levelInfo": {
                        "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                        "level": 2,
                        "name": "초수"
                    },
                    "badgeCount": 0,
                    "representBadge": null,
                    "totalPhotosCnt": 4,
                    "totalPhotosLikeCnt": 3,
                    "newbie": false
                },
                "photos": [
                    {
                        "id": 2002811,
                        "title": null,
                        "text": "속도가 빠르지요? 4",
                        "readCount": 0,
                        "commentCount": 0,
                        "likeCount": 0,
                        "scrapCount": 0,
                        "resource": null,
                        "attachments": [
                            {
                                "id": 2648466,
                                "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/10/48ac10d4-b521-402f-9eb5-5efe554f7551.png"
                            }
                        ],
                        "posters": null,
                        "owner": {
                            "id": 39,
                            "nickname": "테스트",
                            "photoUrl": null,
                            "level": 2,
                            "role": "user",
                            "status": "normal",
                            "levelInfo": {
                                "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                                "level": 2,
                                "name": "초수"
                            },
                            "badgeCount": 0,
                            "representBadge": null,
                            "totalPhotosCnt": 4,
                            "totalPhotosLikeCnt": 3,
                            "newbie": false
                        },
                        "postingType": "photo",
                        "createdAt": "2021-05-10T09:08:07+09:00",
                        "modifiedAt": "2021-05-10T09:08:07+09:00",
                        "youtubeId": null,
                        "adopt": false
                    },
                    {
                        "id": 2002810,
                        "title": null,
                        "text": "속도가 빠르지요? 2",
                        "readCount": 0,
                        "commentCount": 0,
                        "likeCount": 0,
                        "scrapCount": 0,
                        "resource": null,
                        "attachments": [
                            {
                                "id": 2648465,
                                "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/10/61933772-54e3-4944-9781-84a32a950a49.png"
                            }
                        ],
                        "posters": null,
                        "owner": {
                            "id": 39,
                            "nickname": "테스트",
                            "photoUrl": null,
                            "level": 2,
                            "role": "user",
                            "status": "normal",
                            "levelInfo": {
                                "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                                "level": 2,
                                "name": "초수"
                            },
                            "badgeCount": 0,
                            "representBadge": null,
                            "totalPhotosCnt": 4,
                            "totalPhotosLikeCnt": 3,
                            "newbie": false
                        },
                        "postingType": "photo",
                        "createdAt": "2021-05-10T08:44:49+09:00",
                        "modifiedAt": "2021-05-10T08:44:49+09:00",
                        "youtubeId": null,
                        "adopt": false
                    },
                    {
                        "id": 2002807,
                        "title": null,
                        "text": "속도가 빠르지요? 3",
                        "readCount": 2,
                        "commentCount": 0,
                        "likeCount": 2,
                        "scrapCount": 0,
                        "resource": null,
                        "attachments": [
                            {
                                "id": 2648461,
                                "photoUrl": "http://d1ujq2dpv14gay.cloudfront.net/dev/postings/2021/05/07/13b137ee-0e4e-4760-bdc3-e214bd16896c.png"
                            }
                        ],
                        "posters": null,
                        "owner": {
                            "id": 39,
                            "nickname": "테스트",
                            "photoUrl": null,
                            "level": 2,
                            "role": "user",
                            "status": "normal",
                            "levelInfo": {
                                "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                                "level": 2,
                                "name": "초수"
                            },
                            "badgeCount": 0,
                            "representBadge": null,
                            "totalPhotosCnt": 4,
                            "totalPhotosLikeCnt": 3,
                            "newbie": false
                        },
                        "postingType": "photo",
                        "createdAt": "2021-05-07T15:42:03+09:00",
                        "modifiedAt": "2021-05-07T15:42:03+09:00",
                        "youtubeId": null,
                        "adopt": false
                    }
                ]
            },
            ...
        ]
    
    ```  



### <code>GET</code>  /v2/photos/popularWriters

인기작가

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  
- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |
      | `id` | 사용자 ID | | |
      | `nickname` | 사용자 닉네임 | | |
      | `photoUrl` | 사용자 사진 url | | |
      | `totalPhotosCnt` | 총 포토 갯수 | | |
      | `totalPhotosLikeCnt` | 총 하트 개수(포토만) | | |



    ```
        
  
         [
            {
                "id": 39,
                "nickname": "테스트",
                "photoUrl": null,
                "level": 2,
                "role": "user",
                "status": "normal",
                "levelInfo": {
                    "badge": "http://d1ujq2dpv14gay.cloudfront.net/dev/commons/badges/badge1.png",
                    "level": 2,
                    "name": "초수"
                },
                "activity": {
                    "postingCount": 226,
                    "commentCount": 11,
                    "adoptedCount": 1
                },
                "provider": "phone",
                "createdAt": "2014-11-01T02:57:10+09:00",
                "badgeCount": 0,
                "representBadge": null,
                "totalPhotosCnt": 4,
                "totalPhotosLikeCnt": 3,
                "newbie": false
            },
            ...
        ]
    
    ```  


### <code>POST</code>  /v2/photoAlbums/{id}/share

포토앨범 공유하기

- Parameter

  | attribute| description | required | default |
  | --- | --- | -------- | --- |
  | `id` | 사용자 ID |  | |

- Response (application/json)

    * 필드

      | attribute| description | required | default |
      | --- | --- | -------- | --- |


    ```
        
  
         [
            {
               "uuid": "45e32f18-a228-4392-afd1-2d47c5527475",
                "resource": {
                    "resourceId": "39",
                    "resourceType": "photoalbum",
                    "referenceId": "39",
                    "referenceType": "photoalbum"
                },
                "deeplink": "https://go.moyamo.co.kr/UTjp9982H1MZ5H516"
            }
        ]
    
    ```  

* 링크 정의

```
            https://go.moyamo.co.kr/skGMeE9DQNdvVHxm8
            
            -> https://link.moyamo.co.kr/photoAlbums/39?postingType=photoalbum&code=45e32f18-a228-4392-afd1-2d47c5527475
```