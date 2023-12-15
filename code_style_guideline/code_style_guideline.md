# Trendyol Swift Style Guide (work-in-progress 🔧️⛏)

## Goals

Our overarching goals are clarity, consistency, readability, simplicity, and brevity, in that order.


Following this style guide should:

* Improves the readability.
* Make code easier to maintain.

Clarity is more important than brevity. Although Swift code can be compact, it is a non-goal to enable the smallest possible code with the fewest characters. Brevity in Swift code, where it occurs, is a side-effect of the strong type system and features that naturally reduce boilerplate. Note that brevity is not a primary goal. Code should be made more concise only if other good code qualities (such as readability, simplicity, and clarity) remain equal or are improved.

If you are having trouble describing your API’s functionality in simple terms, **you may have designed the wrong API.** -Apple

## [**Table of Contents**](#table-of-contents)

1. [Naming](#naming)
1. [Style](#style)
    1. [Functions](#functions)
    1. [Closures](#closures)
    1. [Operators](#operators)
1. [Patterns](#patterns)
1. [File Organization](#file-organization)
1. [Documentation Comments](#documentation)
1. [References](#references)

## [**Naming**](#naming)

* **Static and Class Properties**

  Static and class properties that return instances of the declaring type are not suffixed with the name of the type.

  <details>

  ```swift
  // RIGHT
  public class UIColor {
    public class var red: UIColor {               
      // ...
    }
  }

  // WRONG
  public class UIColor {
    public class var redColor: UIColor {               
      // ...
    }
  }
  ```
  </details>


* **Use PascalCase for type and protocol names, and lowerCamelCase for everything else.** [![SwiftLint: type_name](https://img.shields.io/badge/SwiftLint-type__name-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#type-name)

  This one not using on our project right now. But we should. There is a lot of struct and enum which are starts lowerCamelCase. If we add this thing, it will generate 150  error. FYI, folks.
  <details>

  ```swift
  protocol SpaceThing {
    // ...
  }

  class SpaceFleet: SpaceThing {

    enum Formation {
      // ...
    }

    class Spaceship {
      // ...
    }

    var ships: [Spaceship] = []
    static let worldName: String = "Earth"

    func addShip(_ ship: Spaceship) {
      // ...
    }
  }

  let myFleet = SpaceFleet()
  ```
  </details>


* **Name booleans like `isAddAddressVisible`, `hasChangePermission`, etc.** This makes it clear that they are booleans and not other types.

* **Names should be written with their most general part first and their most specific part last.** The meaning of "most general" depends on context, but should roughly mean "that which most helps you narrow down your search for the item you're looking for." Most importantly, be consistent with how you order the parts of your name.

  <details>

  ```swift
  // WRONG
  let radiusBorder: CGFloat
  let widthBorder: CGFloat
  let bodyRightMargin: CGFloat
  let bodyLeftMargin: CGFloat

  // RIGHT
  let borderRadius: CGFloat
  let borderRight: CGFloat
  let bodyMarginRight: CGFloat
  let bodyMarginLeft: CGFloat
  ```

  </details>


* **Use `enum`s for organizing constants into namespaces.**. Feel free to nest namespaces where it adds clarity.

    <details>

    #### Why `Enum`s?
    Caseless `enum`s work well as namespaces because they cannot be instantiated, which matches their intent.

    ```swift
    enum Environment {
      enum Earth {
        static let gravity = 9.8
      }
      enum Moon {
        static let gravity = 1.6
      }
    }
    ```

    </details>



* **Include a hint about type in a name if it would otherwise be ambiguous.**

  <details>

  ```swift
  // WRONG
  @IBOutlet private weak var icon: UIImageView!
  @IBOutlet private weak var rightArrow: UIImageView!
  @IBOutlet private weak var bottomLine: UIView!

  let cancel: UIButton

  // RIGHT
  @IBOutlet private weak var iconImageView: UIImageView!
  @IBOutlet private weak var rightArrowImageView: UIImageView!
  @IBOutlet private weak var bottomLineView: UIView!
  ```

  </details>


* **Event-handling functions should be named like past-tense sentences.** The subject can be omitted if it's not needed for clarity.

  <details>

  ```swift
  // WRONG
  class ExperiencesViewController {
    private func handleBookButtonTap() {
      // ...
    }

    private func tappedCampaign() {
      // ...
    }

    private func modelChanged() {
      // ...
    }
  }

  // RIGHT
  class ExperiencesViewController {
    private func campaignViewTapped() {
      // ...
    }
  }
  ```

  </details>


* **Avoid Objective-C-style acronym prefixes.** This is no longer needed to avoid naming conflicts in Swift.

  <details>

  ```swift
  // WRONG
  class AIRAccount {
    // ...
  }

  // RIGHT
  class Account {
    // ...
  }
  ```

  </details>


#### <a href="#top">**⬆ Back to top**</a>

## [**Style**](#style)

* **Add localization parameters to domain based. When adding string key use below logic. And fileName must be end of the extension.**

  <details>

  ```
  <ScreenName>.<ScreenComponent>.<ComponentPart>.<Type>
  ```

  </details>

* **Add accessibilityIdentifiers as Localizable.**

* **Delete all TODO comments.**

* **Use fetch prefix instead of get for interactor functions.**

* **Don't use get prefix on function or variable.**

* **Remove line spaces for class's first and last lines.**

* **Convert cells to viper module. at least move logic into presenter (Who touches it changes it)**

* **On UnitTest every `it` method should restore changed data if test case makes changes on any data.**

* **Mark each extension. Also use `MARK: -` over `MARK:` it will add a seperator on each extension.**

  <details>

    ```swift
    // MARK: - UrlOpenable
    public extension UrlOpenable {
      func canOpenUrl(_ url: URL) -> Bool { ... }
      func openUrl(_ url: URL) { ... }
    }
    ```

  </details>



* **Line length rule. Some view or requests are too long. We can move some parameters to new line.**

  <details>

  ```
  line_length:
    warning: 140
    error: 160
  ```

  </details>


* **Don't include types where they can be easily inferred.**

  <details>

  ```swift
  // WRONG
  let host: Host = Host()

  // RIGHT
  let host = Host()
  ```

  ```swift
  enum Direction {
    case left
    case right
  }

  func someDirection() -> Direction {
    // WRONG
    return Direction.left

    // RIGHT
    return .left
  }
  ```

  </details>


* **Don't use `self` unless it's necessary for disambiguation or required by the language.** [![SwiftFormat: redundantSelf](https://img.shields.io/badge/SwiftFormat-redundantSelf-7B0051.svg)](https://github.com/nicklockwood/SwiftFormat/blob/master/Rules.md#redundantSelf)

  <details>

  ```swift
  final class Listing {

    init(capacity: Int, allowsPets: Bool) {
      // WRONG
      self.capacity = capacity
      self.isFamilyFriendly = !allowsPets // `self.` not required here

      // RIGHT
      self.capacity = capacity
      isFamilyFriendly = !allowsPets
    }

    private let isFamilyFriendly: Bool
    private var capacity: Int

    private func increaseCapacity(by amount: Int) {
      // WRONG
      self.capacity += amount

      // RIGHT
      capacity += amount

      // WRONG
      self.save()

      // RIGHT
      save()
    }
  }
  ```

  </details>


* **Name members of tuples for extra clarity.** Rule of thumb: if you've got more than 3 fields, you should probably be using a struct.

  <details>

  ```swift
  // WRONG
  func whatever() -> (Int, Int) {
    return (4, 4)
  }
  let thing = whatever()
  print(thing.0)

  // RIGHT
  func whatever() -> (x: Int, y: Int) {
    return (x: 4, y: 4)
  }

  // THIS IS ALSO OKAY
  func whatever2() -> (x: Int, y: Int) {
    let x = 4
    let y = 4
    return (x, y)
  }

  let coord = whatever()
  coord.x
  coord.y
  ```

  </details>


* **Place the colon immediately after an identifier, followed by a space.** [![SwiftLint: colon](https://img.shields.io/badge/SwiftLint-colon-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#colon)

  <details>

  ```swift
  // WRONG
  var something : Double = 0

  // RIGHT
  var something: Double = 0
  ```

  ```swift
  // WRONG
  class MyClass : SuperClass {
    // ...
  }

  // RIGHT
  class MyClass: SuperClass {
    // ...
  }
  ```

  ```swift
  // WRONG
  var dict = [KeyType:ValueType]()
  var dict = [KeyType : ValueType]()

  // RIGHT
  var dict = [KeyType: ValueType]()
  ```

  </details>


* **Place a space on either side of a return arrow for readability.** [![SwiftLint: return_arrow_whitespace](https://img.shields.io/badge/SwiftLint-return__arrow__whitespace-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#returning-whitespace)

  <details>

  ```swift
  // WRONG
  func doSomething()->String {
    // ...
  }

  // RIGHT
  func doSomething() -> String {
    // ...
  }
  ```

  ```swift
  // WRONG
  func doSomething(completion: ()->Void) {
    // ...
  }

  // RIGHT
  func doSomething(completion: () -> Void) {
    // ...
  }
  ```

  </details>


* **Omit unnecessary parentheses.** [![SwiftFormat: redundantParens](https://img.shields.io/badge/SwiftFormat-redundantParens-7B0051.svg)](https://github.com/nicklockwood/SwiftFormat/blob/master/Rules.md#redundantParens)

  <details>

  ```swift
  // WRONG
  if (userCount > 0) { ... }
  switch (someValue) { ... }
  let evens = userCounts.filter { (number) in number % 2 == 0 }
  let squares = userCounts.map() { $0 * $0 }

  // RIGHT
  if userCount > 0 { ... }
  switch someValue { ... }
  let evens = userCounts.filter { number in number % 2 == 0 }
  let squares = userCounts.map { $0 * $0 }
  ```

  </details>


* **Omit enum associated values from case statements when all arguments are unlabeled.** [![SwiftLint: empty_enum_arguments](https://img.shields.io/badge/SwiftLint-empty__enum__arguments-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#empty-enum-arguments)

  <details>

  ```swift
  // WRONG
  if case .done(_) = result { ... }

  switch animal {
  case .dog(_, _, _):
    ...
  }

  // RIGHT
  if case .done = result { ... }

  switch animal {
  case .dog:
    ...
  }
  ```

  </details>


* **Use constructors instead of Make() functions for NSRange and others.** [![SwiftLint: legacy_constructor](https://img.shields.io/badge/SwiftLint-legacy__constructor-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#legacy-constructor)

  <details>

  ```swift
  // WRONG
  let range = NSMakeRange(10, 5)

  // RIGHT
  let range = NSRange(location: 10, length: 5)
  ```

  </details>


## [**Functions**](#functions)

* **Omit unnecessary parameters.**

  <details>

  ```swift
  // WRONG
  @IBAction func deleteAddressClicked(_ sender: UIButton) {
      presenter?.notifyDeleteAddressClicked()
  }

  // RIGHT
  @IBAction func deleteAddressClicked() {
    presenter?.notifyDeleteAddressClicked()
  }
  ```

  </details>



* **Omit `Void` return types from function definitions.** [![SwiftLint: redundant_void_return](https://img.shields.io/badge/SwiftLint-redundant__void__return-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#redundant-void-return)

  <details>

  ```swift
  // WRONG
  func doSomething() -> Void {
    ...
  }

  // RIGHT
  func doSomething() {
    ...
  }
  ```

  </details>


* **Mostly don't use ommited parameters on function. If parameter name contains on method name at it is clear to recognize. You can use.**

  <details>

  ```swift
  // WRONG
  func addImage(_ imageUrl: String) {
    ...
  }

  func addImage(image: UIImage) {
    ...
  }

  // RIGHT
  func addImage(_ image: UIImage) {
    ...
  }

  // RIGHT
  func addImage(with image: UIImage) {
    ...
  }
  ```

  </details>

* **Long function invocations should also break on each argument. Put the closing parenthesis on the last parameter of the invocation..**

  <details>

  ```swift
  // WRONG
  universe.generateStars(at: location, count: 5, color: starColor, withAverageDistance: 4)

  // WRONG
  universe.generateStars(
    at: location,
    count: 5,
    color: starColor,
    withAverageDistance: 4
  )

  // WRONG
  universe.generateStars(
    at: location,
    count: 5,
    color: starColor,
    withAverageDistance: 4)

  // WRONG
  universe.generate(
    5,
    .stars,
    at: location)

  // RIGHT
  universe.generateStars(at: location,
                         count: 5,
                         color: starColor,
                         withAverageDistance: 4)

  // RIGHT
  universe.generate(5,
                    .stars,
                    at: location)

  ```

  </details>

## [**Closures**](#closures)

* **Favor `Void` return types over `()` in closure declarations.** If you must specify a `Void` return type in a function declaration, use `Void` rather than `()` to improve readability. [![SwiftLint: void_return](https://img.shields.io/badge/SwiftLint-void__return-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#void-return)

  <details>

  ```swift
  // WRONG
  func method(completion: () -> ()) {
    ...
  }

  // RIGHT
  func method(completion: () -> Void) {
    ...
  }
  ```

  </details>


* **Name unused closure parameters as underscores (`_`).** [![SwiftLint: unused_closure_parameter](https://img.shields.io/badge/SwiftLint-unused__closure__parameter-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#unused-closure-parameter)

    <details>

    #### Why?
    Naming unused closure parameters as underscores reduces the cognitive overhead required to read
    closures by making it obvious which parameters are used and which are unused.

    ```swift
    // WRONG
    someAsyncThing() { argument1, argument2, argument3 in
      print(argument3)
    }

    // RIGHT
    someAsyncThing() { _, _, argument3 in
      print(argument3)
    }
    ```

    </details>


* **Single-line closures should have a space inside each brace. Also if you can do it on one line, do it. When you doing that remember readability is our most important thing.** [![SwiftLint: closure_spacing](https://img.shields.io/badge/SwiftLint-closure__spacing-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#closure-spacing)

  <details>

  ```swift
  // WRONG
  let evenSquares = numbers.filter {$0 % 2 == 0}.map {  $0 * $0  }

  // RIGHT
  let evenSquares = numbers.filter { $0 % 2 == 0 }.map { $0 * $0 }
  ```

  </details>


## [**Operators**](#operators)

* **Infix operators should have a single space on either side.** Prefer parenthesis to visually group statements with many operators rather than varying widths of whitespace. This rule does not apply to range operators (e.g. `1...3`) and postfix or prefix operators (e.g. `guest?` or `-1`). [![SwiftLint: operator_usage_whitespace](https://img.shields.io/badge/SwiftLint-operator__usage__whitespace-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#operator-usage-whitespace)

  <details>

  ```swift
  // WRONG
  let capacity = 1+2
  let capacity = currentCapacity   ?? 0
  let mask = (UIAccessibilityTraitButton|UIAccessibilityTraitSelected)
  let capacity=newCapacity
  let latitude = region.center.latitude - region.span.latitudeDelta/2.0

  // RIGHT
  let capacity = 1 + 2
  let capacity = currentCapacity ?? 0
  let mask = (UIAccessibilityTraitButton | UIAccessibilityTraitSelected)
  let capacity = newCapacity
  let latitude = region.center.latitude - (region.span.latitudeDelta / 2.0)
  ```

  </details>

#### <a href="#top">**⬆ Back to top**</a>

## [**Patterns**](#patterns)

* **Don't use chain delegate if you are not make any changes on every scope.**

  <details>

    ```swift
    extension ReviewCell: ReviewContainerViewDelegate {
      func photosTapped(imageUrls: [String], currentImageIndex: Int) {
          delegate?.photosTapped(imageUrls: imageUrls, currentImageIndex:   currentImageIndex)
      }
    }

    extension ReviewContainerViewPresenter: ReviewContainerViewPresenterInterface {
      func reviewPhotoTapped(imageUrls: [String], currentImageIndex: Int) {
          delegate?.photosTapped(imageUrls: imageUrls, currentImageIndex: currentImageIndex)
      }
    }
    ```
    </details>


* **Don't use same delegate name when you use chain delegate. A unique method name helps engineers more quickly determine which modules depends on.**

* **Prefer initializing properties at `init` time whenever possible, rather than using implicitly unwrapped optionals.** [![SwiftLint: implicitly_unwrapped_optional](https://img.shields.io/badge/SwiftLint-implicitly__unwrapped__optional-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#implicitly-unwrapped-optional)

  <details>

  ```swift
  // WRONG
  class MyClass: NSObject {

    init() {
      super.init()
      someValue = 5
    }

    var someValue: Int!
  }

  // RIGHT
  class MyClass: NSObject {

    init() {
      someValue = 0
      super.init()
    }

    var someValue: Int
  }
  ```

</details>

* **Prefer using `guard` at the beginning of a scope.**

  <details>

    #### Why?
    It's easier to reason about a block of code when all `guard` statements are grouped together at the top rather than intermixed with business logic.
    </details>


* **Access control should be at the strictest level possible.**


* **Prefer immutable values whenever possible.** Use `map` and `compactMap` instead of appending to a new collection. Use `filter` instead of removing elements from a mutable collection.

  <details>

  #### Why?
  Mutable variables increase complexity, so try to keep them in as narrow a scope as possible.

  ```swift
  // WRONG
  var results = [SomeType]()
  for element in input {
    let result = transform(element)
    results.append(result)
  }

  // RIGHT
  let results = input.map { transform($0) }
  ```

  ```swift
  // WRONG
  var results = [SomeType]()
  for element in input {
    if let result = transformThatReturnsAnOptional(element) {
      results.append(result)
    }
  }

  // RIGHT
  let results = input.compactMap { transformThatReturnsAnOptional($0) }
  ```

  </details>


* **Default classes to `final`.**

    <details>

    #### Why?
    If a class needs to be overridden, the author should opt into that functionality by omitting the `final` keyword.

    ```swift
    // WRONG
    class SettingsRepository {
      // ...
    }

    // RIGHT
    final class SettingsRepository {
      // ...
    }
    ```

  </details>


* **Dont use the `default` case when `switch`ing over an enum.**

    <details>

    #### Why?
    Enumerating every case requires developers and reviewers have to consider the correctness of every switch statement when new cases are added.

    ```swift
    // WRONG
    switch anEnum {
    case .a:
      // Do something
    default:
      // Do something else.
    }

    // RIGHT
    switch anEnum {
    case .a:
      // Do something
    case .b, .c:
      // Do something else.
    }
    ```

    Also if you can use ternary if use it on here.

    ```swift
    let value = anEnum == .a ? XXX : xxx
    ```    

  </details>



* **Check for nil rather than using optional binding if you don't need to use the value.** [![SwiftLint: unused_optional_binding](https://img.shields.io/badge/SwiftLint-unused_optional_binding-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#unused-optional-binding)

    <details>

    #### Why?
    Checking for nil makes it immediately clear what the intent of the statement is. Optional binding is less explicit.

    ```swift
    var thing: Thing?

    // WRONG
    if let _ = thing {
      doThing()
    }

    // RIGHT
    if thing != nil {
      doThing()
    }
    ```

    </details>


* **Seperation of Concerns. Do not add everything to _BaseProtocolInterface_.**

    <details>

    #### Why?
    Add protocols with specific needs. With that, we can easily identify that interface what it can do? On Trendyol we are adding all common functions to Base...Interface. For example on our project most of ViewInterface can can openUrl but not all of them needs that ability.

    ```swift
    public protocol UrlOpenable {
      func canOpenUrl(_ url: URL) -> Bool
      func openUrl(_ url: URL)
    }

    public extension UrlOpenable {
      func canOpenUrl(_ url: URL) -> Bool { ... }
      func openUrl(_ url: URL) { ... }
    }
    ```

    ```swift
    public protocol NavigationBarConfigurable {
      func prepareBackButton(tintColor: Color)
      func prepareCrossButton(tintColor: Color, target: Any?, selector: Selector)
      func setNavigationBarHidden(_ shouldHide: Bool)
    }

    public extension NavigationBarConfigurable {
      func prepareBackButton(tintColor: Color) { ... }
      func prepareCrossButton(tintColor: Color, target: Any?, selector: Selector) { ... }
      func setNavigationBarHidden(_ shouldHide: Bool) { ... }
    }
    ```

    ```swift
    protocol ProductDetailViewInterface: ViewInterface, UrlOpenable, NavigationBarConfigurable { .... }
    ```

    </details>


* **Use ternary if only setting value or calling function.**

    <details>

    #### Why?
    Swift build times are slow mostly because of expensive type checking. By default Xcode doesn't show code that's slow to compile. You can instruct it to show slowly compiling functions and expressions, though by adding:

    -Xfrontend -warn-long-function-bodies=100 (100 means 100ms here, you should experiment with this value depending on your computer speed and project)
    -Xfrontend -warn-long-expression-type-checking=100

    ```swift
    // Build time: 239.0ms
    let labelNames = type == 0 ? (1...5).map{type0ToString($0)} : (0...2).map{type1ToString($0)}

    // Build time: 16.9ms
    var labelNames: [String]
    if type == 0 {
        labelNames = (1...5).map{type0ToString($0)}
    } else {
        labelNames = (0...2).map{type1ToString($0)}
    }
    ```

    ```swift
    // Build time: 1034.0ms
    let moveValue = willShowKeyboard ? -(endKeyboardFrame.height/Constant.dividerNumberForKeyboardHeight + (view?.doneButtonHeight ?? 0)) : 0

    // Build time: 103.0ms
    var moveValue: CGFloat = 0.0
      if willShowKeyboard {
          moveValue = -(endKeyboardFrame.height/Constant.dividerNumberForKeyboardHeight)
          if let doneButtonHeight = view?.doneButtonHeight {
              moveValue += doneButtonHeight
          }
      }
    ```

    </details>


## [**File Organization**](#file-organization)

* **Alphabetize module imports at the top of the file a single line below the last line of the header comments. Do not add additional line breaks between import statements.** [![SwiftFormat: sortedImports](https://img.shields.io/badge/SwiftFormat-sortedImports-7B0051.svg)](https://github.com/nicklockwood/SwiftFormat/blob/master/Rules.md#sortedImports)

    <details>

    #### Why?
    A standard organization method helps engineers more quickly determine which modules a file depends on. Also if some module has another module do not import it. Ex: BottomPopup has a UIKit

    ```swift
      // WRONG
      import SDWebImage
      import UIKit
      import BottomPopup

      //RIGHT

      import BottomPopup
      import SDWebImage
    ```

    </details>


* **On group name don't add full name to subgroups. Don't use Module suffix if it already inside on Module.**

    <details>

    #### Why?
    A standard organization method helps engineers more quickly determine which modules a file depends on.

    ```swift
    // WRONG
    Modules > Account > BrandFollowingModule > Views > BrandFollowingTableViewHeader
    Modules > Account > AccountModule > AccountListFooterBanner
    Modules > Account > AccountSettingsModule

    //RIGHT
    Modules > Account > BrandFollowing > Views > TableViewHeader
    Modules > Account > Listing > FooterBanner
    Modules > Account > Settings
    ```

    </details>


## [**Documentation Comments**](#documentation)


* **Documentation comments are written using the format where each line is preceded by a triple slash (///). Beacuse if you use that it will see on autocomplete dropdown view. Javadoc-style block comments (/* * ... **/) are not permitted.**

## [**References**](#references)

* [The Google API Design Guidelines](https://google.github.io/swift/#naming)
* [The Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
* [The Airbnb API Design Guidelines](https://github.com/airbnb/swift)
* [The Raywenderlich API Design Guidelines](https://github.com/raywenderlich/swift-style-guide)


#### <a href="#top">**⬆ Back to top**</a>
