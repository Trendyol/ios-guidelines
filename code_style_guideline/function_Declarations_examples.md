
# Function Declarations and Function Calls

We can reindent the code using the reference of code style guidelines, we'd like to explain how to use it with a few examples.

## Activating 'Page guide at column' in Xcode Text Editing Settings

To achieve the highest readability level on our 16-inch MacBook devices, we set the character count per line to ***105***. For easy implementation, activate `Page guide at column` in Xcode -> Settings -> Text Editing -> Display with a value of 105.


![Xcode text editing display column](screens/text-editing-display-column.png)

Column Character Limit Example

*You can look at the divided area*

![Xcode text editing display column](screens/example-of-column-character-limit.png)

## Case 1
Use FeatureFlag property wrapper for your configs since traditional config initialization exceeds 105 limit.

**Preferred**:
```swift
@FeatureFlag(key: "myConfig", defaultValue: 30)
private var myConfig: Int
```

**Not Preferred**:
```swift
init(myConfig: Int = TYConfigs.MyConfig().value,
     ...
) {
    self.collectableCouponVisibilityLimit = collectableCouponVisibilityLimit
}
```

## Case 2

When calling a self-returning function, the next function should be defined on the next line, and function parameters should not be moved to the next line unless they exceed 105 characters.

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

## Case 3

Closure brace spacing should not exceed 105 characters or should be placed on the next line after the closing brace.

**Preferred**:
```swift
let evenSquares = numbers
    .filter { $0.isMultiple(of: 2) }
    .map { $0 * $0 }
```

**Not Preferred**:
```swift
let evenSquares = numbers.filter( { $0.isMultiple(of: 2) } ).map( { $0 * $0 } ).compactMap( { $0 * $0 } ).filter( { $0.isMultiple(of: 2) } )

let evenSquares = numbers
  .filter { $0.isMultiple(of: 2) }
  .map {
    $0 * $0
  }
```

## Case 4

**Preferred**:
```swift
func handleLiveStreamBannerResponse(result: LiveStreamBannerResult, index: Int, needUpdate: Bool) { // Does not exceed 105 characters

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
func handleLiveStreamBannerResponse(result: LiveStreamBannerResult, index: Int, needUpdateStickyComponent: Bool) { // Exceeds 105 characters
```

## Case 5

**Preferred**:
```swift
// Parameters should be moved to the next line if they do not exceed 105 characters
presenter?.presentZoomedImageViewController(imageUrls: images,
                                            currentPage: index,
                                            uxLayout: productDetailResponse?.uxLayout,
                                            contentId: productDetailResponse?.contentId)

If it exceeds 105 characters, move to the next line after the parentheses
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

## Case 6

**Preferred**:
```swift
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

// Although the following definition is generally acceptable, it exceeds 105 characters, so use the example in the preferred section.
let arguments = GRCPriceComparisonSectionFooterPresenterArguments(totalPriceTitle: uiModel.store.totalPriceTitle, 
                                                                  totalPrice: uiModel.store.totalPrice,
                                                                  discountedTotalPrice: uiModel.store.discountedTotalPrice,
                                                                  productCount: uiModel.store.productCount,
                                                                  focusDiscountedTotalPrice: uiModel.store.focusDiscountedTotalPrice.orFalse,
                                                                  delegate: self)
```

## Case 7
Guard Lets

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

## Case 8
Nested Statement
For nested parameterized functions that exceed 105 characters, the data in the function parameter should be defined outside, and then the variable name can be used.

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
