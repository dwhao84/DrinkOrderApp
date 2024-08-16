
<p align="center">
<img src="https://github.com/dwhao84/HW48-App-store/blob/08d1d4652c2408d548b139ec4a57c3d31c2d9d1e/HW48-App%20store/Supporting%20FIles/Assets.xcassets/AppStore_Banner.imageset/AppStore_Banner.jpg" width="700" height="450"/>
</p>

#  Drink Order App
這是一個CRUD的iOS App，裡面的技術包含:
- Programmatically UI
- Restful Api
- 自訂Components
- OOP 概念
- Library使用:
- Kingfisher
- IQKeyboardManager


## Login View Controller
登入頁面，基本上是使用FAQs Api，如果有註冊成功的話，會回傳token的值，以確保有登入成功，登入成功之後，才有辦法進行飲料的訂購。

<p align="left">
<img src="https://github.com/dwhao84/HW48-App-store/blob/08d1d4652c2408d548b139ec4a57c3d31c2d9d1e/HW48-App%20store/Supporting%20FIles/Assets.xcassets/AppStore_Banner.imageset/AppStore_Banner.jpg" width="700" height="450"/>
</p>



## Register View Controller

<p align="left">
<img src="https://github.com/dwhao84/HW48-App-store/blob/08d1d4652c2408d548b139ec4a57c3d31c2d9d1e/HW48-App%20store/Supporting%20FIles/Assets.xcassets/AppStore_Banner.imageset/AppStore_Banner.jpg" width="700" height="450"/>
</p>




## Home Page View Controller
Home Page View Controller是顯示所有產品頁面的資料頁面，TableViewCell裡面有顯示大小杯的價錢、產品說明、
<p align="left">
<img src="https://github.com/dwhao84/DrinkOrderApp/blob/c84809bcb5cc6ab5c0cac4542ccaf4839803f621/DrinkOrderApp/Supporting%20Files/Assets.xcassets/README%20Use/Home%20Page%20VC.imageset/Home%20Page%20VC.png" width="428" height="800"/>
</p>





## Order Detail View Controller
Order Detail View Controller，基本上用大量的UI Components建立textField、Pickerview，作為產品訂購輸入的Components。
這個Controller負責處理飲料的詳細訂購過程，讓使用者可以自由地選擇尺寸、糖度、冰塊量、配料和數量，並送出他們的訂單。
<p align="center">
<img src="https://github.com/dwhao84/HW48-App-store/blob/08d1d4652c2408d548b139ec4a57c3d31c2d9d1e/HW48-App%20store/Supporting%20FIles/Assets.xcassets/AppStore_Banner.imageset/AppStore_Banner.jpg" width="700" height="450"/>
</p>




## Order List View Controller
Order List View Controller，基本上是使用tableView並搭配我自己做的tableViewCell，並透過網路串接的功能，將訂購資料傳到Airtable(後台)，並在Order ListVC中顯示。
<p align="center">
<img src="https://github.com/dwhao84/HW48-App-store/blob/08d1d4652c2408d548b139ec4a57c3d31c2d9d1e/HW48-App%20store/Supporting%20FIles/Assets.xcassets/AppStore_Banner.imageset/AppStore_Banner.jpg" width="700" height="450"/>
</p>




## Setting View Controller
Setting View Controller，基本上是使用tableView insertGroup的style，並運用我自己做的假資料，做出下列功能:

### 功能列表
- **撥打商家電話**
  - 能讓使用者能夠直接從App，直接內撥打商家的電話。

- **寄送 E-mail 給店家**
  - 提供使用者一個界面，可以直接從應用內向店家發送電子郵件。

- **顯示承諾條款**
  - 顯示應用或服務的承諾條款給使用者閱讀。

- **顯示商品檢查報告**
  - 提供商品檢查的結果報告。

- **顯示使用者隱私**
  - 說明如何處理和保護使用者的個人隱私。

- **顯示品牌故事**
  - 分享品牌的歷史和故事，增強品牌形象。

這樣的描述方式使得各個功能的用途和實作更加清晰，有助於理解和維護。

<p align="center">
<img src="https://github.com/dwhao84/HW48-App-store/blob/08d1d4652c2408d548b139ec4a57c3d31c2d9d1e/HW48-App%20store/Supporting%20FIles/Assets.xcassets/AppStore_Banner.imageset/AppStore_Banner.jpg" width="700" height="450"/>
</p>




## Store Location View Controller

<p align="center">
<img src="https://github.com/dwhao84/HW48-App-store/blob/08d1d4652c2408d548b139ec4a57c3d31c2d9d1e/HW48-App%20store/Supporting%20FIles/Assets.xcassets/AppStore_Banner.imageset/AppStore_Banner.jpg" width="700" height="450"/>
</p>


> Reference:
> 
> 
