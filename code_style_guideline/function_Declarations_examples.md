# Fonksiyon tanımlamaları ve Fonksiyon çağırmaları

XCode 15 ile birlikte Control+M kısayolu kullnarak kodları reindent yapabiliyoruz. Ama gerçekten anlamda her yerde kullanmak okunabilirliği ve satır sayısı düşürüyor. Bu yüzden bunu birkaç örnekle nasıl kullabileceğimizi açıklamak istedik.

## Xcode Text Editing ayarlarından `Page guide at column` aktif etme 

16inc macbook cihazlarımızdan okunabilirliğin en yüksek seviyede olması için 1 satırdaki karakter sayısı ***105*** olarak belirledik. Bunun kolay uygulanabilir olması için XCode -> Settings -> Text Editing -> Display -> `Page guide at column` 105 değeriyle aktif edilmeli.

![Xcode while editing settings](code_style_guideline/screens/check-spelling-suggestion.png)



## Case 1

Self döndüren bir fonksiyon çağırı yapıyorsak bir sonraki fonksion alt satırda olcak şekilde tanımlanmalı, fonksiyon parametreleri 105 satırı geçmediği süretçe aşağıya alınmamalı.

**Preferred**:
```swift
shipmentDateTitleLabel.TY
            .textColor(.onSurfaceVariant3)
            .font(.medium, size: .body1)
```

**Not Preferred**:
```swift
        shipmentDateTitleLabel.TY
            .textColor(
                .onSurfaceVariant3
            )
            .font(
                .medium,
                size: .body1
            )
```

## Case 2

Closure Brace Spacing 105 satırı geçmemeli ve ya bir sonraki closeudan itibaren alt satırda olmalı

**Preferred**:
```swift
let evenSquares = numbers.filter { $0.isMultiple(of: 2) }.map { $0 * $0 }

let evenSquares = numbers.filter { $0.isMultiple(of: 2) }
                         .map { $0 * $0 }
```

**Not Preferred**:
```swift
let evenSquares = numbers.filter( { $0.isMultiple(of: 2) } ).map( { $0 * $0 } ).compactMap( { $0 * $0 } ).filter( { $0.isMultiple(of: 2) } )

let evenSquares = numbers
  .filter{ $0.isMultiple(of: 2) }
  .map{
    $0 * $0
  }
```

## Case 3


**Preferred**:
```swift
func handleLiveStreamBannerResponse(result: LiveStreamBannerResult, index: Int, needUpdate: Bool) { // 105 satırı geçmiyor

--

    func handleLiveStreamBannerResponse(result: LiveStreamBannerResult, 
                                        index: Int,
                                        needUpdateStickyComponent: Bool) {

--

    func handleLiveStreamBannerResponse(
        result: LiveStreamBannerResult,
        index: Int,
        needUpdateStickyComponent: Bool
    ) {
```

**Not Preferred**:
```swift
    func handleLiveStreamBannerResponse(result: LiveStreamBannerResult, index: Int, needUpdateStickyComponent: Bool) { // 105 satırı geçiyor

    func handleLiveStreamBannerResponse(   // 105 satırı geçmemesine rağmen aşağı atılmış
        result: LiveStreamBannerResult,
        index: Int
    ) {
```

## Case 4


**Preferred**:
```swift
// Eğer 105 satırı geçmiyorsa parametreler aşağı atılmalı
presenter?.presentZoomedImageViewController(imageUrls: images,
                                            currentPage: index,
                                            uxLayout: productDetailResponse?.uxLayout,
                                            contentId: productDetailResponse?.contentId)

Eğer 105'i geçiyorsa parantezden sonra aşağı atılmalı
 presenter?.productRouter.presentZoomedImageViewController(
            imageUrls: images,
            currentPage: index,
            uxLayout: productDetailResponse?.uxLayout,
            contentId: productDetailResponse?.contentId
        )
```

**Not Preferred**:
```swift
        presenter?.productRouter.presentZoomedImageViewController(imageUrls: images, currentPage: index, uxLayout: productDetailResponse?.uxLayout, contentId: productDetailResponse?.contentId)
```

## Case 5


