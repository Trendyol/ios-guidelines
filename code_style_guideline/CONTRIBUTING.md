# Contributing

To contribute to Trendyol iOS Style Guide, create a new branch ( `fix/methods-swiftlint-rule`  ) and commit your changes. Then, create a new pull request with provided [template](PULL_REQUEST_TEMPLATE.md) accordingly.

**Pull Request Conventions:**

* **Title:** A short description of resolution.
* **Body:** Fill the body with expected fields brought by template. You are allowed to add supportive assets as well.

**Branch Name Conventions**

* fix: If you edit existing rule in terms of lint specs or structural changes, choose this prefix.

* feature: If you add a new rule, section or make any style related changes, choose this prefix.

## Structure of a new rule

1. Place rule under appropriate section, and decide the order of new rule.
2. Enter a title for rule
3. Enter a description for rule (one or more of these: Pros. vs. Cons comparisons, reason behind you propose the rule and etc.)
4. Add Preferred, Also Preferred *optional*, Not Preferred code blocks (order matters)

## Example

#### **1**. Return Arrow Spacing

Leave a space on each side of a line break arrow for readability.

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
