### 活動列表

`events.json`

key | type | 描述 |
-----|:-----:|-----:
tag | string | 標籤用於辨認活動區域名稱  
isActive | bool | 是否進行中 
hasLocalization | bool | 有無多國語言(目前只使用zh)
name | string | 活動名稱  
host | string | 主辦單位  
date | string | 活動日期(格式YYYY-mm-dd)  
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