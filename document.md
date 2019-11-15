### 活動列表

`events.json`

key | type | 描述 |
-----|:-----:|-----:
tag | string | 標籤用於辨認活動區域名稱  
isActive | bool | 是否進行中 
hasLocalization | bool | 有無多國語言(目前只使用zh)
name | string | 活動名稱  
host | string | 主辦單位  
date | string | 活動日期(格式yyyy-mm-dd)  
useImageAsset | bool | 是否使用本地的圖片檔(App)
image | string | 封面圖片網址 
imageAsset | string | 封面圖片本地路徑(App)
welcomeText | string | 主畫面歡迎文字
descText | string | 描述(無使用)
location | json object | 活動地點
&nbsp; name | string | 地點名稱(簡稱 活動列表用)
&nbsp; mapTitle | string | 地圖頁面標題
&nbsp; mapSubTitle | string | 地圖頁面子標題
&nbsp; lat | double | 活動地點緯度
&nbsp; lng | double | 活動地點經度
links | json object | 連結(填空app不會顯示)
&nbsp; facebook | string | facebook連結
&nbsp; twitter | string | twitter連結
&nbsp; linkedinIn | string | linkedinIn連結
&nbsp; youtube | string | youtube連結
&nbsp; meetup | string | meetup連結
&nbsp; emailUrl | string | emailUrl連結(mailto:XXX)
&nbsp; telegram | string | telegram連結
&nbsp; registration | string | 活動報名連結

#### example

```json
{
  "devFestEvents": [
    {
      "tag": "taichung",
      "isActive": true,
      "hasLocalization": true,
      "name": "DevFest 台中",
      "host": "GDG 台中",
      "date": "2019-11-9",
      "useImageAsset": true,
      "image": "https://jamaicandevelopers.com/p/devfest-2019/@@images/image",
      "imageAsset": "assets/images/banner_devFest_taichung.webp",
      "welcomeText": "GDG DevFest Taichung 2019",
      "descText": "略過",
      "location": {
        "name": "東海大學",
        "mapTitle": "東海大學推廣部",
        "mapSubTitle": "407台中市西屯區台灣大道四段1727號",
        "lat": 24.1824046,
        "lng": 120.6104689
      },
      "links": {
        "facebook": "https://www.facebook.com/GDG.Taichung",
        "twitter": "",
        "linkedinIn": "",
        "youtube": "",
        "meetup": "https://www.meetup.com/GDGTaichung",
        "emailUrl": "",
        "telegram": "https://t.me/gdg_taichung",
        "registration": "https://gdgtaichung.kktix.cc/events/devfest-2019-taichung"
      }
    }
  ]
}
```
----------------

`<<envent_tag>>_one_for_all.json`

key | type | 描述 |
-----|:-----:|-----:
tracks | json object | 議程場地  
&nbsp; id | string | 議程場地id
&nbsp; title | string | 議程場地名稱
sessions | json object  | 議程 
&nbsp; session_id | string | 議程id
&nbsp; session_start_time | string | 開始時間(格式yyyy-mm-dd HH:MM:ss) 
&nbsp; session_total_time | string | 議程時間(單位分鐘)  
&nbsp; session_title | string | 標題
&nbsp; session_desc | string | 詳細資訊  
&nbsp; speaker_id | string | 議程講者id 
&nbsp; track_id | string | 議程場地id  
&nbsp; tags | string array | 議程tag，使用關鍵字
&nbsp; links | json object | 連結
&nbsp;&nbsp;  presentation | string | 簡報連結(填空app不會顯示)
&nbsp;&nbsp;  video | string | 綠影連結(填空app不會顯示)
&nbsp;&nbsp;  hackmd | string | 共筆連結(填空app不會顯示)
speakers | json object | 講者
&nbsp; speaker_id | string | 議程講者id
&nbsp; speaker_image | string | 講者照片網址
&nbsp; speaker_name | string | 講者名字
&nbsp; speaker_desc | string | 講者介紹
&nbsp; speaker_session | string | 講者議程名稱
&nbsp; fb_url | string | facebook連結(填空app不會顯示)
&nbsp; github_url | string | github連結(填空app不會顯示)
&nbsp; linkedin_url | string | linkedin連結(填空app不會顯示)
&nbsp; twitter_url | string | twitter連結(填空app不會顯示)
sponsors | json object | 贊助or可填主辦(填空app不會顯示)
&nbsp; name | string | 名稱
&nbsp; image | string | 圖片連結
&nbsp; desc | string | 介紹
&nbsp; url | string | 連結
&nbsp; logo | string | 無使用
teams | json object | 志工名冊(填空app不會顯示)
&nbsp; name | string | 名字
&nbsp; image | string | 大頭照連結
&nbsp; desc | string | 介紹
&nbsp; contribution | string | 單位
&nbsp; fb_url | string | facebook連結(填空app不會顯示)
&nbsp; github_url | string | github連結(填空app不會顯示)
&nbsp; linkedin_url | string | linkedin連結(填空app不會顯示)
&nbsp; twitter_url | string | twitter連結(填空app不會顯示)

```json
{
  "tracks": [
    {
      "id": "1",
      "title": "R1"
    }
  ],
  "sessions": [
    {
      "session_id": "1",
      "session_start_time": "2019-11-09 09:30:00",
      "session_total_time": "20",
      "session_title": "Opening",
      "session_desc": "",
      "speaker_id": "1",
      "track_id": "1",
      "tags": [],
      "links": {
        "presentation": "",
        "video": "",
        "hackmd": ""
      }
    }
  ],
  "speakers": [
    {
      "speaker_id": "1",
      "speaker_image": "",
      "speaker_name": "Ericsk",
      "speaker_desc": "",
      "speaker_session": "Opening",
      "fb_url": null,
      "github_url": null,
      "linkedin_url": null,
      "twitter_url": null
    }
  ],
  "sponsors": [
    {
      "name": "Google",
      "image": "",
      "desc": "贊助商",
      "url": "https://developers.google.com/",
      "logo": ""
    }
  ],
  "teams": [
    {
      "name": "Weitsai",
      "desc": "議程組",
      "contribution": "GDG Kaohsiung",
      "image": "",
      "fb_url": "https://www.facebook.com/begining1003",
      "twitter_url": "",
      "linkedin_url": "",
      "github_url": "https://github.com/weitsai"
    }
  ]
}
```