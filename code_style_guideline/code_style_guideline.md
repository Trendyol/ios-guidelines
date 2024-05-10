# The Official Kodeco Swift Style Guide.
### Updated for Swift 5

This style guide is different from others you may see, because the focus is centered on readability for print and the web. We created this style guide to keep the code in our books, tutorials, and starter kits nice and consistent — even though we have many different authors working on the books.

Our overarching goals are clarity, consistency and brevity, in that order.

## Table of Contents

* [Correctness](#correctness)
* [Using SwiftLint](#using-swiftlint)
* [Naming](#naming)
  * [Prose](#prose)
  * [Variables](#variables)
  * [Methods](#methods)
  * [Delegates](#delegates)
  * [Interface](#interface)
  * [Use Type Inferred Context](#use-type-inferred-context)
  * [Generics](#generics)
  * [Class and Structs](#class-struct)
  * [Language](#language)
* [Code Organization](#code-organization)
  * [Protocol Conformance](#protocol-conformance)
  * [Unused Code](#unused-code)
  * [Minimal Imports](#minimal-imports)
* [Spacing & New Line](#spacing-and-new-line)
* [Comments](#comments)
* [Explicit Documentation](#explicit-documentation)
* [Classes and Structures](#classes-and-structures)
  * [Use of Self](#use-of-self)
  * [Protocol Conformance](#protocol-conformance)
  * [Computed Properties](#computed-properties)
  * [Final](#final)
* [Function Declarations](#function-declarations)
* [Function Calls](#function-calls)
* [Closure Expressions](#closure-expressions)
* [Types](#types)
  * [Initialization](#initialization)
  * [Constants](#constants)
  * [Static Methods and Variable Type Properties](#static-methods-and-variable-type-properties)
  * [Optionals](#optionals)
  * [Enums](#enums)
  * [Lazy Initialization](#lazy-initialization)
  * [Type Inference](#type-inference)
  * [Syntactic Sugar](#syntactic-sugar)
* [Functions vs Methods](#functions-vs-methods)
* [Memory Management](#memory-management)
  * [Extending Object Lifetime](#extending-object-lifetime)
* [Access Control](#access-control)
* [Control Flow](#control-flow)
  * [Ternary Operator](#ternary-operator)
  * [Switch Statements](#switch-statements)
* [Golden Path](#golden-path)
  * [Failing Guards](#failing-guards)
* [Semicolons](#semicolons)
* [Parentheses](#parentheses)
* [Multi-line String Literals](#multi-line-string-literals)
* [Pre-processor Directives](#pre-processor-directives)
* [No Emoji](#no-emoji)
* [No #imageLiteral or #colorLiteral](#no-imageliteral-or-colorliteral)
* [Organization and Bundle Identifier](#organization-and-bundle-identifier)
* [Copyright Statement](#copyright-statement)
* [Smiley Face](#smiley-face)
* [References](#references)


## Correctness

Strive to make your code compile without warnings. This rule informs many style decisions such as using `#selector` types instead of string literals.

## Using SwiftLint

When writing for Kodeco, you are strongly encouraged — perhaps even required, depending on your team — to use our SwiftLint configuration. See the [SwiftLint Policy](SWIFTLINT.markdown) for more information.

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

### Prose

When referring to methods in prose, being unambiguous is critical. To refer to a method name, use the simplest form possible.

1. Write the method name with no parameters.  **Example:** Next, you need to call `addTarget`.
2. Write the method name with argument labels.  **Example:** Next, you need to call `addTarget(_:action:)`.
3. Write the full method name with argument labels and types. **Example:** Next, you need to call `addTarget(_: Any?, action: Selector?)`.

For the above example using `UIGestureRecognizer`, 1 is unambiguous and preferred.

**Pro Tip:** You can use Xcode's jump bar to lookup methods with argument labels. If you’re particularly good at mashing lots of keys simultaneously, put the cursor in the method name and press **Shift-Control-Option-Command-C** (all 4 modifier keys) and Xcode will kindly put the signature on your clipboard.

![Methods in Xcode jump bar](screens/xcode-jump-bar.png)

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

### Class Prefixes

Swift types are automatically namespaced by the module that contains them and you should not add a class prefix such as RW. If two names from different modules collide you can disambiguate by prefixing the type name with the module name. However, only specify the module name when there is possibility for confusion, which should be rare.

```swift
import SomeModule

let myClass = MyModule.UsefulClass()
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

It's very common to force engineers to put an object of delegation as the first argument of delegation methods. This is not strictly necessary and is used only in cases when it makes sense.

**Preferred**:
```
func buttonTapped(_ button: UIButton)
```

**Not Preferred**:
```swift
func screen(_ screen: UIViewController, hasButtonTapped button: UIButton)
```

UIKit's UIControl actions are called with the control's name in the beginning and the "action" word in the end:

**Preferred**:
```
@objc
private func nextButtonTapped(_ sender: UIButton) { // ...
```

**Not Preferred**:
```swift
@objc
private func nextButtonAction(_ sender: UIButton) { // ...
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

### Use Type Inferred Context

Use compiler inferred context to write shorter, clear code.  (Also see [Type Inference](#type-inference).)

**Preferred**:
```swift
let selector = #selector(viewDidLoad)
view.backgroundColor = .red
let toView = context.view(forKey: .to)
let view = UIView(frame: .zero)
```

**Not Preferred**:
```swift
let selector = #selector(ViewController.viewDidLoad)
view.backgroundColor = UIColor.red
let toView = context.view(forKey: UITransitionContextViewKey.to)
let view = UIView(frame: CGRect.zero)
```

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

### Class and Structs
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

Don't use "controller" and "interface" suffixes for mock naming.

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


## Code Organization

Use extensions to organize your code into logical blocks of functionality. Each extension should be set off with a `// MARK: -` comment to keep things well-organized.

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

### Minimal Imports

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

* Also, Indent using 2 spaces rather than tabs to conserve space and help prevent line wrapping. Be sure to set this preference in Xcode and in the Project settings as shown below:

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
    
-   Closing parentheses should not appear on a line by themselves. // TODO: - We should talk about this issue again

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

// TODO: **We should talk about this issue again**

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

When they are needed, use comments to explain **why** a particular piece of code does something. Comments must be kept up-to-date or deleted.

Avoid block comments inline with code, as the code should be as self-documenting as possible. _Exception: This does not apply to those comments used to generate documentation._

If a commented code is changed, the comments shall be either updated or deleted.

One-line comments start with `\\` (although `\\\` makes comments look "fancier" in IDE, it's reserved for HeaderDoc.)

Multi-line comments start with `\*` and end with `*\`. Comment delimiters are placed on separate lines. There's no blank lines after symbols denoting the beginning of comment and before ones at the end.

Comments, both single- and multi-line, are placed on the line above the commented code and separated from a preceding code by a blank line. The latter is not relevant if a comment is the first line of the scope. Also, it's acceptable to place one-line comments at the end of the commented line of code, separating by a space, if and only if the comment doesn't make this line too long.

## Explicit Documentation

Each non-private API should have a [HeaderDoc](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/HeaderDoc/intro/intro.html) comment, even if the API is well self-documented. The main assignment of having exhaustive documentation of public APIs is to be visible from different code base places through IDE's help features, such as quick help popovers.

Private APIs should be self-documented and have no explicit documentation in order not to distract from reading implementation details.

Indicating a method's time complexity in documentation generally is a good idea, unless irrelevant.

The basic structure of multi-line descriptions:

**Preferred**:
```swift
/// Summary.
///
/// Detailed description.
///
/// - Parameters:
///     - parameter parameter1: Parameter description.
///     - parameter parameter2: Parameter description.
/// - Returns: Return value description.
/// - Throws: Exception description.
```
Multi-line documentation put between `/**` and `*/ `is not used, because the former way is generated by Xcode by default and it's shorter.

**Not Preferred**:
```swift
/**
Summary.

Detailed description.

- Parameter parameter1: Parameter description.
- Parameter parameter2: Parameter description.
- returns: Return value description.
- Throws: Exception description.
*/
```

Though, if a method has any parameters, they are necessary to be documented. A single parameter must be documented as - Parameter: Description. Multiple parameters shall be documented by the help of - Parameters: syntax. If the method has functions as parameters, their arguments must have labels and be documented, as well.

If a method's return value type is not Void, it should be documented.

If a method throws an exception, the exception is documented with Throws.

Two HeaderDoc parts are divided by a single blank line. However, if there's no description, blank lines are omitted:

**Preferred**:
```swift
// Summary.
// - Parameter parameter: Parameter description.
// - Returns: Return value description.
// - Throws: Exception description.
``` 

**Not Preferred**:
```swift
// Summary.
//
// - Parameter parameter: Parameter description.
//
// - Returns: Return value description.
//
// - Throws: Exception description.
```

## Classes and Structures

### Which one to use?

Remember, structs have [value semantics](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_144). Use structs for things that do not have an identity. An array that contains [a, b, c] is really the same as another array that contains [a, b, c] and they are completely interchangeable. It doesn't matter whether you use the first array or the second, because they represent the exact same thing. That's why arrays are structs.

Classes have [reference semantics](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_145). Use classes for things that do have an identity or a specific life cycle. You would model a person as a class because two person objects are two different things. Just because two people have the same name and birthdate, doesn't mean they are the same person. But the person's birthdate would be a struct because a date of 3 March 1950 is the same as any other date object for 3 March 1950. The date itself doesn't have an identity.

Sometimes, things should be structs but need to conform to `AnyObject` or are historically modeled as classes already (`NSDate`, `NSSet`). Try to follow these guidelines as closely as possible.

### Example definition

Here's an example of a well-styled class definition:

```swift
class Circle: Shape {
  var x: Int, y: Int
  var radius: Double
  var diameter: Double {
    get {
      return radius * 2
    }
    set {
      radius = newValue / 2
    }
  }

  init(x: Int, y: Int, radius: Double) {
    self.x = x
    self.y = y
    self.radius = radius
  }

  convenience init(x: Int, y: Int, diameter: Double) {
    self.init(x: x, y: y, radius: diameter / 2)
  }

  override func area() -> Double {
    return Double.pi * radius * radius
  }
}

extension Circle: CustomStringConvertible {
  var description: String {
    return "center = \(centerString) area = \(area())"
  }
  private var centerString: String {
    return "(\(x),\(y))"
  }
}
```

The example above demonstrates the following style guidelines:

 + Specify types for properties, variables, constants, argument declarations and other statements with a space after the colon but not before, e.g. `x: Int`, and `Circle: Shape`.
 + Define multiple variables and structures on a single line if they share a common purpose / context.
 + Indent getter and setter definitions and property observers.
 + Don't add modifiers such as `internal` when they're already the default. Similarly, don't repeat the access modifier when overriding a method.
 + Organize extra functionality (e.g. printing) in extensions.
 + Hide non-shared, implementation details such as `centerString` inside the extension using `private` access control.

### Use of Self

For conciseness, avoid using `self` since Swift does not require it to access an object's properties or invoke its methods.

Use self only when required by the compiler (in `@escaping` closures, or in initializers to disambiguate properties from arguments). In other words, if it compiles without `self` then omit it.


### Computed Properties

For conciseness, if a computed property is read-only, omit the get clause. The get clause is required only when a set clause is provided.

**Preferred**:
```swift
var diameter: Double {
  return radius * 2
}
```

**Not Preferred**:
```swift
var diameter: Double {
  get {
    return radius * 2
  }
}
```

### Final

Default classes to final. 

Details Why? If a class needs to be overridden, the author should opt into that functionality by omitting the final keyword.

**Not Preferred**:
```swift
class SettingsRepository { // ... }
```
**Preferred**:
```swift
final class SettingsRepository { // ... }
```

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

## Closure Expressions

Use trailing closure syntax only if there's a single closure expression parameter at the end of the argument list. Give the closure parameters descriptive names.

**Preferred**:
```swift
UIView.animate(withDuration: 1.0) {
  self.myView.alpha = 0
}

UIView.animate(withDuration: 1.0, animations: {
  self.myView.alpha = 0
}, completion: { finished in
  self.myView.removeFromSuperview()
})
```

**Not Preferred**:
```swift
UIView.animate(withDuration: 1.0, animations: {
  self.myView.alpha = 0
})

UIView.animate(withDuration: 1.0, animations: {
  self.myView.alpha = 0
}) { f in
  self.myView.removeFromSuperview()
}
```

For single-expression closures where the context is clear, use implicit returns:

```swift
attendeeList.sort { a, b in
  a > b
}

array
    .filter { $0 > 0 }
    .sort { $0 > $1 }
    .map { Int($0) }
```

**Not Preferred**:
```swift
array.filter { $0 > 0 }
    .sort { $0 > $1 }.map { Int($0) }
```

Chained methods using trailing closures should be clear and easy to read in context. Decisions on spacing, line breaks, and when to use named versus anonymous arguments is left to the discretion of the author. Examples:

```swift
let value = numbers.map { $0 * 2 }.filter { $0 % 3 == 0 }.index(of: 90)

let value = numbers
  .map {$0 * 2}
  .filter {$0 > 50}
  .map {$0 + 10}
```

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

##  Initialization

If the initial or constant value of a property doesn't depend on the initializer's parameters, a default value is preferred over setting it within the initialization code.

`.init()` is not used for initialization:

**Preferred**:
```swift
let color = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
``` 

**Not Preferred**:
```swift
let color: UIColor = .init(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
```
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
### Static Methods and Variable Type Properties

Static methods and type properties work similarly to global functions and global variables and should be used sparingly. They are useful when functionality is scoped to a particular type or when Objective-C interoperability is required.

### Optionals

Declare variables and function return types as optional with `?` where a `nil` value is acceptable.

Use implicitly unwrapped types declared with `!` only for instance variables that you know will be initialized later before use, such as subviews that will be set up in `viewDidLoad()`. Prefer optional binding to implicitly unwrapped optionals in most other cases.

Don't use as! or try!.

When accessing an optional value, use optional chaining if the value is only accessed once or if there are many optionals in the chain:

```swift
textContainer?.textLabel?.setNeedsDisplay()
```

Use optional binding when it's more convenient to unwrap once and perform multiple operations:

```swift
if let textContainer = textContainer {
  // do many things with textContainer
}

```
**Notes:** Swift 5.7 introduced new shorthand syntax for unwrapping optionals into shadowed variables:

```swift
if let textContainer {
  // do many things with textContainer
}
```

When naming optional variables and properties, avoid naming them like `optionalString` or `maybeView` since their optional-ness is already in the type declaration.

For optional binding, shadow the original name whenever possible rather than using names like `unwrappedView` or `actualLabel`.

**Preferred**:
```swift
var subview: UIView?
var volume: Double?

// later on...
if let subview = subview, let volume = volume {
  // do something with unwrapped subview and volume
}

// another example
resource.request().onComplete { [weak self] response in
  guard let self = self else { return }
  let model = self.updateModel(response)
  self.updateUI(model)
}
```

**Not Preferred**:
```swift
var optionalSubview: UIView?
var volume: Double?

if let unwrappedSubview = optionalSubview {
  if let realVolume = volume {
    // do something with unwrappedSubview and realVolume
  }
}

// another example
UIView.animate(withDuration: 2.0) { [weak self] in
  guard let strongSelf = self else { return }
  strongSelf.alpha = 1.0
}
```

If you don't plan on actually using the value stored in an optional, but need to determine whether or not this value is `nil`, explicitly check this value against `nil` as opposed to using `if let` syntax.

**Preferred**:
```swift
if someOptional != nil {
    // do something
}
```

**Not Preferred**:
```swift
// NOT PREFERRED
if let _ = someOptional {
    // do something
}
```

Use XCTUnwrap instead of forced unwrapping in tests.

**Preferred**:
```swift
let product = try XCTUnwrap(priceComparisonResponse.stores?.first?.products?.first)
```

**Not Preferred**:
```swift
let product = priceComparisonResponse.stores!.first!.products!.first!
```

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

### Lazy Initialization

Consider using lazy initialization for finer grained control over object lifetime. This is especially true for `UIViewController` that loads views lazily. You can either use a closure that is immediately called `{ }()` or call a private factory method. Example:

```swift
lazy var locationManager = makeLocationManager()

private func makeLocationManager() -> CLLocationManager {
  let manager = CLLocationManager()
  manager.desiredAccuracy = kCLLocationAccuracyBest
  manager.delegate = self
  manager.requestAlwaysAuthorization()
  return manager
}
```

**Notes:**
  - `[unowned self]` is not required here. A retain cycle is not created.
  - Location manager has a side-effect for popping up UI to ask the user for permission so fine grain control makes sense here.

___

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
_Note: Following this guideline means picking descriptive names is even more important than before._

### Syntactic Sugar
___

Prefer the shortcut versions of type declarations over the full generics syntax.

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

## Functions vs Methods

Free functions, which aren't attached to a class or type, should be used sparingly. When possible, prefer to use a method instead of a free function. This aids in readability and discoverability.

Free functions are most appropriate when they aren't associated with any particular type or instance.

**Preferred**
```swift
let sorted = items.mergeSorted()  // easily discoverable
rocket.launch()  // acts on the model
```

**Not Preferred**
```swift
let sorted = mergeSort(items)  // hard to discover
launch(&rocket)
```

**Free Function Exceptions**
```swift
let tuples = zip(a, b)  // feels natural as a free function (symmetry)
let value = max(x, y, z)  // another free function that feels natural
```

## Memory Management

Code (even non-production, tutorial demo code) should not create reference cycles. Analyze your object graph and prevent strong cycles with `weak` and `unowned` references. Alternatively, use value types (`struct`, `enum`) to prevent cycles altogether.

### Extending object lifetime

Extend object lifetime using the `[weak self]` and `guard let self = self else { return }` idiom. `[weak self]` is preferred to `[unowned self]` where it is not immediately obvious that `self` outlives the closure. Explicitly extending lifetime is preferred to optional chaining.

**Preferred**
```swift
resource.request().onComplete { [weak self] response in
  guard let self = self else {
    return
  }
  let model = self.updateModel(response)
  self.updateUI(model)
}
```

**Not Preferred**
```swift
// might crash if self is released before response returns
resource.request().onComplete { [unowned self] response in
  let model = self.updateModel(response)
  self.updateUI(model)
}
```

**Not Preferred**
```swift
// deallocate could happen between updating the model and updating UI
resource.request().onComplete { [weak self] response in
  let model = self?.updateModel(response)
  self?.updateUI(model)
}
```

## Access Control

Full access control annotation in tutorials can distract from the main topic and is not required. Using `private` and `fileprivate` appropriately, however, adds clarity and promotes encapsulation. Prefer `private` to `fileprivate`; use `fileprivate` only when the compiler insists.

Only explicitly use `open`, `public`, and `internal` when you require a full access control specification.

Use access control as the leading property specifier. The only things that should come before access control are the `static` specifier or attributes such as `@IBAction`, `@IBOutlet` and `@discardableResult`.

**Preferred**:
```swift
private let message = "Great Scott!"

class TimeMachine {  
  private dynamic lazy var fluxCapacitor = FluxCapacitor()
}
```

**Not Preferred**:
```swift
fileprivate let message = "Great Scott!"

class TimeMachine {  
  lazy dynamic private var fluxCapacitor = FluxCapacitor()
}
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

#### Insert a blank line following a switch case with a multi-line body

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

## Semicolons

Swift does not require a semicolon after each statement in your code. They are only required if you wish to combine multiple statements on a single line.

Do not write multiple statements on a single line separated with semicolons.

**Preferred**:
```swift
let swift = "not a scripting language"
```

**Not Preferred**:
```swift
let swift = "not a scripting language";
```

**NOTE**: Swift is very different from JavaScript, where omitting semicolons is [generally considered unsafe](https://stackoverflow.com/questions/444080/do-you-recommend-using-semicolons-after-every-statement-in-javascript)

## Parentheses

Parentheses around conditionals are not required and should be omitted.

**Preferred**:
```swift
if name == "Hello" {
  print("World")
}
```

**Not Preferred**:
```swift
if (name == "Hello") {
  print("World")
}
```

In larger expressions, optional parentheses can sometimes make code read more clearly.

**Preferred**:
```swift
let playerMark = (player == current ? "X" : "O")
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

## No Emoji

Do not use emoji in your projects. For those readers who actually type in their code, it's an unnecessary source of friction. While it may be cute, it doesn't add to the learning and it interrupts the coding flow for these readers.

## No #imageLiteral or #colorLiteral

Likewise, do not use Xcode's ability to drag a color or an image into a source statement. These turn into #colorLiteral and #imageLiteral, respectively, and present unpleasant challenges for a reader trying to enter them based on tutorial text. Instead, use `UIColor(red:green:blue)` and `UIImage(imageLiteralResourceName:)`.

## Organization and Bundle Identifier

Where an Xcode project is involved, the organization should be set to `Kodeco` and the Bundle Identifier set to `com.yourcompany.TutorialName` where `TutorialName` is the name of the tutorial project.

![Xcode Project settings](screens/project_settings.png)

## Copyright Statement

The following copyright statement should be included at the top of every source
file:

```swift
/// Copyright (c) 2023 Kodeco Inc.
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
```

## Smiley Face

Smiley faces are a very prominent style feature of the [Kodeco](https://www.kodeco.com/) site! It is very important to have the correct smile signifying the immense amount of happiness and excitement for the coding topic. The closing square bracket `]` is used because it represents the largest smile able to be captured using ASCII art. A closing parenthesis `)` creates a half-hearted smile, and thus is not preferred.

**Preferred**:
```
:]
```

**Not Preferred**:
```
:)
```

## References

* [The Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
* [The Swift Programming Language](https://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/swift_programming_language/index.html)
* [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html)
* [Swift Standard Library Reference](https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html)
