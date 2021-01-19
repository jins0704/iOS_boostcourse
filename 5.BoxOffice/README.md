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
- 기능에 집중하다 보니 코드 구조가 간결하지 못하다.
- 아직 백그라운드 스레드와 메인 스레드에서 처리할 것은 제대로 구분하지 못했다.
- 네트워킹 (로딩/새로고침)에 따른 표시를 하지 못했다.
