# Trendyol iOS Style Guide

Tailored exclusively for the Trendyol app, this Swift Style Guide prioritizes code readability within Trendyol's unique development environment. Crafted to ensure consistency across diverse contributors, the guide serves as a dedicated resource for maintaining a cohesive and clear codebase.

Our overarching goals are clarity, consistency and brevity, in that order.

## Table of Contents

* [Using SwiftLint](#using-swiftlint)
* [Naming](#naming)
  * [Variables](#variables)
  * [Methods](#methods)
  * [Delegates](#delegates)
  * [Interface](#interface)
  * [Generics](#generics)
  * [Loops](#loops)
  * [Self and self usage](#self-and-self-usage)
  * [Class and Structs](#class-and-structs)
  * [Attributes](#attributes) 
  * [Language](#language) 
  * [String Concatenation](#string-concatenation)
* [File Organization](#file-organization)
* [Code Organization](#code-organization)
  * [Protocol Conformance](#protocol-conformance)
  * [Unused Code](#unused-code)
  * [Omitting Return](#omitting-return)
  * [Imports](#imports)
* [Spacing & New Line](#spacing-and-new-line)
* [Comments](#comments)
* [Function Declarations](#function-declarations)
* [Function Calls](#function-calls)
* [High Order Functions](#high-order-functions)
* [Closures](#closures)
* [Tuples](#tuples)
* [Property Observers](#property-observers)
* [Types](#types)
  * [Init Usage](#init-usage)
  * [Constants](#constants)
  * [Enums](#enums)
  * [Typealiases](#typealiases)
  * [Type Inference](#type-inference)
* [Access Control](#access-control)
* [Control Flow](#control-flow)
  * [Ternary Operator](#ternary-operator)
  * [Else Statements](#else-statements)
  * [Switch Statements](#switch-statements)
  * [Golden Path](#golden-path)
* [Multi-line String Literals](#multi-line-string-literals)
* [Pre-processor Directives](#pre-processor-directives)
* [References](#references)


## Using SwiftLint

When developing for Trendyol, it is highly recommended — and may even be mandatory, depending on your team — to incorporate our SwiftLint configuration. Please refer to the [SwiftLint Policy](SWIFTLINT.markdown) for detailed information.

## Naming

Descriptive and consistent naming makes software easier to read and understand. Use the Swift naming conventions described in the [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/). Some key takeaways include:

- striving for clarity at the call site
- prioritizing clarity over brevity
- using `camelCase` (not `snake_case`)
- using `UpperCamelCase` for types and protocols, `lowerCamelCase` for everything else
- including all needed words while omitting needless words
- using names based on roles, not types
- sometimes compensating for weak type information
- striving for fluent usage
- beginning factory methods with `make`
- naming methods for their side effects
  - verb methods follow the -ed, -ing rule for the non-mutating version
  - noun methods follow the formX rule for the mutating version
  - boolean types should read like assertions
  - protocols that describe _what something is_ should read as nouns
  - protocols that describe _a capability_ should end in _-able_ or _-ible_
- omitting all labels when arguments can't be usefully distinguished _e.g. min(number1, number2), zip(sequence1, sequence2)_
- using terms that don't surprise experts or confuse beginners
- generally avoiding abbreviations
- using precedent for names
- preferring methods and properties to free functions
- casing acronyms and initialisms uniformly up or down
- giving the same base name to methods that share the same meaning
- avoiding overloads on return type
- choosing good parameter names that serve as documentation
- preferring to name the first parameter instead of including its name in the method name, except as mentioned under Delegates
- labeling closure and tuple parameters
- taking advantage of default parameters

### Variables
### 1. Booleans
Use one the **is**, **has** or **should** etc. prefixes to name a boolean to makes it clear that it is boolean and not other type.

**Preferred**:
```swift
 let isAddressAvailable = false
 let hasPermissionChanged = true
```

**Not Preferred**:
```swift
let permissionChanged = false
let isProductHasContent = false
```

### 2. Declaration
Variable declaration should be lowerCamelCase.

### 3. Type Inference
Don't include type information.

**Preferred**:
```swift
let screenName = ""
let presenter = ScreenPresenter()
```

**Not Preferred**:
```swift
let screenName: String = ""
let presenter: ScreenPresenter = ScreenPresenter()
```

There might be some exceptions, like array and floating number declarations when explicitly needed.

```swift
let products: [Product] = []
let products: [Product] = .empty
let buttonOpacity: CGFloat = 1
```

### 4. Let vs var
Always use let over var for immutable variables.

### 5. Avoid Ambuguity
Name variables according to their roles, rather than their types. Include all the words needed to avoid ambiguity for a person reading code where the name is used. 

**Preferred**:
```swift
@IBOutlet private weak var iconImageView: UIImageView!
let isLowestPriceDurationActive = false
let greetingText = "Hello Trendyol!"
```

**Not Preferred**:
```swift
@IBOutlet private weak var icon: UIImageView!
let isDurationActive = false
let text = "Hello Trendyol!"
```

### 6. Naming from general part to specific part
Order names by starting with the most general part and ending with the most specific part.

**Preferred**:
```swift
let borderRadius: CGFloat
let bodyMarginRight: CGFloat
```

**Not Preferred**:
```swift
let radiusBorder: CGFloat
let bodyRightMargin: CGFloat
```

### 7. Underscore Usage
Don't use underscore.

**Preferred**:
```swift
let array: [String] = []
let filteredArray: [String] = []
```

**Not Preferred**:
```swift
let array: [String] = []
let _array: [String] = []
```

### 8. Static Properties
Static properties returning instances of their declaring type are not suffixed with the type's name.

**Preferred**:
```swift
enum Constant {
    enum InstallmentView {
        static let backgroundColor: UIColor
        static let cornerRadius: CGFloat
        static let borderWidth: Double
    }
}
```

**Not Preferred**:
```swift
enum Constant {
    static let installmentViewBackgroundColor: UIColor
    static let installmentViewCornerRadius: CGFloat
    static let installmentViewBorderWidth: Double
}
```

### 9. Proper Nouns
Use lowercased naming if noun is being used as prefix, otherwise it should be uppercased.

**Preferred**:
```swift
 var utf8Bytes: [UTF8.CodeUnit]
 var endpointURL: URL
 var userSMTPServer: SecureSMTPServer
```

**Not Preferred**:
```swift
 var endpointUrl: URL
 var userSmtpServer: SecureSMTPServer
```

### 10. Computed Properties
Naming should be just like ordinary variable, not like functions.

**Preferred**:
```swift
var productDetailDescriptionText: String {
    ...
}
```

**Not Preferred**:
```swift
var makeProductDetailDescriptionText: String {
    ...
}
```

### Methods

Methods without side-effects have names in the form of what: `let size = view.originalSize()`.

Methods with side effects are called in the form of an imperative verb: `list.sort()`.

Similar non-mutating methods that return new values must be called using past participle: `let newList = oldList.sorted()`. Or present participle: `let newList = oldList.sortingLexicographically()`.

Parameter names follow rules for variable names. An engineer shall make use of Swift syntax possibilities to make the full declaration a human-readable phrase. For example, `func insert(_ element: Element, at index: Int)` is nicely read as `insert(someElement, at: someIndex)` at the call site.

Factory method names start with the word "make". Both factory methods and initializers have their parameters as a list of items, they are not required to form phrases.

**Preferred**:
```swift
init(name: String, id: Int)
func makeView(position: CGPoint, size: CGSize) -> UIView
```

**Not Preferred**:
```swift
init(withName name: String, andID id: Int)
```

UIKit's UIControl actions are called with the control's name in the beginning and the "tapped" word in the end:

**Preferred**:
```swift
@objc
private func nextButtonTapped(_ sender: UIButton) { // ...
```

**Not Preferred**:
```swift
@objc
private func nextButtonAction(_ sender: UIButton) { // ...
```

Omit unused parameters.

**Preferred**:
```swift
func calculateSum(_ a: Int, _ b: Int) -> Int {
    return a + b
}
```

**Not Preferred**:
```swift
func calculateSum(_ a: Int, _ b: Int, _ c: Int) -> Int {
    return a + b  // The parameter 'c' is unused
}
```

Omit `Void` return types from function definitions.

**Preferred**:
```swift
func performTask() {
    // Implementation
}
```

**Not Preferred**:
```swift
func performTask() -> Void {
    // Implementation
}
```

Long function invocations should also break on each argument. Put the closing parenthesis on the last line of the invocation.

**Preferred**:
```swift
universe.generateStars(at: location,
                       count: 5,
                       color: starColor,
                       withAverageDistance: 4)
```

**Not Preferred**:
```swift
universe.generate(
  5,
  .stars,
  at: location)
```

**Not Preferred**:
```swift
universe.generateStars(
  at: location,
  count: 5,
  color: starColor,
  withAverageDistance: 4)
```

**Not Preferred**:
```swift
universe.generate(5,
  .stars,
  at: location)
```

**Not Preferred**:
```swift
universe.generateStars(
  at: location,
  count: 5,
  color: starColor,
  withAverageDistance: 4
)
```

**Not Preferred**:
```swift
universe.generateStars(at: location, count: 5, color: starColor, withAverageDistance: 4)
```

However, if the return value might be useful in some specific situations, it doesn't force one to use it (the `@discardableResult` annotation serves this purpose). Though, such return values are not encouraged. An engineer shall follow the principle of [the command-query separation](https://en.wikipedia.org/wiki/Command–query_separation).

---

### Delegates

Methods on delegate protocols and delegate-like protocols (such as data sources) are named using the linguistic syntax described below, which is inspired by Cocoa’s protocols.

> The term “delegate’s source object” refers to the object that invokes methods on the delegate. For example, a  `UITableView`  is the source object that invokes methods on the  `UITableViewDelegate`  that is set as the view’s  `delegate`  property.

All methods take the delegate’s source object as the first argument.

For methods that take the delegate’s source object as their  **only**  argument:

-   If the method returns  `Void`  (such as those used to notify the delegate that an event has occurred), then the method’s base name is the  **delegate’s source type**  followed by an  **indicative verb phrase**  describing the event. The argument is  **unlabeled.**
    
    ```swift
    func scrollViewDidBeginScrolling(_ scrollView: UIScrollView)
    ```
    
-   If the method returns  `Bool`  (such as those that make an assertion about the delegate’s source object itself), then the method’s name is the  **delegate’s source type**  followed by an  **indicative or conditional verb phrase**  describing the assertion. The argument is  **unlabeled.**
    
    ```swift
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool
    ```
    
-   If the method returns some other value (such as those querying for information about a property of the delegate’s source object), then the method’s base name is a  **noun phrase**  describing the property being queried. The argument is  **labeled with a preposition or phrase with a trailing preposition**  that appropriately combines the noun phrase and the delegate’s source object.
    
    ```swift
    func numberOfSections(in scrollView: UIScrollView) -> Int
    ```
    

For methods that take  **additional**  arguments after the delegate’s source object, the method’s base name is the delegate’s source type  **by itself**  and the first argument is  **unlabeled.**  Then:

-   If the method returns  `Void`, the second argument is  **labeled with an indicative verb phrase**  describing the event that has the argument as its  **direct object or prepositional object,**  and any other arguments (if present) provide further context.
    
    ```swift
    func tableView(
      _ tableView: UITableView,
      willDisplayCell cell: UITableViewCell,
      forRowAt indexPath: IndexPath)
    ```
    
-   If the method returns  `Bool`, the second argument is  **labeled with an indicative or conditional verb phrase**  that describes the return value in terms of the argument, and any other arguments (if present) provide further context.
    
    ```swift
    func tableView(
      _ tableView: UITableView,
      shouldSpringLoadRowAt indexPath: IndexPath,
      with context: UISpringLoadedInteractionContext
    ) -> Bool
    ```
    
-   If the method returns some other value, the second argument is  **labeled with a noun phrase and trailing preposition**  that describes the return value in terms of the argument, and any other arguments (if present) provide further context.
    
    ```swift
    func tableView(
      _ tableView: UITableView,
      heightForRowAt indexPath: IndexPath
    ) -> CGFloat
    ```
    

Apple’s documentation on  [delegates and data sources](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/DelegatesandDataSources/DelegatesandDataSources.html)  also contains some good general guidance about such names.

#### Examples:
**Preferred**:
```swift
func namePickerView(_ namePickerView: NamePickerView, didSelectName name: String)
func namePickerViewShouldReload(_ namePickerView: NamePickerView) -> Bool
func namePickerViewNumberOfSections(in scrollView: UIScrollView) -> Int
func namePickerViewRefreshOrdersAndFocus(on orderParentId: String)
```

**Not Preferred**:
```swift
func didSelectName(namePicker: NamePickerViewController, name: String)
func namePickerShouldReload() -> Bool
func numberOfSections(scrollView: UIScrollView) -> Int
func viewRefreshOrdersAndFocus(on orderParentId: String)
```
---

### Interface

Classes and structures are named using noun phrases, as well as protocols describing what an object is. Protocols which add abilities are named descriptively (e.g., `Sortable`). Protocols should not have the word `Protocol` at the end of the name. Instead, conforming types should have a specifying word in the name with Interface suffix

**Preferred**:
```swift
protocol EngineInterface { }
struct DefaultEngine: EngineInterface { }
protocol AccountRouterInterface { }
struct AccountRouter: AccountRouterInterface { }
private let router: AccountRouterInterface
```
**Not Preferred**:
```swift
protocol EngineProtocol { }
struct Engine: EngineProtocol { }
protocol AccountRouter { }
protocol AccountRouterProtocol { }
private let router: AccountRouter
```
Which introduced support for using the AnyObject keyword as a protocol constraint, recommends preferring AnyObject over class:

> This proposal merges the concepts of class and AnyObject, which now have the same meaning: they represent an existential for classes. To get rid of the duplication, we suggest only keeping AnyObject around. To reduce source-breakage to a minimum, class could be redefined as typealias class = AnyObject and give a deprecation warning on class for the first version of Swift this proposal is implemented in. Later, class could be removed in a subsequent version of Swift.

**Preferred**:
```swift
protocol Foo: AnyObject { }
```

**Not Preferred**:
```swift
protocol Foo: class { }
```
---

### Generics

Generic type parameters should be descriptive, upper camel case names. When a type name doesn't have a meaningful relationship or role, use a traditional single uppercase letter such as `T`, `U`, or `V`.

**Preferred**:
```swift
struct Stack<Element> { ... }
func write<Target: OutputStream>(to target: inout Target)
func swap<T>(_ a: inout T, _ b: inout T)
```

**Not Preferred**:
```swift
struct Stack<T> { ... }
func write<target: OutputStream>(to target: inout target)
func swap<Thing>(_ a: inout Thing, _ b: inout Thing)
```
---

### Loops
### 1. Where Clause
Prefer to use where clause if it's possible.

**Preferred**:
```swift
for item in items where item.productCount > 1 {
    ...
}
```

**Not Preferred**:
```swift
for item in items {
    if item.productCount > 1 {
        
    }
}
```

### 2. Indices
Use .indicies property to loop over array indexes.

**Preferred**:
```swift
for index in array.indices {
    
}
```

**Not Preferred**:
```swift
for index in 0..<array.count {
    
}
```

### 3. Enumarated
Use .enumarated to loop through both index and item.

```swift
for (index, item) in array.enumarated() {
    
}
```

## Self and self usage

### 1. Bind to self
Bind to self when capturing weak self reference.

 **Preferred**:
 ```swift
 func fetch(completion: () -> Void) {
   networkManager.request() { [weak self] response in
     guard let self else { return }
     self.bar()
     self.foo()
   }
 }
 ```

### 2. Bind to self
Prefer using guard self checking unless you have single self usage. If you bind to self, don't use self again in the rest of the closure.

 **Preferred**:
 ```swift

 func fetch(completion: () -> Void) {
     networkManager.request { [weak self] response in
         guard let self else { return }
         bark()
         foo()
     }
 }

 func fetch(completion: () -> Void) {
     networkManager.request { [weak self] response in
         self?.bark()
     }
 }

 func fetch(completion: () -> Void) {
     networkManager..request() { [weak self] response in.
         guard let self else { return }
         bark(item, item2)
     }
 }
 ```

 **Not Preferred**:
 ```swift
 func fetch(completion: () -> Void) {
     networkManager..request { [weak self] response in
         guard let self else { return }
         bark()
     }
 }

 func fetch(completion: () -> Void) {
     networkManager..request { [weak self] response in
         self?.foo()
         self?.bark()
     }
 }

 func fetch(completion: () -> Void) {
     networkManager.request { [weak self] response in.
         self?.bark(self?.item, self?.item2)
     }
 }
 ```

### 3. Unnecesary self usage
Use self only if you need it explicitly.

### 4. Self usage
Prefer to use "Self" over concrete type name.

 **Preferred**:
 ```swift
 final class HomePageBarButtonsBuilder {
     private var buttons: [UIBarButtonItem] = []

     @discardableResult
     func appendSellerNotificationButton(target: Any?, selector: Selector) -> Self {
         ...
         return self
     }

     @discardableResult
     func appendSpacerButton(width: CGFloat) -> Self {
         ...
         return self
     }

     func build() -> [UIBarButtonItem] {
         return buttons
     }
 }

 protocol SomeProtocol {
     static func createModule() -> Self
 }
 ```
---

## Class and Structs
### 1. Controller Suffix
Don't use "Controller" in names of classes that aren't view controllers.

### 2. Declaration
Use PascalCase for type names.

### 3. Mock Naming
Use "Mock" prefix for entire mock classes. 

**Preferred**:
```swift
class MockPriceView: PriceViewInterface { }
```

**Not Preferred**:
```swift
class PriceView: PriceViewInterface { }
```

**Preferred**:
```swift
class MockPriceView: PriceViewInterface { }
```

**Not Preferred**:
```swift
class MockPriceViewInterface: PriceViewInterface { }
class MockPriceViewController: PriceViewInterface { } 
```

"Mock" prefix should be first rather than channel prefixes.

**Preferred**:
```swift
class MockPDPTagView: PriceViewInterface { }
```

**Not Preferred**:
```swift
class PDPMockTagView: PriceViewInterface { }
```

### 4. Test Class Naming
Use "Tests" suffix for BaseXCTestCases.

### 5. UI Related Class Naming
Use type constraint as suffix.

**Preferred**:
```swift
class INTPriceView: UIView { }
class INTDescriptionCell: UICollectionViewCell { }
```

**Not Preferred**:
```swift
class INTPriceComponent: UIView { }
class INTDescriptionComponent: UICollectionViewCell { }
```

### 6. Version Suffixes
Use "V" suffix for versions of the classes. 

**Preferred**:
```swift
class ProductSliderCell { }
class ProductSliderCellV2 { }
class ProductSliderCellV3 { }
```

**Not Preferred**:
```swift
class ProductSliderCell { }
class ProductSliderCellNew { }
class ProductSliderCellRedesign { }
```
---

## Attributes

### 1. Attribute Placement
Prefer to declare attribute in the same line if it's stored property, otherwise declare it in one line above. As exception, IBAction is declared in the same line by Xcode, you don't need to change it.

**Preferred**:
```swift
@objc 
class Manager {
    @State private var isLoggedIn = false
    
    @discardableResult
    func reset() {
      ...
    }
    
    @IBAction func logout() {
        ...
    }
    
    @IBAction
    func login() {
      ...
    }
}
```

**Not Preferred**:
```swift
@objc class Manager {
    @State
    private var isLoggedIn = false
    
    @discardableResult func reset() {
      ...
    }
}
```

## Language

Use US English spelling to match Apple's API.

**Preferred**:
```swift
let color = "red"
```

**Not Preferred**:
```swift
let colour = "red"
```

***Some tips***:

 if you turn on "Check spelling while you type", found in the Edit->Format->Spelling and Grammar menu, Xcode will display the red word spelled wrong indicator for comments as they are spelled wrong. It will also spell check camel case identifiers

![Xcode while editing settings](screens/check-spelling.png)

Also, you can look for the correct form via right-click

![Xcode while editing settings](screens/check-spelling-suggestion.png)

### String Concatenation

### 1. String(format:) usage
Prefer "\()" over String(format:).

**Preferred**:
```swift
return "user name: \(user.name), user id: \(user.id), user height: \(length)"
```

**Not Preferred**:
```swift
return String(format: "user name: %@, user id: %d, user height: %f", user.name,  user.id, length)
```

## File Organization

### Alphabetize and deduplicate module imports within a file. Place all imports at the top of the file below the header comments. (Also see [Imports](#imports).)

### Limit consecutive whitespace to one blank line or space (excluding indentation)

**Not Preferred**:
```swift
struct Planet {
  let mass:          Double
  let hasAtmosphere: Bool


  func distance(to: Planet) { }
}
```

**Preferred**:
```swift
struct Planet {
  let mass: Double
  let hasAtmosphere: Bool

  func distance(to: Planet) { }
}
```

### Declarations that include scopes spanning multiple lines should be separated from adjacent declarations in the same scope by a newline.

Insert a single blank line between multi-line scoped declarations (e.g. types, extensions, functions, computed properties, etc.) and other declarations at the same indentation level.

**Why**: Dividing scoped declarations from other declarations at the same scope visually separates them, making adjacent declarations easier to differentiate from the scoped declaration.

**Not Preferred**:
```swift
struct SolarSystem {
  var numberOfPlanets: Int {
    …
  }
  func distance(to: SolarSystem) -> AstronomicalUnit {
    …
  }
}
struct Galaxy {
  func distance(to: Galaxy) -> AstronomicalUnit {
    …
  }
  func contains(_ solarSystem: SolarSystem) -> Bool {
    …
  }
}
```

**Preferred**:
```swift
struct SolarSystem {
  var numberOfPlanets: Int {
    …
  }

  func distance(to: SolarSystem) -> AstronomicalUnit {
    …
  }
}

struct Galaxy {
  func distance(to: Galaxy) -> AstronomicalUnit {
    …
  }

  func contains(_ solarSystem: SolarSystem) -> Bool {
    …
  }
}
```

### Remove blank lines at the top and bottom of scopes, excluding type bodies which can optionally include blank lines.

**Not Preferred**:
```swift
class Planet {
  func terraform() {

    generateAtmosphere()
    generateOceans()

  }
}
```

**Preferred**:
```swift
class Planet {
  func terraform() {
    generateAtmosphere()
    generateOceans()
  }
}
```

### Within each top-level section, place content in the following order. This allows a new reader of your code to more easily find what they are looking for. 

* Nested types and type aliases
* Static properties
* Class properties
* IBOutlet properties
* Instance properties
* Lifecycle methods
* Static methods
* Class methods
* IBAction methods
* Instance methods

### Protocol conforms should be ordered for understanding action structure easily.

* Private method extension
* Type protocol conform extension
* Delegate conform extension
* Output conform extension

### Add empty lines between property declarations of different kinds. (e.g. between static properties and instance properties.)

**Not Preferred**:
```swift
static let gravityEarth: CGFloat = 9.8
static let gravityMoon: CGFloat = 1.6
var gravity: CGFloat
```

**Preferred**:
```swift
static let gravityEarth: CGFloat = 9.8
static let gravityMoon: CGFloat = 1.6

var gravity: CGFloat
```

### Computed properties and properties with property observers should appear at the end of the set of declarations of the same kind. (e.g. instance properties.)

**Not Preferred**:
```swift
var atmosphere: Atmosphere {
  didSet {
    print("oh my god, the atmosphere changed")
  }
}
var gravity: CGFloat

init() {
  ...
}
```

**Preferred**:
```swift
var gravity: CGFloat
var atmosphere: Atmosphere {
  didSet {
    print("oh my god, the atmosphere changed")
  }
}

init() {
  ...
}
```

**Also Preferred**:

If a swift file contains a lot of computed and stored property, they can be grouped and sorted among themselves with using MARK.

```swift
// MARK: - Identitiy Properties
var name: String
var surname: String
var fullName: String {
  "\(name) \(surname)"
}

// MARK: - X Component Properties
var xComponentTitle: String
var isXComponentFlagEnabled: Bool
var shouldShowXComponent: Bool {
  !xComponentTitle.isEmpty && isXComponentFlagEnabled
}

init() {
  ...
}
```

Also see for file organization [ExamplePresenter.swift](/code_style_guideline/examples/ExamplePresenter.swift)

## Code Organization

Use extensions to organize your code into logical blocks of functionality.

### Protocol Conformance
### 1. AnyObject vs class
Use AnyObject instead of class in protocol definitions.

### 2. Mark Usage
Use mark for protocol conformance.

```swift
// MARK: - ViewInterface
extension MyViewController: ViewInterface {
...
}
```

### 3. Extension Usage
Prefer adding a separate extension for the protocol methods and each extension should confirm single protocol. If protocol/type is generic or don't require any implementation, it can be confirmed without extension.

**Preferred**:
```swift
class MyViewController: UIViewController, Loadable {
  // class stuff here
}

// MARK: - UITableViewDataSource
extension MyViewController: UITableViewDataSource {
  // table view data source methods
}

// MARK: - UITableViewDelegate
extension MyViewController: UITableViewDelegate {
  // scroll view delegate methods
}
```

**Not Preferred**:
```swift
extension MyViewController: UITableViewDelegate, UITableViewDataSource {
  // scroll view delegate methods
}
```

### Unused Code

Unused (dead) code, including Xcode template code and placeholder comments should be removed. An exception is when your tutorial or book instructs the user to use the commented code.

Aspirational methods not directly associated with the tutorial whose implementation simply calls the superclass should also be removed. This includes any empty/unused UIApplicationDelegate methods.

**Preferred**:
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return Database.contacts.count
}
```

**Not Preferred**:
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  // #warning Incomplete implementation, return the number of rows
  return Database.contacts.count
}
```

**Reason:** You called super method and you didn't implement any body. You don't need to override `didReceiveMemoryWarning`
```swift
override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
}
```

**Reason:** numberOfSections's default value is `1`.
```swift
override func numberOfSections(in tableView: UITableView) -> Int {
  return 1
}
```

### Omitting Return

Omit the return keyword when not required by the language.

**Preferred**:
```swift
["1", "2", "3"].compactMap { Int($0) }

var size: CGSize {
  CGSize(
    width: 100.0,
    height: 100.0)
}

func makeInfoAlert(message: String) -> UIAlertController {
  UIAlertController(
    title: "ℹ️ Info",
    message: message,
    preferredStyle: .alert)
}
```

**Not Preferred**:
```swift
["1", "2", "3"].compactMap { return Int($0) }

var size: CGSize {
  return CGSize(
    width: 100.0,
    height: 100.0)
}

func makeInfoAlert(message: String) -> UIAlertController {
  return UIAlertController(
    title: "ℹ️ Info",
    message: message,
    preferredStyle: .alert)
}
```

### Imports

Alphabetize and deduplicate module imports within a file. Place all imports at the top of the file below the header comments. Do not add additional line breaks between import statements. Add a single empty line before the first import and after the last import. SwiftFormat: **sortedImports** SwiftFormat: **duplicateImports**

A standard organization method helps engineers more quickly determine which modules a file depends on.
Duplicated import statements have no effect and should be removed for clarity.

**Not Preferred**:
```swift
//  Copyright © 2024 Trendyol. All rights reserved.
//

import TYCoreUtils
import Foundation
import CommonKit
import AccessibilityKit

import MemberKit
```

**Preferred**:
```swift
//  Copyright © 2024 Trendyol. All rights reserved.
//

import AccessibilityKit
import CommonKit
import Foundation
import MemberKit
import TYCoreUtils
```

#### @testable usage

**Preferred**:
```swift
//  Copyright © 2024 Trendyol. All rights reserved.
//

import AccessibilityKit
import CommonKit
import Foundation
import MemberKit
import TYCoreUtils

@testable import Trendyol
```

**Also Preferred**:
```swift
//  Copyright © 2024 Trendyol. All rights reserved.
//

import AccessibilityKit
import CommonKit
import Foundation
import MemberKit
@testable import Trendyol
import TYCoreUtils
```

Import only the modules a source file requires. For example, don't import `UIKit` when importing `Foundation` will suffice. Likewise, don't import `Foundation` if you must import `UIKit`.

**Preferred**:
```swift
import UIKit
var view: UIView
var deviceModels: [String]
```

**Preferred**:
```swift
import Foundation
var deviceModels: [String]
```

**Not Preferred**:
```swift
import UIKit
import Foundation
var view: UIView
var deviceModels: [String]
```

**Not Preferred**:
```swift
import UIKit
var deviceModels: [String]
```

## Spacing And New Line
**Important**: Go to  `Xcode > Preferences > Text Editing > While editing`
* Starting from Xcode 4.4 whitespaces will be trimmed automatically by default, unless the line is all whitespace. You can also activate  `Including whitespace-only lines`  to fix this, which is not active by default.

![Xcode while editing settings](screens/text-editing-while-editing.png)

*  While the generall recommendation advises indenting with 2 spaces rather than tabs to save space and prevent line wrapping, we've chosen to adhere to our decision of using 4 spaces for indentation. Be sure to set this preference in Xcode and in the Project settings as shown below::

![Xcode indent settings](screens/text-editing-tab-width-indent.png)

-   Method braces and other braces (`if`/`else`/`switch`/`while`  etc.) always open on the same line as the statement but close on a new line.
-   Tip: You can re-indent by selecting some code (or  **Command-A**  to select all) and then  **Control-I**  (or  **Editor ▸ Structure ▸ Re-Indent**  in the menu). Some of the Xcode template code will have 4-space tabs hard coded, so this is a good way to fix that.

 #### 1. Colon Spacing

Place the colon immediately after an identifier, followed by a space

**Preferred**:
```swift
var something: Double = 0

class MyClass: SuperClass {
  // ...
}

var dict = [KeyType: ValueType]()
```

**Not Preferred**:
```swift
var something : Double = 0
}

class MyClass : SuperClass {
  // ...
}

var dict = [KeyType:ValueType]()
var dict = [KeyType : ValueType]()
```


 #### 2. Return Arrow Spacing

Place a space on either side of a return arrow for readability

**Preferred**:
```swift
func doSomething() -> String {
  // ...
}

func doSomething(completion: () -> Void) {
  // ...
}
```

**Not Preferred**:
```swift
func doSomething()->String {
  // ...
}

func doSomething(completion: ()->Void) {
  // ...
}
```

**Multi-line arrays should have each bracket on a separate line.** Put the opening and closing brackets on separate lines from any of the elements of the array. Also add a trailing comma on the last element.

**Preferred**:
```swift
let rowContent = [
  listingUrgencyDatesRowContent(),
  listingUrgencyBookedRowContent(),
  listingUrgencyBookedShortRowContent(),
]
```

**Not Preferred**:
```swift
let rowContent = [listingUrgencyDatesRowContent(),
                  listingUrgencyBookedRowContent(),
                  listingUrgencyBookedShortRowContent()]

let rowContent = [
  listingUrgencyDatesRowContent(),
  listingUrgencyBookedRowContent(),
  listingUrgencyBookedShortRowContent()
]
```

 #### 3. Whitespace Around Braces
 
Braces should be surrounded by a single whitespace character (either a space, or a newline) on each side.

**Preferred**:
```swift
struct Planet {
  …
}

if condition {
  …
} else {
  …
}

if user.isHappy {
  // Do something
} else {
  // Do something else
}
```

**Not Preferred**:
```swift
struct Planet{
  …
}

if condition{
  …
}else{
  …
}

if user.isHappy
{
  // Do something
}
else {
  // Do something else
}
```

-   There should be one blank line between methods and up to one blank line between type declarations to aid in visual clarity and organization. Whitespace within methods should separate functionality, but having too many sections in a method often means you should refactor into several methods.
    
-   There should be no blank lines after an opening brace or before a closing brace.

-   Depending on the need, you can also use **Control-m** if there won't be too much distortion in the pattern and there is a subject that involves more than one parameter.

**Preferred**:
```swift
let user = try await getUser(for: userID,
                             on: connection)

ManyParamInit(
    param1: String,
    param2: String,
    param3: String
)
```

**Not Preferred**:
```swift
let user = try await getUser(
  for: userID,
  on: connection
)

ManyParamInit(param1: String, param2: String, param3: String)
```

 #### 4. No Spaces Around Parens

For function calls and declarations, there should be no spaces before or inside the parentheses of the argument list.

**Preferred**:
```swift
func install(_ engine: Engine) { }

install(AntimatterDrive())
```

**Not Preferred**:
```swift
func install ( _ engine: Engine ) { }
```

 #### 4. Space In Empty Braces

Include a single space in an empty set of braces (`{ }`).

**Preferred**:
```swift
extension Spaceship: Trackable { }

extension SpaceshipView {
  var accessibilityIdentifier: String {
    get { spaceship.name }
    set { }
  }
}
```

**Not Preferred**:
```swift
extension Spaceship: Trackable {}

extension SpaceshipView {
  var accessibilityIdentifier: String {
    get { spaceship.name }
    set {}
  }
}
```

 #### 5. No Blank Lines At Start Or End Of Non-Type Scopes
 
**Remove blank lines at the top and bottom of scopes**, excluding type bodies which can optionally include blank lines.

**Preferred**:
```swift
class Planet {
  func terraform() {
    generateAtmosphere()
    generateOceans()
  }
}
```

**Not Preferred**:
```swift
class Planet {
  func terraform() {

    generateAtmosphere()
    generateOceans()

  }
}

class Planet {

  func terraform() {
    generateAtmosphere()
    generateOceans()
  }

}
```

 #### 6. Newline Between Subsections
 
**Add empty lines between property declarations of different kinds.** (e.g. between static properties and instance properties.)

**Preferred**:
```swift
static let gravityEarth: CGFloat = 9.8
static let gravityMoon: CGFloat = 1.6

var gravity: CGFloat
```

**Not Preferred**:
```swift
static let gravityEarth: CGFloat = 9.8
static let gravityMoon: CGFloat = 1.6
var gravity: CGFloat
```

 #### 7. No Space Inside Brackets

There should be no spaces inside the brackets of collection literals.

**Preferred**:
```swift
let innerPlanets = [mercury, venus, earth, mars]
let largestObjects = [.star: sun, .planet: jupiter]
```

**Not Preferred**:
```swift
let innerPlanets = [ mercury, venus, earth, mars ]
let largestObjects = [ .star: sun, .planet: jupiter  ]
```

Colons always have no space on the left and one space on the right. Exceptions are the ternary operator  `? :`, empty dictionary  `[:]`  and  `#selector`  syntax  `addTarget(_:action:)`.

**Preferred**:
```swift
class TestDatabase: Database {
  var data: [String: CGFloat] = ["A": 1.2, "B": 3.2]
}
```

**Not Preferred**:
```swift
class TestDatabase : Database {
  var data :[String:CGFloat] = ["A" : 1.2, "B":3.2]
}
```

-   Avoid trailing whitespaces at the ends of lines.
    
-   Add a single newline character at the end of each file.

 #### 8. Multi Line Conditions

Multi-line conditional statements should break after the leading keyword. Indent each individual statement by 2 spaces.

*Why?*
Breaking after the leading keyword resets indentation to the standard 2-space grid, which helps avoid fighting Xcode's control + i indentation behavior.

**Preferred**:
```swift
if
  let galaxy,
  galaxy.name == "Milky Way"
{ … }

guard
  let galaxy,
  galaxy.name == "Milky Way"
else { … }

guard
  let earth = universe.find(
    .planet,
    named: "Earth"),
  earth.isHabitable
else { … }

if let galaxy {
  …
}

guard let galaxy else {
  …
}

```

**Not Preferred**:
```swift
if let galaxy,
  galaxy.name == "Milky Way" // Indenting by two spaces fights Xcode's ^+I indentation behavior
{ … }

guard let galaxy,
      galaxy.name == "Milky Way" // Variable width indentation (6 spaces)
else { … }

guard let earth = universe.find(
  .planet,
  named: "Earth"),
  earth.isHabitable // Blends in with previous condition's method arguments
else { … }
```

 #### 9. Closure Brace Spacing

**Closures should have a single space or newline inside each brace.** Trailing closures should additionally have a single space or newline outside each brace.

**Preferred**:
```swift
let evenSquares = numbers.filter { $0.isMultiple(of: 2) }.map { $0 * $0 }
let evenSquares = numbers.filter({ $0.isMultiple(of: 2) }).map({ $0 * $0 })

let evenSquares = numbers
  .filter { $0.isMultiple(of: 2) }
  .map { $0 * $0 }
```

**Not Preferred**:
```swift
let evenSquares = numbers.filter{$0.isMultiple(of: 2)}.map{  $0 * $0  }
let evenSquares = numbers.filter( { $0.isMultiple(of: 2) } ).map( { $0 * $0 } )

let evenSquares = numbers
  .filter{ $0.isMultiple(of: 2) }
  .map{
    $0 * $0
  }
```

 #### 10. Infix Operator Spacing
 
**Infix operators should have a single space on either side.** Prefer parenthesis to visually group statements with many operators rather than varying widths of whitespace. This rule does not apply to range operators (e.g. `1...3`) and postfix or prefix operators (e.g. `guest?` or `-1`).

**Preferred**:
```swift
let capacity = 1 + 2
let capacity = currentCapacity ?? 0
let mask = (UIAccessibilityTraitButton | UIAccessibilityTraitSelected)
let capacity = newCapacity
let latitude = region.center.latitude - (region.span.latitudeDelta / 2.0)
```

**Not Preferred**:
```swift
let capacity = 1+2
let capacity = currentCapacity   ?? 0
let mask = (UIAccessibilityTraitButton|UIAccessibilityTraitSelected)
let capacity=newCapacity
let latitude = region.center.latitude - region.span.latitudeDelta/2.0
```

---

## Parantheses & Braces

### Parantheses

Omit unnecessary parentheses.

**Preferred**:
```swift
if name == "Hello" {
  print("World")
}

if userCount > 0 { ... }
switch someValue { ... }
let evens = userCounts.filter { number in number.isMultiple(of: 2) }

if (x == 0 || y == 1) && z == 2 {
  print("...")
}
```

**Not Preferred**:
```swift
if (name == "Hello") {
  print("World")
}

if (userCount > 0) { ... }
switch (someValue) { ... }
let evens = userCounts.filter { (number) in number.isMultiple(of: 2) }

if ((x == 0 || y == 1) && z == 2) {
  print("...")
}
```

### Braces

The opening brace following a single-line expression should be on the same line as the rest of the statement. 

**Preferred**:
```swift
if !planet.isHabitable {
  planet.terraform()
}

class Planet {
  func terraform() {
    generateAtmosphere()
    generateOceans()
  }
}
```

**Not Preferred**:
```swift
if !planet.isHabitable
{
  planet.terraform()
}

class Planet
{
  func terraform()
  {
    generateAtmosphere()
    generateOceans()
  }
}
```

## Comments

### Comment blocks should use single-line comments (// for code comments and /// for documentation comments), rather than multi-line comments (/* ... */ and /** ... */).


**Preferred**:
```swift
/// A planet that exists somewhere in the universe.
///
/// Planets have many properties. For example, the best planets
/// have atmospheres and bodies of water to support life.
class Planet {
  /// Terraforms the planet, by adding an atmosphere and ocean that is hospitable for life.
  func terraform() {
    // Generate the atmosphere first, before generating the ocean.
    // Otherwise, the water will just boil off immediately.
    generateAtmosphere()

    // Now that we have an atmosphere, it's safe to generate the ocean
    generateOceans()
  }
}
```

**Not Preferred**:
```swift
/**
* A planet that exists somewhere in the universe.
*
* Planets have many properties. For example, the best planets
* have atmospheres and bodies of water to support life.
*/
class Planet {
  /**
    Terraforms the planet, by adding an atmosphere and ocean that is hospitable for life.
  */
  func terraform() {
    /*
    Generate the atmosphere first, before generating the ocean.
    Otherwise, the water will just boil off immediately.
    */
    generateAtmosphere()

    /* Now that we have an atmosphere, it's safe to generate the ocean */
    generateOceans()
  }
}
```

### Include spaces or newlines before and after comment delimiters 

**Preferred**:
```swift
/// A spacecraft with incredible performance characteristics
struct Spaceship {

  func travelFasterThanLight() { /* unimplemented */ }

  func travelBackInTime() { } // TODO: research whether or not this is possible

}
```

**Not Preferred**:
```swift
///A spacecraft with incredible performance characteristics
struct Spaceship {

  func travelFasterThanLight() {/*unimplemented*/}

  func travelBackInTime() { }//TODO: research whether or not this is possible

}
```

### Each type and extension which implements a conformance should be preceded by a MARK comment.

* Extensions that immediately follow the type being extended should omit that type's name and instead use // MARK: ProtocolName.
* If there is only one type or extension in a file, the MARK comment can be omitted.
* If the extension in question is empty (e.g. has no declarations in its body), the MARK comment can be omitted.
* For extensions that do not add new conformances, consider adding a MARK with a descriptive comment.

```swift
class MyViewController: UIViewController {
    ...
}

// MARK: - ABCDelegate
extension MyViewController: ABCDelegate {
    ...
}

// MARK: - XYZDelegate
extension MyViewController: XYZDelegate {
    ...
}

private extension MyViewController {
    ...
}
```
---

## Function Declarations

Keep short function declarations on one line including the opening brace:

```swift
func reticulateSplines(spline: [Double]) -> Bool {
  // reticulate code goes here
}
```

For functions with long signatures, put each parameter on a new line and add an extra indent on subsequent lines:

```swift
func reticulateSplines(
  spline: [Double], 
  adjustmentFactor: Double,
  translateConstant: Int, 
  comment: String
) -> Bool {
  // reticulate code goes here
}
```

Don't use `(Void)` to represent the lack of an input; simply use `()`. Use `Void` instead of `()` for closure and function outputs.

**Preferred**:

```swift
func updateConstraints() -> Void {
  // magic happens here
}

typealias CompletionHandler = (result) -> Void
```

**Not Preferred**:

```swift
func updateConstraints() -> () {
  // magic happens here
}

typealias CompletionHandler = (result) -> ()
```

## Function Calls

Mirror the style of function declarations at call sites. Calls that fit on a single line should be written as such:

```swift
let success = reticulateSplines(splines)
```

If the call site must be wrapped, put each parameter on a new line, indented one additional level:

```swift
let success = reticulateSplines(
  spline: splines,
  adjustmentFactor: 1.3,
  translateConstant: 2,
  comment: "normalize the display")
```

A method declaration is placed on a single line if it can fit most display screen widths without a carry-over. Otherwise, each parameter is placed on its own line and matches the beginning of the previous one. Return type carries on to the last parameter's line.

**Preferred**:

```swift
func fetchResults(from endpoint: URL,
                  transferringTo device: Device,
                  compressed: Bool,
                  completionHandler: (() -> Void)?) –> [Data]
```

**Not Preferred**:

```swift
func fetchResults(
    from endpoint: URL = .remoteServerPath,
    transferringTo device: Device = .current,
    compressed: Bool = true,
    completionHandler: ((_ success: Bool) -> ())? = nil
) –> [Data]

func fetchResults(from endpoint: URL, transferringTo device: Device, 
                  compressed: Bool, completionHandler: (() -> Void)?) –> [Data]
```

## High Order Functions

### 1. KeyPath
Prefer to use keypaths over providing closures. 

**Preferred**:
```swift
response.restaurants?.compactMap(\.id)
```

**Not Preferred**:
```swift
response.restaurants?.compactMap({ $0.id })
```

### 2. Chaining
Move to new line per high order function. Also, take care of chaining performance, avoid multiple loops as much as possible.

**Preferred**:
```swift
let value = numbers
  .map { $0 * 2 }
  .filter { $0 > 50 }
  .map { $0 + 10 }

attributes.contains { $0.key == filterAttribute.id }
```

**Not Preferred**:
```swift
let value = numbers.map { $0 * 2 }.filter { $0 > 50 }.map { $0 + 10 }

attributes.map(\.key).contains($0.id)
```

### 3. Paranthesis
Prefer omitting paranthesis unless we need to put dot after the expression.

**Preferred**:
```swift
planets.map { $0.name }
planets.first { $0.flag }
planets.first({ $0.flag }).name
```

**Not Preferred**:
```swift
planets.map({ $0.name })
planets.first(where: { $0.flag })
planets.first { $0.flag }.name
```

### 4. Passing method name as closure
Prefer to pass method name over closure.

**Preferred**:
```swift
items.map(TargetModel.init)
items.forEach(checkFlags)
```

**Not Preferred**:
```swift
items.map {
     TargetModel(item: $0)
}

items.forEach { 
    checkFlags($0)
}
```

### 5. Prefering High Order Functions Over Traditional Loops
Prefer high order functions over traditional loops.

**Preferred**:
```swift
items.map(TargetModel.init)
let filteredStamps = stamps.filter { $0.shouldShowOnSearch ?? true }
```

**Not Preferred**:
```swift
for item in items {
      TargetModel(id: item.id)
}

var filteredStamps: [Stamp] = []
for stamp in stamps where stamp.shouldShowOnSearch == true {
      filteredStamps.append(stamp)
}
```

## Closures

### 1. Closure Complexity
Extract closure content to separate method if closure gets too complex.

### 2. Void Usage
Prefer Void over (). You can also declare your own typealiases for closures for your own module.

**Preferred**:
```swift
typealias IntHandler = (Int) -> Void
```

**Not Preferred**:
```swift
typealias IntHandler = (Int) -> ()
```

### 3. Unused Closure Parameters
Use underscore for unused closure parameters.

**Preferred**:
```swift
fetchUser() { _,  param2 in
  print(param2)
}
```

**Not Preferred**:
```swift
fetchUser() { param1, param2 in
  print(param2)
}
```

### 4. Trailing Closure
Prefer trailing closure syntax if there's a single closure at the end of the arguments. If you have multiple arguments, declare closure as last argument.

**Preferred**:
```swift
myMethod(productCount: 1) {
    ...
}
```

**Not Preferred**:
```swift
myMethod(productCount: 1, completion: {
  ...
})
```

### 5. Single Expression Closure
Omit return if you have single expression in closure.

**Preferred**:
```swift
users.first { user in
  user.isLoggedIn
}
```

**Not Preferred**:
```swift
users.first { user in
   return user.isLoggedIn
}
```

### 6. Lazy Closures
Prefer short syntax for single line lazy var declarations.

**Preferred**:
```swift
lazy var item = Item()
```

**Not Preferred**:
```swift
lazy var item: Item = {
     return Item()
}()
```

## Tuples

A tuple type is a comma-separated list of types, enclosed in parentheses.

Name members of tuples for extra clarity. Rule of thumb: if you've got more than **3 fields**, you should probably be using a struct.

**Preferred**:
```swift
func whatever() -> (x: Int, y: Int) {
  return (x: 4, y: 4)
}

func whatever2() -> (x: Int, y: Int) {
  return (4, 4)
}

let coord = whatever()
coord.x
coord.y
```

**Not Preferred**:
```swift
func whatever() -> (Int, Int) {
  return (4, 4)
}
let thing = whatever()
print(thing.0)
```

**Preferred**:
```swift
struct Product {
  let priceSet = (price: 100.0, discountedPrice: 80.0)
}

let product = Product()
product.priceSet.discountedPrice // returns 80.0
```

**Not Preferred**:
```swift
struct Product {
  let priceSet = (100.0, 80.0)
}

let product = Product()
product.priceSet.1 // returns 80.0
```

## Property Observers

Extract complex property observers into methods. This reduces nestedness, separates side-effects from property declarations, and makes the usage of implicitly-passed parameters like oldValue explicit.
**Not Preferred**:
```swift
class TextField {
  var text: String? {
    didSet {
      guard oldValue != text else {
        return
      }

      // Do a bunch of text-related side-effects.
    }
  }
}
```
**Preferred**:
```swift
class TextField {
  var text: String? {
    didSet { textDidUpdate(from: oldValue) }
  }

  private func textDidUpdate(from oldValue: String?) {
    guard oldValue != text else {
      return
    }

    // Do a bunch of text-related side-effects.
  }
}
```

Property observers also take parameters that refer to the old and the new values.

By default, these parameters are called oldValue and newValue.

The willSet block always stores the incoming value as newValue.
The didSet block always stores the previous value as oldValue.
To access these parameters, you do not need to declare them anywhere. They are automatically in your use.

For example:
```swift
var name: String = """"Alice"""" {
    willSet { print(""""Name will from \(name) to \(newValue)"""") }
    didSet { print(""""Name changed from \(oldValue) to \(name)"""")}
}
```
As you can see from the code, the newValue, and oldValue automatically referenced the name before and after the change.
Also we can change default variable with defined names;
```swift
var name: String = """"Alice"""" {
    willSet(newName) {
        print(""""Name will from \(name) to \(newName)"""")
    }
    didSet(oldName) {
        print(""""Name changed from \(oldName) to \(name)"""")
    }
}"""
```

---

## Types

Always use Swift's native types and expressions when available. Swift offers bridging to Objective-C so you can still use the full set of methods as needed.

**Preferred**:
```swift
let width = 120.0                                    // Double
let widthString = "\(width)"                         // String
```

**Less Preferred**:
```swift
let width = 120.0                                    // Double
let widthString = (width as NSNumber).stringValue    // String
```

**Not Preferred**:
```swift
let width: NSNumber = 120.0                          // NSNumber
let widthString: NSString = width.stringValue        // NSString
```

In drawing code, use `CGFloat` if it makes the code more succinct by avoiding too many conversions.

## Init Usage

### 1. Variable Declaration
Do not use '.init()' while assigning value to variable. Unit test variable declarations is an exception for this rule.

 **Preferred**:
 ```swift
 presenter = MyCellPresenter()
 ```

 **Not Preferred**:
 ```swift
 presenter: MyCellPresenter= .init()
 ```

### 2. Nested Statement
Prefer not to use use .init inside nested statements.

 **Preferred**:
 ```swift
 tracker.track(GRCAvailableTimeSlotsInstantNavigationEvents(arguments: EvenArgument(type: .click, screen: arguments.screen)))
 ```

 **Not Preferred**:
 ```swift
 tracker.track(GRCAvailableTimeSlotsInstantNavigationEvents(arguments: .init(type: .click, screen: arguments.screen)))
 ```

### 3. Convenience init
 Use convenience init if we have already one designated initializer.

### 4.Initializer Arguments
Don't omit parameter names for initializers, parameter name should be same as the variable its initializing.

 **Preferred**:
 ```swift
 struct BasketDiscountViewEvent: CoreTrackable {
     enum Action: String {    }

     let action: Action

     init(action: Action) {
         self.action = action
     }
 }
 ```

 **Not Preferred**:
 ```swift
 struct BasketDiscountViewEvent: CoreTrackable {
     enum Action: String {    }

     let action: Action

     init(_ eventAction: Action) {
          action = eventAction
     }
 }
 ```

### 5. Failable Initializers
Avoid failable initializers as much as possible.
---

### Constants

Constants are defined using the `let` keyword and variables with the `var` keyword. Always use `let` instead of `var` if the value of the variable will not change.

**Tip:** A good technique is to define everything using `let` and only change it to `var` if the compiler complains!

You can define constants on a type rather than on an instance of that type using type properties. To declare a type property as a constant simply use `static let`. Type properties declared in this way are generally preferred over global constants because they are easier to distinguish from instance properties. Example:

**Preferred**:
```swift
enum Math {
  static let e = 2.718281828459045235360287
  static let root2 = 1.41421356237309504880168872
}

let hypotenuse = side * Math.root2

```

**Note:** The advantage of using a case-less enumeration is that it can't accidentally be instantiated and works as a pure namespace.

**Not Preferred**:
```swift
let e = 2.718281828459045235360287  // pollutes global namespace
let root2 = 1.41421356237309504880168872

let hypotenuse = side * root2 // what is root2?
```

Use caseless enums for organizing **public** or **internal** constants and functions into namespaces. `SwiftFormat: enumNamespaces`

- Avoid creating non-namespaced global constants and functions.
- Feel free to nest namespaces where it adds clarity.
- **private** globals are permitted, since they are scoped to a single file and do not pollute the global namespace. Consider placing private globals in an **enum** namespace to match the guidelines for other declaration types.

For correct usage, We should use **enum** instead of **struct**. 

**Why?** Caseless `enums` work well as namespaces because they cannot be instantiated, which matches their intent.

**Preferred**:
```swift
struct Environment {
  struct Earth {
    static let gravity = 9.8
  }

  struct Moon {
    static let gravity = 1.6
  }
}
```

**Not Preferred**:
```swift
struct Environment {
  static let earthGravity = 9.8
  static let moonGravity = 1.6
}
```

**Note:** We should put constant under extension of class and class extension must be private

**Preferred**:
```swift
private extension AccountPresenter {
    enum Constant {
        enum Date {
            static let cobrandedOnboardingLastShownDateFormat: String = "yyyy-MM-dd"
        }

        enum URL {
            static let trendyolDeeplinkUrl = "ty://"
        }
 }
 ```
---

### Enums 
Omit enum associated values from case statements when all arguments are unlabeled. SwiftLint: **empty_enum_arguments**

**Not Preferred**:
```swift
if case .done(_) = result { ... }

switch animal {
case .dog(_, _, _):
  ...
}
```

**Preferred**:
```swift
if case .done = result { ... }

switch animal {
case .dog:
  ...
}
```
When destructuring an enum case or a tuple, place the let keyword inline, adjacent to each individual property assignment. SwiftFormat: **hoistPatternLet**

**Not Preferred**:
```swift
switch result {
case let .success(value):
  // ...
case let .error(errorCode, errorReason):
  // ...
}

// WRONG
guard let case .success(value) else {
  return
}
```

**Preferred**:
```swift
switch result {
case .success(let value):
  // ...
case .error(let errorCode, let errorReason):
  // ...
}

// RIGHT
guard case .success(let value) else {
  return
}
```

**Notes:**
Clarity: Inlining the let keyword makes it more clear which identifiers are part of the conditional check and which identifiers are binding new variables, since the let keyword is always adjacent to the variable identifier.
```swift
// `let` is adjacent to the variable identifier, so it is immediately obvious
// at a glance that these identifiers represent new variable bindings
case .enumCaseWithSingleAssociatedValue(let string):
case .enumCaseWithMultipleAssociatedValues(let string, let int):

// The `let` keyword is quite far from the variable identifiers,
// so it is less obvious that they represent new variable bindings
case let .enumCaseWithSingleAssociatedValue(string):
case let .enumCaseWithMultipleAssociatedValues(string, int):
```
##### Enum Namespaces
Use caseless enums for organizing public or internal constants and functions into namespaces. SwiftFormat: **enumNamespaces**
  
 + Avoid creating non-namespaced global constants and functions.  
 + Feel free to nest namespaces where it adds clarity.  
 + private globals are permitted, since they are scoped to a single file and do not pollute the global namespace. Consider placing private globals in an enum namespace to match the guidelines for other declaration types.  
    
Caseless enums work well as namespaces because they cannot be instantiated, which matches their intent.  
  
**Not Preferred**:
```swift
struct Environment {  
    static let earthGravity = 9.8  
    static let moonGravity = 1.6  
}  
  
// WRONG  
struct Environment {  
  struct Earth {  
    static let gravity = 9.8  
  }  
  
  struct Moon {  
    static let gravity = 1.6  
  }  
} 
```  
**Not Preferred**:
```swift
// RIGHT  
enum Environment {  
  enum Earth {  
    static let gravity = 9.8  
  }  
  
  enum Moon {  
    static let gravity = 1.6  
  }  
}
``` 

Use Swift's automatic enum values unless they map to an external source. Add a comment explaining why explicit values are defined. SwiftFormat: **redundantRawValues**
  
Why?  
To minimize user error, improve readability, and write code faster, rely on Swift's automatic enum values. If the value maps to an external source (e.g. it's coming from a network request) or is persisted across binaries, however, define the values explicitly, and document what these values are mapping to.  
  
This ensures that if someone adds a new value in the middle, they won't accidentally break things.  
  
  **Not Preferred**:
```swift
// WRONG  
enum ErrorType: String {  
  case error = "error"  
  case warning = "warning"  
}  
  
// WRONG  
enum UserType: String {  
  case owner  
  case manager  
  case member  
}  
  
// WRONG  
enum Planet: Int {  
  case mercury = 0  
  case venus = 1  
  case earth = 2  
  case mars = 3  
  case jupiter = 4  
  case saturn = 5  
  case uranus = 6  
  case neptune = 7  
}  
  
// WRONG  
enum ErrorCode: Int {  
  case notEnoughMemory  
  case invalidResource  
  case timeOut  
}  
``` 
  **Preferred**:
```swift
// RIGHT  
// Relying on Swift's automatic enum values  
enum ErrorType: String {  
  case error  
  case warning  
}  
  
// RIGHT  
/// These are written to a logging service. Explicit values ensure they're consistent across binaries.  
// swiftformat:disable redundantRawValues  
enum UserType: String {  
  case owner = "owner"  
  case manager = "manager"  
  case member = "member"  
}  
// swiftformat:enable redundantRawValues  
  
// RIGHT  
// Relying on Swift's automatic enum values  
enum Planet: Int {  
  case mercury  
  case venus  
  case earth  
  case mars  
  case jupiter  
  case saturn  
  case uranus  
  case neptune  
}  
  
// RIGHT  
/// These values come from the server, so we set them here explicitly to match those values.  
enum ErrorCode: Int {  
  case notEnoughMemory = 0  
  case invalidResource = 1  
  case timeOut = 2  
}
``` 

Dont use the default case when switching over an enum.  
  
Why?  
Enumerating every case requires developers and reviewers have to consider the correctness of every switch statement when new cases are added.  
  **Preferred**:
```swift 
switch anEnum {  
case .a:  
// Do something  
default:  
// Do something else.  
}  
```
  **Preferred**:
```swift 
switch anEnum {  
case .a:  
// Do something  
case .b, .c:  
// Do something else.  
}  
```
  When all cases of an `enum` must be `indirect`, the `enum` itself is declared `indirect` and the keyword is omitted on the individual cases.
  
**Preferred**:
```swift 
public indirect enum DependencyGraphNode {  
  case userDefined(dependencies: [DependencyGraphNode])  
  case synthesized(dependencies: [DependencyGraphNode])  
}  
```
**Not Preferred**:
```swift 
public enum DependencyGraphNode {  
  indirect case userDefined(dependencies: [DependencyGraphNode])  
  indirect case synthesized(dependencies: [DependencyGraphNode])  
} 
```
When an enum case does not have associated values, empty parentheses are never present.  

 **Preferred**:
```swift 
public enum BinaryTree<Element> {  
  indirect case node(element: Element, left: BinaryTree, right: BinaryTree)  
  case empty // GOOD.  
}
```
**Not Preferred**:
```swift 
public enum BinaryTree<Element> {  
  indirect case node(element: Element, left: BinaryTree, right: BinaryTree)  
  case empty() // AVOID.  
}
```
In general, there is only one case per line in an enum. The comma-delimited form may be used only when none of the cases have associated values or raw values, all cases fit on a single line, and the cases do not need further documentation because their meanings are obvious from their names.  

 **Not Preferred**:
```swift 
public enum Token {  
  case comma  
  case semicolon  
  case identifier  
}  
  
public enum Token {  
  case comma, semicolon, identifier  
}  
  
public enum Token {  
  case comma  
  case semicolon  
  case identifier(String)  
}  
```
 
 **Not Preferred**:
```swift 
public enum Token {  
  case comma, semicolon, identifier(String)  
}  
```
  
The cases of an enum must follow a logical ordering that the author could explain if asked. If there is no obviously logical ordering, use a lexicographical ordering based on the cases’ names.

In the following example, the cases are arranged in numerical order based on the underlying HTTP status code and blank lines are used to separate groups.

 **Preferred**:
```swift 
public enum HTTPStatus: Int {
  case ok = 200

  case badRequest = 400
  case notAuthorized = 401
  case paymentRequired = 402
  case forbidden = 403
  case notFound = 404

  case internalServerError = 500
}

```

The following version of the same enum is less readable. Although the cases are ordered lexicographically, the meaningful groupings of related values has been lost.

 **Not Preferred**:
```swift 
public enum HTTPStatus: Int {
  case badRequest = 400
  case forbidden = 403
  case internalServerError = 500
  case notAuthorized = 401
  case notFound = 404
  case ok = 200
  case paymentRequired = 402
}
```

`Enum` naming should not be plural, it should be `singular`

**Preferred**:
```swift
public enum Token {
  case comma
  case semicolon
  case identifier
}
```
**Not Preferred**:
```swift
public enum Tokens {
  case comma
  case semicolon
  case identifier
}
```

### Typealiases

Long type aliases of protocol compositions should wrap before the = and before each individual &. SwiftFormat: wrapArguments

**Not Preferred**:
```swift
// WRONG (too long)
public typealias Dependencies = CivilizationServiceProviding & LawsOfPhysicsProviding & PlanetBuilderProviding & UniverseBuilderProviding & UniverseSimulatorServiceProviding

// WRONG (naive wrapping)
public typealias Dependencies = CivilizationServiceProviding & LawsOfPhysicsProviding & PlanetBuilderProviding &
  UniverseBuilderProviding & UniverseSimulatorServiceProviding

// WRONG (unbalanced)
public typealias Dependencies = CivilizationServiceProviding
  & LawsOfPhysicsProviding
  & PlanetBuilderProviding
  & UniverseBuilderProviding
  & UniverseSimulatorServiceProviding
```
**Preferred**:
```swift
public typealias Dependencies
  = CivilizationServiceProviding
  & LawsOfPhysicsProviding
  & PlanetBuilderProviding
  & UniverseBuilderProviding
  & UniverseSimulatorServiceProviding
```

Sort protocol composition type aliases alphabetically. SwiftFormat: sortTypealiases

Protocol composition type aliases are an unordered list with no natural ordering. Sorting alphabetically keeps these lists more organized, which is especially valuable for long protocol compositions.

**Not Preferred**:
```swift
// WRONG (not sorted)
public typealias Dependencies
  = UniverseBuilderProviding
  & LawsOfPhysicsProviding
  & UniverseSimulatorServiceProviding
  & PlanetBuilderProviding
  & CivilizationServiceProviding
```
**Preferred**:
```swift
// RIGHT
public typealias Dependencies
  = CivilizationServiceProviding
  & LawsOfPhysicsProviding
  & PlanetBuilderProviding
  & UniverseBuilderProviding
  & UniverseSimulatorServiceProviding
```

If a function returns multiple values, prefer returning a tuple to using inout arguments (it’s best to use labeled tuples for clarity on what you’re returning if it is not otherwise obvious). If you use a certain tuple more than once, consider using a typealias. If you’re returning 3 or more items in a tuple, consider using a struct or class instead.

**Not Preferred**:
```swift
func pirateName() -> (firstName: String, lastName: String, age: Int) {
    return ("Guybrush", "Threepwood", 32)
}

let name = pirateName()
let firstName = name.firstName
let lastName = name.lastName
```
**Preferred**:
```swift
func pirateName() -> (firstName: String, lastName: String) {
    return ("Guybrush", "Threepwood")
}

let name = pirateName()
let firstName = name.firstName
let lastName = name.lastName

typealias UserInfo = (firstName: String, lastName: String, age: Int)

func pirateName() -> UserInfo {
    return ("Guybrush", "Threepwood", 23)
}

let name = pirateName()
let firstName = name.firstName
let lastName = name.lastName
```

Typealias declaration is used only for the sake of brevity when it doesn't prevent clarity.

**Not Preferred**:
```swift
typealias T = (Int, Int) -> (String)
func process(task: T) -> String
```

**Preferred**:
```swift
typealias Task = (_ token: Sting) -> (_ result: Result<Data, Error>)
func enqueue(task: Task)
```

### Type Inference
___

Prefer compact code and let the compiler infer the type for constants or variables of single instances. Type inference is also appropriate for small, non-empty arrays and dictionaries. When required, specify the specific type such as `CGFloat` or `Int16`.

**Preferred:**

```swift
let message = "Click the button"
let currentBounds = computeViewBounds()
var names = ["Mic", "Sam", "Christine"]
let maximumWidth: CGFloat = 106.5
```

**Not Preferred:**

```swift
let message: String = "Click the button"
let currentBounds: CGRect = computeViewBounds()
var names = [String]()
```

## Type Annotation for Empty Arrays and Dictionaries

For empty arrays and dictionaries, use type annotation. For an array or dictionary assigned to a large, multi-line literal, use type annotation.

**Preferred:**

```swift
var names: [String] = []
var lookup: [String: Int] = [:]
```

**Not Preferred:**

```swift
var names = [String]()
var lookup = [String: Int]()
```

Prefer the shortcut versions of type declarations over the full generics syntax.

**Preferred:**

```swift
var deviceModels: [String]
var employees: [Int: String]
var faxNumber: Int?
```
**Not Preferred:**

```swift
var deviceModels: Array<String>
var employees: Dictionary<Int, String>
var faxNumber: Optional<Int>
```
___

## Access Control

#### 1. General
Omitting an explicit access level is permitted on declarations. For top-level declarations, the default access level is internal. For nested declarations, the default access level is the lesser of internal and the access level of the enclosing declaration. The default access modifier, namely internal, is not specified explicitly (as well as any other default, in general). class type members are rarely useful because of discouraged use of inheritance, especially for static members. An engineer must be aware of the use-cases of class and static modifiers (confusing them is a common mistake.) Generally, encapsulation is honored in any way. E.g., @IBOutlet properties and @IBAction methods are always private. Implementation details are hidden behind meaningful API. 3.2.2 The access modifier keyword should not be on a line by itself - keep it inline with what it is describing.

**Not Preferred**:
```swift
open class Pirate { /* ... */ }
```

**Preferred**:
```swift
open class Pirate { /* ... */ }
```

#### 2. RedundantInternal

Omit the internal keyword when defining types, properties, or functions with an internal access control level.

**Not Preferred**:
```swift
internal class Spaceship {
 internal init() { … } 
 internal func travel(to planet: Planet) { … }
 }
 ```
 
**Preferred**:
Because internal access control is implied if no other access control level is specified.
```swift

class Spaceship { 
     init() { … } 
     func travel(to planet: Planet) { … }
 }
```

#### 3. RedundantFileprivate

Access control should be at the strictest level possible. Prefer public to open and private to fileprivate unless you need that behavior.

**Not Preferred**:
```swift
public struct Spaceship {
 // WRONG: `engine` is used in `extension Spaceship` below, 
 // but extensions in the same file can access `private` members. 
 fileprivate let engine: AntimatterEngine 

// WRONG: `hull` is not used by any other type, so `fileprivate` is unnecessary.
 fileprivate let hull: Hull
```

```swift
extension Spaceship { 
public func blastOff() { 
        engine.start() 
    } 
}
 extension Pilot { 
 public func chartCourse() {
          spaceship.navigation.course = .andromedaGalaxy spaceship.blastOff() 
      } 
 }
```
**Preferred**:
Because internal access control is implied if no other access control level is specified.
```swift
// RIGHT: `navigation` is used in `extension Pilot` below,
// so `fileprivate` is necessary here. 
 fileprivate let navigation: SpecialRelativityNavigationService
 
public struct Spaceship { 
    fileprivate let navigation: SpecialRelativityNavigationService 
    private let engine: AntimatterEngine 
    private let hull: Hull 
}

extension Spaceship { 
 public func blastOff() { 
         engine.start() 
     } 
 } 

extension Pilot { 
public func chartCourse() {
     spaceship.navigation.course = .andromedaGalaxy spaceship.blastOff()
  }
}
```

#### 4. ExtensionAccessControl
Specifying an explicit access level at the file level on an extension is forbidden. Each member of the extension has its access level specified if it is different than the default.

**Not Preferred**:
```swift
public extension String {
     var isUppercase: Bool {
      // ... 
      }
     var isLowercase: Bool {
      // ... 
      } 
}
```

**Preferred**:
```swift
extension String {
    public var isUppercase: Bool {
      // ... 
    } 
    public var isLowercase: Bool {
      // ... 
    } 
}
```

#### 5. Access
Use access control as the leading property specifier. The only things that should come before access control are the static specifier or attributes such as @IBAction, @IBOutlet and @discardableResult. 3.2.1 Write the access modifier keyword first if it is needed. 

**Not Preferred**:
```swift
static private let myPrivateNumber: Int
```

**Preferred**:
```swift
private static let myPrivateNumber: Int

```

## Control Flow

Prefer the `for-in` style of `for` loop over the `while-condition-increment` style.

**Preferred**:
```swift
for _ in 0..<3 {
  print("Hello three times")
}

for (index, person) in attendeeList.enumerated() {
  print("\(person) is at position #\(index)")
}

for index in stride(from: 0, to: items.count, by: 2) {
  print(index)
}

for index in (0...3).reversed() {
  print(index)
}
```

**Not Preferred**:
```swift
var i = 0
while i < 3 {
  print("Hello three times")
  i += 1
}


var i = 0
while i < attendeeList.count {
  let person = attendeeList[i]
  print("\(person) is at position #\(i)")
  i += 1
}
```

### Ternary Operator

* Long ternary operator expressions should wrap before the ? and before the :, putting each conditional branch on a separate line. SwiftFormat: wrap

**Preferred**:

```swift
let destinationPlanet = solarSystem.hasPlanetsInHabitableZone
  ? solarSystem.planetsInHabitableZone.first
  : solarSystem.uninhabitablePlanets.first

let value = 5
result = value != 0 ? x : y

let isHorizontal = true
result = isHorizontal ? x : y
```

**Not Preferred**:
```swift
// WRONG (too long)

 let destinationPlanet = solarSystem.hasPlanetsInHabitableZone ? solarSystem.planetsInHabitableZone.first : solarSystem.uninhabitablePlanets.first
 let result = a > b ? x = c > d ? c : d : y
 
// WRONG (naive wrapping) 
let destinationPlanet = solarSystem.hasPlanetsInHabitableZone ? solarSystem.planetsInHabitableZone.first : solarSystem.uninhabitablePlanets.first 

// WRONG (unbalanced operators) 
let destinationPlanet = solarSystem.hasPlanetsInHabitableZone ? solarSystem.planetsInHabitableZone.first : solarSystem.uninhabitablePlanets.first
```

* If we have huge logic and code, we should use if condition instead of ternary operator


```swift
let result: Bool

if IamOldIfElse { 
     result = true 
} else {
    result = false 
}
```

* By using ternary operator, we were able to get rid of many lines of code. But some developers find the ternary operator hard to read so for those, Swift 5.9 improved the if else statement to be on one single line for the single statements:

**Not Preferred**:
```swift
let result = IamTernary ? true : false
```

**Preferred**:
```swift
let result = if IamNewIfElse { true } else { false }

```

---

### Switch Statements

One level of indentation is used inside a `switch`'s parentheses and for `case` implementations.
All statements inside the cases of a `switch` statement start on separate lines.

**Preferred**:

```swift
switch direction {
    case .left:
        turnLeft()
    case .right:
        turnRight():
    case .straight:
        break
}
```

**Not Preferred**:

```swift
switch direction {
    case .left: turnLeft()
    case .right: turnRight()
    case .straight: break
}
```

### Else Statements
**Preferred**:
```swift
if let galaxy {
  …
} else if let bigBangService {
  …
} else {
  …
}
```

**Not Preferred**:
```swift
if let galaxy {
  …
}
else if let bigBangService {
  …
}
else {
  …
}
```

### Golden Path

When coding with conditionals, the left-hand margin of the code should be the "golden" or "happy" path. That is, don't nest `if` statements. Multiple return statements are OK. The `guard` statement is built for this.

**Preferred**:
```swift
func computeFFT(context: Context?, inputData: InputData?) throws -> Frequencies {
  guard let context = context else {
    throw FFTError.noContext
  }
  guard let inputData = inputData else {
    throw FFTError.noInputData
  }

  // use context and input to compute the frequencies
  return frequencies
}
```

**Not Preferred**:
```swift
func computeFFT(context: Context?, inputData: InputData?) throws -> Frequencies {
  if let context = context {
    if let inputData = inputData {
      // use context and input to compute the frequencies

      return frequencies
    } else {
      throw FFTError.noInputData
    }
  } else {
    throw FFTError.noContext
  }
}
```

When multiple optionals are unwrapped either with `guard` or `if let`, minimize nesting by using the compound version when possible. In the compound version, place the `guard` on its own line, then indent each condition on its own line. The `else` clause is indented to match the `guard` itself, as shown below. Example:

**Preferred**:
```swift
guard 
  let number1 = number1,
  let number2 = number2,
  let number3 = number3 
else {
  fatalError("impossible")
}
// do something with numbers
```

**Not Preferred**:
```swift
if let number1 = number1 {
  if let number2 = number2 {
    if let number3 = number3 {
      // do something with numbers
    } else {
      fatalError("impossible")
    }
  } else {
    fatalError("impossible")
  }
} else {
  fatalError("impossible")
}
```

In any `guard`-statement, the `else` (and its left brace) goes on the same line after the last condition.

**Preferred**:
```swift
guard !array.isEmpty else {
    // ...
```

**Not Preferred**:
```swift
guard !array.isEmpty 
    else {
    // ...
```

#### Failing Guards

Guard statements are required to exit in some way. Generally, this should be simple one line statement such as `return`, `throw`, `break`, `continue`, and `fatalError()`. Large code blocks should be avoided. If cleanup code is required for multiple exit points, consider using a `defer` block to avoid cleanup code duplication.

#### Omit the right-hand side of the expression

**Preferred**:
```swift
if let galaxy,
    galaxy.name == "Milky Way" { 
… 
}

guard let galaxy,
          galaxy.name == "Milky Way" else { … }
```

**Not Preferred**:
```swift
if let galaxy = galaxy,
    galaxy.name == "Milky Way" { 
… 
}

guard let galaxy = galaxy,
          galaxy.name == "Milky Way" else { … }
```

#### Add a line break after the assignment operator (=) before a multi-line if or switch expression

**Preferred**:
```swift
let planetLocation = 
  if let star = planet.star {
    "The \(star.name) system"
  } else {
    "Rogue planet"
  }
  
let planetType: PlanetType =
  switch planet {
  case .mercury, .venus, .earth, .mars:
    .terrestrial
  case .jupiter, .saturn, .uranus, .neptune:
    .gasGiant
  }
```

**Not Preferred**:
```swift
// Should have a line break after the first `=`. 
let planetLocation = if let star = planet.star {
  "The \(star.name) system"
 } else {
  "Rogue planet"
}

// The first `=` should be on the line of the variable being assigned.
let planetLocation 
  = if let star = planet.star {
    "The \(star.name) system"
  } else {
    "Rogue planet"
  }

// `switch` expression should be indented.
let planetLocation =
switch planet {
case .mercury, .venus, .earth, .mars:
  .terrestrial
case .jupiter, .saturn, .uranus, .neptune:
  .gasGiant
}
```

#### Insert a blank line following a switch case with a multi-line body

**Preferred**:
```swift
// All of the cases have a trailing blank line.
func handle(_ action: SpaceshipAction) {
  switch action {
  case .engageWarpDrive:
    navigationComputer.destination = targetedDestination
    warpDrive.spinUp()
    warpDrive.activate()

  case .enableArtificialGravity:
    artificialGravityEngine.enable(strength: .oneG)

  case .scanPlanet(let planet):
    scanner.target = planet
    scanner.scanAtmosphere()
    scanner.scanBiosphere()
    scanner.scanForArtificialLife()
    
  case .handleIncomingEnergyBlast:
    energyShields.engage()
  }
}

// Since none of the cases are multi-line, blank lines are not required.
func handle(_ action: SpaceshipAction) {
  switch action {
  case .engageWarpDrive:
      warpDrive.engage()
  case .enableArtificialGravity:
      artificialGravityEngine.enable(strength: .oneG)
  case .scanPlanet(let planet):
      scanner.scan(planet)
  case .handleIncomingEnergyBlast:
      energyShields.engage()
  }
}
```

**Not Preferred**:
```swift
// These switch cases should be followed by a blank line.
func handle(_ action: SpaceshipAction) {
  switch action {
  case .engageWarpDrive:
    navigationComputer.destination = targetedDestination
    warpDrive.spinUp()
    warpDrive.activate()
  case .enableArtificialGravity:
    artificialGravityEngine.enable(strength: .oneG)
  case .scanPlanet(let planet):
    scanner.target = planet
    scanner.scanAtmosphere()
    scanner.scanBiosphere()
    scanner.scanForArtificialLife()
  case .handleIncomingEnergyBlast:
    energyShields.engage()
  }
}

// While the `.enableArtificialGravity` case isn't multi-line, the other cases are.
// For consistency, it should also include a trailing blank line.
func handle(_ action: SpaceshipAction) {
  switch action {
  case .engageWarpDrive:
    navigationComputer.destination = targetedDestination
    warpDrive.spinUp()
    warpDrive.activate()

  case .enableArtificialGravity:
    artificialGravityEngine.enable(strength: .oneG)
  case .scanPlanet(let planet):
    scanner.target = planet
    scanner.scanAtmosphere()
    scanner.scanBiosphere()
    scanner.scanForArtificialLife()
    
  case .handleIncomingEnergyBlast:
    energyShields.engage()
  }
}
```

## Multi-line String Literals

When building a long string literal, you're encouraged to use the multi-line string literal syntax. Open the literal on the same line as the assignment but do not include text on that line. Indent the text block one additional level.

**Preferred**:

```swift
let message = """
  You cannot charge the flux \
  capacitor with a 9V battery.
  You must use a super-charger \
  which costs 10 credits. You currently \
  have \(credits) credits available.
  """
```

**Not Preferred**:

```swift
let message = """You cannot charge the flux \
  capacitor with a 9V battery.
  You must use a super-charger \
  which costs 10 credits. You currently \
  have \(credits) credits available.
  """
```

**Not Preferred**:

```swift
let message = "You cannot charge the flux " +
  "capacitor with a 9V battery.\n" +
  "You must use a super-charger " +
  "which costs 10 credits. You currently " +
  "have \(credits) credits available."
```
## Line breaks

Long expressions are broken into several parts on different lines so that the symbol that connects two parts of expression starts the new line. Each new line is indented with one additional indentation level. Having a special character starting a new line avoids creating the illusion that a new line is a new statement.

**Preferred**:
```swift
let a = (a + b)
    + (a + c)
```

**Not Preferred**:
```swift
let a = (a + b) +
    (a + c)
```

## Pre-processor Directives

Any macros shall not be indented, the surrounded code shall be formatted as if the macro doesn't exist.

**Preferred**:
```swift
func handleLogin() {
#if DEBUG
    printDebugInfo()
#endif
    openHomeScreen()
}
```

**Not Preferred**:
```swift
func handleLogin() {
    #if DEBUG
        printDebugInfo()
    #endif
    openHomeScreen()
}
``` 

## References

* [The Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
* [Airbnb Swift Style Guide](https://github.com/airbnb/swift)
* [Google Swift Style Guide](https://google.github.io/swift/)
* [Kodecocodes Swift Style Guide](https://github.com/kodecocodes/swift-style-guide)
* [Linkedin Swift Style Guide](https://github.com/linkedin/swift-style-guide)
* [Ultimate Swift Code Style Guidelines](https://github.com/lazarevzubov/Ultimate-Swift-Code-Style-Guidelines)