**Preferred**:
```swift
// Eğer 105 satırı geçmiyorsa parametreler aşağı atılmalı
presenter?.presentZoomedImageViewController(imageUrls: images,
                                            currentPage: index,
                                            uxLayout: productDetailResponse?.uxLayout,
                                            contentId: productDetailResponse?.contentId)

Eğer 105'i geçiyorsa parantezden sonra aşağı atılmalı
 presenter?.productRouter.presentZoomedImageViewController(
            imageUrls: images,
            currentPage: index,
            uxLayout: productDetailResponse?.uxLayout,
            contentId: productDetailResponse?.contentId
        )

        let arguments = GRCPriceComparisonSectionFooterPresenterArguments(
            totalPriceTitle: uiModel.store.totalPriceTitle,
            totalPrice: uiModel.store.totalPrice,
            discountedTotalPrice: uiModel.store.discountedTotalPrice,
            productCount: uiModel.store.productCount,
            focusDiscountedTotalPrice: uiModel.store.focusDiscountedTotalPrice.orFalse,
            delegate: self
        )

        let arguments = GRCPricePresenterArguments(totalPriceTitle: uiModel.store.totalPriceTitle,
                                                   totalPrice: uiModel.store.totalPrice,
                                                   delegate: self)
```

**Not Preferred**:
```swift
        presenter?.productRouter.presentZoomedImageViewController(imageUrls: images, currentPage: index, uxLayout: productDetailResponse?.uxLayout, contentId: productDetailResponse?.contentId)

        let arguments = GRCPriceComparisonSectionFooterPresenterArguments(totalPriceTitle: uiModel.store.totalPriceTitle, totalPrice: uiModel.store.totalPrice, discountedTotalPrice: uiModel.store.discountedTotalPrice, productCount: uiModel.store.productCount, focusDiscountedTotalPrice: uiModel.store.focusDiscountedTotalPrice.orFalse, delegate: self)

// Normalde aşağıdaki gibi tanımlamayı kabul ediyoruz fakat 105 satırı geçiyor bu yüzden preferred alanındakini örnek alınız.
        let arguments = GRCPriceComparisonSectionFooterPresenterArguments(totalPriceTitle: uiModel.store.totalPriceTitle, 
                                                                          totalPrice: uiModel.store.totalPrice,
                                                                          discountedTotalPrice: uiModel.store.discountedTotalPrice,
                                                                          productCount: uiModel.store.productCount,
                                                                          focusDiscountedTotalPrice: uiModel.store.focusDiscountedTotalPrice.orFalse,
                                                                          delegate: self)
```

## Case 6
Guard lets

**Preferred**:
```swift
        guard 
            let path = Bundle(for: type(of: self)).path(forResource: name, ofType: kJsonFileType)
        else {
            throw LocalJsonDecoderError.pathNotFound
        }
--

        guard let path = Bundle(for: type(of: self)).path(forResource: name, ofType: kJsonFileType) else {
            throw LocalJsonDecoderError.pathNotFound
        }
```

**Not Preferred**:
```swift
        guard let path = Bundle(for: type(of: self)).path(forResource: name, ofType: kJsonFileType) else { throw LocalJsonDecoderError.pathNotFound }
```

## Case 7
Nested statement
İç içe parametre alan ve 105 satırı geçen tanımlamalarda, fonksiyon parametresindeki datayı dışarıda tanımlamalı ve sonrasında değişken adını verebiliriz.

**Preferred**:
```swift
        let eventData = SearchResultAdsProductImpressionEvent(type: .click,
                                                              arguments: arguments,
                                                              searchTerm: newSearchResponse?.info?.title,
                                                              relativePath: relativePath)
        coreTracker.track(eventData)

--

        let eventData = SearchResultAdsProductImpressionEvent(
            type: .click,
            arguments: arguments,
            searchTerm: newSearchResponse?.info?.title,
            relativePath: relativePath
        )
        coreTracker.track(eventData)
```

**Not Preferred**:
```swift
        coreTracker.track(SearchResultAdsProductImpressionEvent(type: .click, arguments: arguments, searchTerm: newSearchResponse?.info?.title ?? "", relativePath: relativePath))
```
