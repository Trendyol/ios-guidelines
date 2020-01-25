# Trendyol Swift Style Guide (work-in-progress 🔧️⛏)

## Goals

Our overarching goals are clarity, consistency, readability, simplicity, and brevity, in that order.


Following this style guide should:

* Improves the readability.
* Make code easier to maintain.

Clarity is more important than brevity. Although Swift code can be compact, it is a non-goal to enable the smallest possible code with the fewest characters. Brevity in Swift code, where it occurs, is a side-effect of the strong type system and features that naturally reduce boilerplate. Note that brevity is not a primary goal. Code should be made more concise only if other good code qualities (such as readability, simplicity, and clarity) remain equal or are improved.

If you are having trouble describing your API’s functionality in simple terms, **you may have designed the wrong API.** -Apple

## Table of Contents

1. [Naming](#naming)
1. [Style](#style)
    1. [Functions](#functions)
    1. [Closures](#closures)
    1. [Operators](#operators)
1. [Patterns](#patterns)
1. [File Organization](#file-organization)
1. [Documentation Comments](#documentation)
1. [References](#references)

## Naming

* <a id='static-class-properties'></a>(<a href='#static-class-properties'>link</a>) **Static and Class Properties**

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


* <a id='use-camel-case'></a>(<a href='#use-camel-case'>link</a>) **Use PascalCase for type and protocol names, and lowerCamelCase for everything else.** [![SwiftLint: type_name](https://img.shields.io/badge/SwiftLint-type__name-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#type-name)

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


* <a id='bool-names'></a>(<a href='#bool-names'>link</a>) **Name booleans like `isAddAddressVisible`, `hasChangePermission`, etc.** This makes it clear that they are booleans and not other types.

* <a id='general-part-first'></a>(<a href='#general-part-first'>link</a>) **Names should be written with their most general part first and their most specific part last.** The meaning of "most general" depends on context, but should roughly mean "that which most helps you narrow down your search for the item you're looking for." Most importantly, be consistent with how you order the parts of your name.

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


* <a id='namespace-using-enums'></a>(<a href='#namespace-using-enums'>link</a>) **Use `enum`s for organizing `public` or `internal` constants and functions into namespaces.** Avoid creating non-namespaced global constants and functions. Feel free to nest namespaces where it adds clarity.

    <details>

    #### Why?
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



* <a id='hint-at-types'></a>(<a href='#hint-at-types'>link</a>) **Include a hint about type in a name if it would otherwise be ambiguous.**

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


* <a id='past-tense-events'></a>(<a href='#past-tense-events'>link</a>) **Event-handling functions should be named like past-tense sentences.** The subject can be omitted if it's not needed for clarity.

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
    private func didTapBookButton() {
      // ...
    }

    private func didTapCampaignView() {
      // ...
    }

    private func campaignViewTapped() {
      // ...
    }

    private func modelDidChange() {
      // ...
    }
  }
  ```

  </details>


* <a id='avoid-class-prefixes'></a>(<a href='#avoid-class-prefixes'>link</a>) **Avoid Objective-C-style acronym prefixes.** This is no longer needed to avoid naming conflicts in Swift.

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


**[⬆ back to top](#table-of-contents)**

## Style

* <a id='allTodos'></a>(<a href='#alTodos'>link</a>) **Delete all TODO comments.**

* <a id='fetchPrefix'></a>(<a href='#fetchPrefix'>link</a>) **Use fetch prefix instead of get for interactor functions.**

* <a id='useComputedVariable'></a>(<a href='#useComputedVariable'>link</a>) **For casting values use computed variables inside extensions, warn anyone if they use function instead of computed variable unnecessarily.**

* <a id='useComputedVariable'></a>(<a href='#useComputedVariable'>link</a>) **Remove line spaces for class's first and last lines.**

* <a id='cellToViper'></a>(<a href='#cellToViper'>link</a>) **Convert cells to viper module. at least move logic into presenter (Who touches it changes it)**

* <a id='onUnitTest'></a>(<a href='#onUnitTest'>link</a>) **On UnitTest every `it` method should restore changed data if test case makes changes on any data.**

* <a id='markEachExtension'></a>(<a href='#markEachExtension'>link</a>) **Mark each extension. Also use `MARK: -` over `MARK:` it will add a seperator on each extension.**

  <details>

    ```swift
    // MARK: - UrlOpenable
    public extension UrlOpenable {
      func canOpenUrl(_ url: URL) -> Bool { ... }
      func openUrl(_ url: URL) { ... }
    }
    ```

  </details>



* <a id='line_length'></a>(<a href='#line_length'>link</a>) **Line length rule. Some view or requests are too long. We can move some parameters to new line.**

  <details>

  ```
  line_length:
    warning: 140
    error: 160
  ```

  </details>


* <a id='use-implicit-types'></a>(<a href='#use-implicit-types'>link</a>) **Don't include types where they can be easily inferred.**

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


* <a id='omit-self'></a>(<a href='#omit-self'>link</a>) **Don't use `self` unless it's necessary for disambiguation or required by the language.** [![SwiftFormat: redundantSelf](https://img.shields.io/badge/SwiftFormat-redundantSelf-7B0051.svg)](https://github.com/nicklockwood/SwiftFormat/blob/master/Rules.md#redundantSelf)

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


* <a id='name-tuple-elements'></a>(<a href='#name-tuple-elements'>link</a>) **Name members of tuples for extra clarity.** Rule of thumb: if you've got more than 3 fields, you should probably be using a struct.

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


* <a id='colon-spacing'></a>(<a href='#colon-spacing'>link</a>) **Place the colon immediately after an identifier, followed by a space.** [![SwiftLint: colon](https://img.shields.io/badge/SwiftLint-colon-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#colon)

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


* <a id='return-arrow-spacing'></a>(<a href='#return-arrow-spacing'>link</a>) **Place a space on either side of a return arrow for readability.** [![SwiftLint: return_arrow_whitespace](https://img.shields.io/badge/SwiftLint-return__arrow__whitespace-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#returning-whitespace)

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


* <a id='unnecessary-parens'></a>(<a href='#unnecessary-parens'>link</a>) **Omit unnecessary parentheses.** [![SwiftFormat: redundantParens](https://img.shields.io/badge/SwiftFormat-redundantParens-7B0051.svg)](https://github.com/nicklockwood/SwiftFormat/blob/master/Rules.md#redundantParens)

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


* <a id='unnecessary-enum-arguments'></a> (<a href='#unnecessary-enum-arguments'>link</a>) **Omit enum associated values from case statements when all arguments are unlabeled.** [![SwiftLint: empty_enum_arguments](https://img.shields.io/badge/SwiftLint-empty__enum__arguments-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#empty-enum-arguments)

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


* <a id='favor-constructors'></a>(<a href='#favor-constructors'>link</a>) **Use constructors instead of Make() functions for NSRange and others.** [![SwiftLint: legacy_constructor](https://img.shields.io/badge/SwiftLint-legacy__constructor-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#legacy-constructor)

  <details>

  ```swift
  // WRONG
  let range = NSMakeRange(10, 5)

  // RIGHT
  let range = NSRange(location: 10, length: 5)
  ```

  </details>


### Casting

* <a id='casting-params'></a>(<a href='#casting-params'>link</a>) **Don't cast parameters with default constructors. Use extension for readability. I think we can use intValue over toInt**

  <details>

  ```swift
  // WRONG
  func userIdReceived(userId: String) {
      interactor?.userIdReceived(Int(userId))
  }

  // RIGHT
  func userIdReceived(userId: String) {
      interactor?.userIdReceived(userId.intValue)
  }
  ```

  </details>

### Functions

* <a id='unnecessary-params'></a>(<a href='#unnecessary-params'>link</a>) **Omit unnecessary parameters.**

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



* <a id='omit-function-void-return'></a>(<a href='#omit-function-void-return'>link</a>) **Omit `Void` return types from function definitions.** [![SwiftLint: redundant_void_return](https://img.shields.io/badge/SwiftLint-redundant__void__return-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#redundant-void-return)

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


* <a id='omitted-function-params'></a>(<a href='#omit-function-params'>link</a>) **Dont use ommited parameters on function**

  <details>

  ```swift
  // WRONG
  func doSomething(_ awesomeStuff: String) {
    ...
  }

  // RIGHT
  func doSomething(awesomeStuff: String) {
    ...
  }

  // RIGHT
  func doSomething(with something: String) {
    ...
  }
  ```

  </details>


### Closures

* <a id='favor-void-closure-return'></a>(<a href='#favor-void-closure-return'>link</a>) **Favor `Void` return types over `()` in closure declarations.** If you must specify a `Void` return type in a function declaration, use `Void` rather than `()` to improve readability. [![SwiftLint: void_return](https://img.shields.io/badge/SwiftLint-void__return-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#void-return)

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


* <a id='unused-closure-parameter-naming'></a>(<a href='#unused-closure-parameter-naming'>link</a>) **Name unused closure parameters as underscores (`_`).** [![SwiftLint: unused_closure_parameter](https://img.shields.io/badge/SwiftLint-unused__closure__parameter-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#unused-closure-parameter)

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


* <a id='closure-brace-spacing'></a>(<a href='#closure-brace-spacing'>link</a>) **Single-line closures should have a space inside each brace. Also if you can do it on one line, do it. When you doing that remember readability is our most important thing.** [![SwiftLint: closure_spacing](https://img.shields.io/badge/SwiftLint-closure__spacing-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#closure-spacing)

  <details>

  ```swift
  // WRONG
  let evenSquares = numbers.filter {$0 % 2 == 0}.map {  $0 * $0  }

  // RIGHT
  let evenSquares = numbers.filter { $0 % 2 == 0 }.map { $0 * $0 }
  ```

  </details>

### Operators

* <a id='infix-operator-spacing'></a>(<a href='#infix-operator-spacing'>link</a>) **Infix operators should have a single space on either side.** Prefer parenthesis to visually group statements with many operators rather than varying widths of whitespace. This rule does not apply to range operators (e.g. `1...3`) and postfix or prefix operators (e.g. `guest?` or `-1`). [![SwiftLint: operator_usage_whitespace](https://img.shields.io/badge/SwiftLint-operator__usage__whitespace-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#operator-usage-whitespace)

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

**[⬆ back to top](#table-of-contents)**

## Patterns

* <a id='implicitly-unwrapped-optionals'></a>(<a href='#implicitly-unwrapped-optionals'>link</a>) **Prefer initializing properties at `init` time whenever possible, rather than using implicitly unwrapped optionals.**  A notable exception is UIViewController's `view` property. [![SwiftLint: implicitly_unwrapped_optional](https://img.shields.io/badge/SwiftLint-implicitly__unwrapped__optional-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#implicitly-unwrapped-optional)

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

* <a id='guards-at-top'></a>(<a href='#guards-at-top'>link</a>) **Prefer using `guard` at the beginning of a scope.**

  <details>

    #### Why?
    It's easier to reason about a block of code when all `guard` statements are grouped together at the top rather than intermixed with business logic.
    </details>


* <a id='limit-access-control'></a>(<a href='#limit-access-control'>link</a>) **Access control should be at the strictest level possible.**


* <a id='prefer-immutable-values'></a>(<a href='#prefer-immutable-values'>link</a>) **Prefer immutable values whenever possible.** Use `map` and `compactMap` instead of appending to a new collection. Use `filter` instead of removing elements from a mutable collection.

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


* <a id='final-classes-by-default'></a>(<a href='#final-classes-by-default'>link</a>) **Default classes to `final`.**

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


* <a id='switch-never-default'></a>(<a href='#switch-never-default'>link</a>) **Dont use the `default` case when `switch`ing over an enum.**

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



  * <a id='optional-nil-check'></a>(<a href='#optional-nil-check'>link</a>) **Check for nil rather than using optional binding if you don't need to use the value.** [![SwiftLint: unused_optional_binding](https://img.shields.io/badge/SwiftLint-unused_optional_binding-007A87.svg)](https://github.com/realm/SwiftLint/blob/master/Rules.md#unused-optional-binding)

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


* <a id='protocol-inheritance'></a>(<a href='#protocol-inheritance'>link</a>) **Seperation of Concerns. Do not add everything to _BaseProtocolInterface_.**

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

## File Organization

* <a id='alphabetize-imports'></a>(<a href='#alphabetize-imports'>link</a>) **Alphabetize module imports at the top of the file a single line below the last line of the header comments. Do not add additional line breaks between import statements.** [![SwiftFormat: sortedImports](https://img.shields.io/badge/SwiftFormat-sortedImports-7B0051.svg)](https://github.com/nicklockwood/SwiftFormat/blob/master/Rules.md#sortedImports)

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

## Documentation Comments

  * <a id='documentation'></a>(<a href='#documentation'>link</a>) **Documentation comments are written using the format where each line is preceded by a triple slash (///). Beacuse if you use that it will see on autocomplete dropdown view. Javadoc-style block comments (/* * ... **/) are not permitted.**

## References

* [The Google API Design Guidelines](https://google.github.io/swift/#naming)
* [The Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
* [The Airbnb API Design Guidelines](https://github.com/airbnb/swift)
* [The Raywenderlich API Design Guidelines](https://github.com/raywenderlich/swift-style-guide)

**[⬆ back to top](#table-of-contents)**
