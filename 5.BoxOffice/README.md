# iOS_boostcourse

## 5. BoxOffice!
![BO1](https://user-images.githubusercontent.com/70695311/105000075-3d3acc80-5a71-11eb-89eb-0d785a27590b.gif)
*  서버의 API를 통해 영화 정보들을 요청하고 가져온다.
*  가져온 정보들을 테이블뷰와 컬렉션뷰를 활용하여 화면에 나타낸다.
*  화면 오른쪽 상단 바 버튼을 눌러 정렬방식을 변경할 수 있다.. (예매순위/큐레이션/개봉일 기준)

![BO2](https://user-images.githubusercontent.com/70695311/105000079-3e6bf980-5a71-11eb-9199-952b0994bb31.gif)

* 영화의 상세 정보를 제공한다.
    1. 영화 포스터를 포함한 소개, 줄거리, 감독/출연배우
    2. 예매율, 예매순위, 평점, 누적관객수, 줄거리
    3. 평점을 별점으로 환산해 별점 이미지를 제공한다.
* 앞서 테이블뷰와 컬렉션뷰의 나타낸 영화 정보들의 id를 통해 가져온다.
* 오른쪽 상단에는 평가 버튼을 이용하여 한줄평 목록을 볼 수 있다.

![BO3](https://user-images.githubusercontent.com/70695311/105000083-3f9d2680-5a71-11eb-841d-26fe0dd92f86.gif)

* 해당 영화의 한줄평 목록을 제공한다.
* 오른쪽 상단 버튼을 눌러 직접 한줄평 작성할 수 있다. 
    1. 한줄평 작성은 modal을 이용하여 뷰를 제공한다.
    2. 0~10까지의 숫자만 입력해야 완료 버튼이 enable하게 된며 별점으로 환산한다.
    3. 닉네임, 한줄평을 입력할 수 있다.
* 한줄평 작성 완료시 완료 알림을 확인할 수 있다.

#### What I learned
- APIResponse
-URLSession
    - URLSessionDataTask
    - URLResponse
    - PHAssetCollection
- Action Handler
- unwind

#### What I need to supplement
- AutoLayout을 제대로 잡지 못했다. 
    1. Buildtime Issues들 부터 해결(20210119 수정)
   
         <img width="100" alt="스크린샷 2021-01-19 오후 4 49 51" src="https://user-images.githubusercontent.com/70695311/105285693-4013f980-5bf8-11eb-812b-abf842b06184.png">
   
    2.  **[LayoutConstraints] Unable to simultaneously satisfy constraints.**
        **Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.**
    
        CommentViewController의 테이블 뷰 실행 시 콘솔창에 이러한 문제가... 나온다. 
   
     <img width="200" alt="스크린샷 2021-01-21 오후 2 25 03" src="https://user-images.githubusercontent.com/70695311/105285972-c29cb900-5bf8-11eb-81dd-9d4c0e095dd4.png">
   
     무언가 이상함을 깨닫고 찾아보니 autoresizing mask constraint가 뷰의 크기와 위치를 완전히 고정한다는 것을 알았다. auto layout을 사용하여 크기와 위치를 동적으로 계산하기 위해 이것을 풀어주었더니 두번째 에러가 생겼다.
     **[Warning] Warning once only: Detected a case where constraints ambiguously suggest a height of zero for a table view cell's content view**
음... 셀이 constraints가 뭔가 이상하다는 것 같은데.. 알고보니 imageview에 고정된 사이즈를 주고 위아래로 Top,Bottom space to constraints를 주었더니 셀의 label이 길어짐에 따라 셀의 높이가 동적으로 바뀌지 못한다는 것이었다. 따라서 label을 기준으로 Top,Bottom space to constraints를 주고 해결. (20210121 수정)

   <img width="200" alt="스크린샷 2021-01-21 오후 3 13 00" src="https://user-images.githubusercontent.com/70695311/105288236-2b853080-5bfb-11eb-8839-9f67ff39a5f4.png">

- 기능에 집중하다 보니 코드 구조가 간결하지 못하다. 
    - Star (20210121 수정)
    - APIController, APIControllerDelegate(20211027 수정)
    - Singleton 적용 (20210211 수정)
- 네트워킹 (로딩/새로고침)에 따른 표시를 하지 못했다.
- 추가적인 오류를 발생한다.


