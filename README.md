# Carte

![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/Carte.svg?style=flat)](https://cocoapods.org/pods/Carte)
[![Build Status](https://travis-ci.org/devxoul/Carte.svg?branch=master)](https://travis-ci.org/devxoul/Carte)
[![Codecov](https://img.shields.io/codecov/c/github/devxoul/Carte.svg)](https://codecov.io/gh/devxoul/Carte)

An open source license notice view generator for Swift.

## Screenshot

![carte](https://cloud.githubusercontent.com/assets/931655/9243550/d781a822-41cc-11e5-91bb-8b5123b2c91e.png)

> ⬆ Those view controllers are automatically generated ✨

## Features

- **🚗 Automatic:** Carte automatically generates OSS notice from [CocoaPods](https://cocoapods.org).
- **☕️ Easy Integration:** Install Carte and push CarteViewController. It's all done.
- **🎨 Customizable:** Adding custom items, customizing CarteViewController. See [Customizing](#customizing) section.


## Installation

Carte only supports [CocoaPods](https://cocoapods.org) at this time.

```ruby
pod 'Carte'
```

**⚠️ IMPORTANT**: Don't forget to add the post install hook to your Podfile. Add this script to the end of your Podfile:

```ruby
post_install do |installer|
  pods_dir = File.dirname(installer.pods_project.path)
  at_exit { `ruby #{pods_dir}/Carte/Sources/Carte/carte.rb configure` }
end
```

## Usage

Carte provides `CarteViewController`. You can use it as a normal view controller. Push, present or do whatever you want.

```swift
let carteViewController = CarteViewController()
```

If you want to create your own UI, use `Carte.items` to get `CarteItem`s.

```swift
class Carte {
  static var items: [CarteItem]
}
```

## Customizing

### Custom Items

`CarteViewController` has a property named `items` which is an array of `CarteItem`. All of the licenses are stored in the `items`. You can add new items, remove existings, or sort items by manipulating `items` array.

This is an example of adding a new `CarteItem` and sorting items.

```swift
var item = CarteItem(name: "Carte")
item.licenseText = "The MIT License (MIT) ...Very long text..."

let carteViewController = CarteViewController()
carteViewController.items.append(item)
carteViewController.items.sort { $0.name < $1.name }
```

### Customizing View Controllers

`CarteDetailViewController` is presented when user selects a table view cell. `CarteViewController` provides a handler for customizing it.

Definition: 

```swift
var configureDetailViewController: (CarteDetailViewController -> Void)?
```

Example:

```swift
let carteViewController = CarteViewController()
carteViewController.configureDetailViewController = { detailViewController in
  detailViewController.navigationItem.leftBarButtonItem = ...
  print(detailViewController.carteItem.name)
}
```

## License

Carte is under MIT license. See the [LICENSE](LICENSE) file for more info.
