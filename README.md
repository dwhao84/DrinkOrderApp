# 飲料訂購 App
這是一個實現CRUD功能的iOS應用程式，具有以下技術特點：
- Programmatically UI
- RESTful API串接
- Custom UI
- OOP
- Library：
  - Kingfisher：圖片加載
  - IQKeyboardManager：鍵盤處理

## App架構
<p align="center">
<img src="https://github.com/dwhao84/DrinkOrderApp/blob/f190c8aed6f04815e7781bb33e31223f07d38f5d/DrinkOrderApp/Supporting%20Files/Assets.xcassets/README%20Use/Drink%20Order%20App.imageset/Drink%20Order%20App.png" width="800"/>
</p>

## 主要功能

### 1. 使用者認證
- 基於token的登入系統
- 使用者註冊功能
- 安全的訂購系統存取控制

### 2. 主頁（商品目錄）
<p align="center">
<img src="https://github.com/dwhao84/DrinkOrderApp/blob/main/DrinkOrderApp/Supporting%20Files/Assets.xcassets/README%20Use/Home%20Page%20VC.imageset/Home%20Page%20VC.png" width="300"/>
</p>

- 顯示所有可用飲品
- 自訂TableViewCell顯示：
  - 商品圖片
  - 中杯/大杯價格
  - 商品描述
- 飲品搜尋功能
- 下拉重新整理機制
- 動態API資料載入

### 3. 訂單詳情
<p align="center">
<img src="https://github.com/dwhao84/DrinkOrderApp/blob/f190c8aed6f04815e7781bb33e31223f07d38f5d/DrinkOrderApp/Supporting%20Files/Assets.xcassets/README%20Use/Order%20Detail%20VC.imageset/Order%20Detail%20VC.png" width="300"/>
</p>

- 完整的訂單客製化：
  - 尺寸選擇（中杯/大杯）
  - 糖度選擇（7種層級）
  - 冰塊選擇（8種層級）
  - 配料選擇
- 即時價格計算
- 數量調整功能
- 所有欄位的輸入驗證
- 自訂UI元件：
  - 選擇器視圖
  - 自訂文字輸入框
  - 自訂按鈕
- 具有捲動視圖的響應式版面配置

### 4. 訂單管理
<p align="center">
<img src="https://github.com/dwhao84/DrinkOrderApp/blob/f190c8aed6f04815e7781bb33e31223f07d38f5d/DrinkOrderApp/Supporting%20Files/Assets.xcassets/README%20Use/Order%20List%20VC.imageset/Order%20List%20VC.png" width="300"/>
</p>

- 查看所有已下訂單
- 滑動刪除訂單
- 即時總計算：
  - 訂購總杯數
  - 總金額
- 使用Airtable進行訂單資料持久化
- 下拉重新整理功能
- 自訂訂單顯示單元格

### 5. 設定
- 店家聯繫功能：
  - 直接撥號
  - 電子郵件整合
- 法律和資訊區段：
  - 服務條款
  - 商品檢驗報告
  - 隱私權政策
  - 品牌故事
- 專業文件存取

## 所使用技術
- **網路層**：自訂NetworkManager處理API互動
- **UI架構**：使用Auto Layout的程式化UI
- **資料管理**：使用Airtable後端的CRUD操作
- **圖片處理**：使用Kingfisher進行非同步圖片載入
- **使用者體驗**：
  - 表單驗證
  - 載入指示器
  - 錯誤處理
  - 即時回饋

## 相依套件
- **Kingfisher**：高效的圖片載入和快取
- **IQKeyboardManager**：增強的鍵盤互動

## 相關文件
- [飲料訂購 App -1 GET](https://medium.com/彼得潘的-swift-ios-app-開發教室/hw-50-drink-order-app-1-get-6d4f7566c6f5)
- [飲料訂購 App -2 POST](https://medium.com/彼得潘的-swift-ios-app-開發教室/hw-50-drink-order-app-2-post-db7b69faf12d)
