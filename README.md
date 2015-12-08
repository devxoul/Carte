Carte
=====

![Swift 2.0](https://img.shields.io/badge/Swift-2.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/Carte.svg?style=flat)](https://cocoapods.org/pods/Carte)

Open source license notice view generator for Cocoa.


Screenshot
----------

![carte](https://cloud.githubusercontent.com/assets/931655/9243550/d781a822-41cc-11e5-91bb-8b5123b2c91e.png)


> These are the screenshots of demo project which is located in [CarteDemo](https://github.com/devxoul/Carte/tree/master/CarteDemo) directory.


Features
--------

- **:red_car: Automatic:** Carte automatically generates OSS notice from [CocoaPods](https://cocoapods.org) and [CocoaSeeds](https://github.com/devxoul/CoocaSeeds).
- **:coffee: Easy Integration:** Install Carte, add run scripts, then push CarteViewController. It's done.
- **:sparkles: Customizable:** Adding custom items, customizing CarteViewController. See [Customizing](#customizing) section.


Getting Started
---------------

### Step 1. Installation

- **For iOS 8+ projects:** Use [CocoaPods](https://cocoapods.org) with Podfile:

    ```ruby
    pod 'Carte'
    ```


- **For iOS 7 projects:** I recommend you to try [CocoaSeeds](https://github.com/devxoul/CocoaSeeds), which uses source code instead of dynamic frameworks. Sample Seedfile:

    ```ruby
    github 'devxoul/Carte', '0.2.2', :files => 'Carte/*.{swift,rb}'
    ```


### Step 2. Adding Run Scripts

<img src="https://cloud.githubusercontent.com/assets/931655/9232206/6cd6cec2-4167-11e5-8bcd-9d911cf59a50.png" alt="phase-order" align="right" hspace="20">

Carte has a simple ruby script named *carte.rb* that reads third-party libraries from CocoaPods and CocoaSeeds directory. You have to add 2 run script phases **before and after 'Copy Bundle Resources' phase**.

- **Carte Pre**

    <pre>
    ruby <i>/path/to/carte.rb</i> <b>pre</b>
    </pre>

- **Carte Post**

    <pre>
    ruby <i>/path/to/carte.rb</i> <b>post</b>
    </pre>

- **/path/to/carte.rb:** carte.rb file is located in Carte directory.

    If you installed Carte via:

    - CocoaPods, then path would be: `${SRCROOT}/Pods/Carte/Carte/carte.rb`
    - CocoaSeeds, then path would be: `${SRCROOT}/Seeds/Carte/Carte/carte.rb`

- **For example (CocoaPods)**:

    ![carte-pre](https://cloud.githubusercontent.com/assets/931655/9234048/71a32392-4171-11e5-8aea-dfdf434b24f0.png)


### Step 3. Using CarteViewController

Almost done! What you need to do now is using `CarteViewController`. Use it just like using a `UIViewController`: push, present, or whatever you want to do.

```swift
let carteViewController = CarteViewController()
```


Customizing
-----------

### Manipulating items

`CarteViewController` has a property named `items` which is an array of `CarteItem`. All of licenses are stored in `items`. You can add new items, remove existings, or sort items by manipulating `items` array.

This is an example of adding a new `CarteItem` and sorting items.

```swift
let item = CarteItem()
item.name = "Carte"
item.licenseText = "The MIT License (MIT) ...Very long text..."

let carteViewController = CarteViewController()
carteViewController.items.append(item)
carteViewController.items.sort { $0.name < $1.name }
```

### Customizing View Controllers

`CarteDetailViewController` is appeared when select a cell of table view. `CarteViewController` provides a handler for customizing it.

Definition: 

```swift
var configureDetailViewController: (CarteDetailViewController -> Void)?
```

Example:

```swift
let carteViewController = CarteViewController()
carteViewController.configureDetailViewController = { detailViewController in
    detailViewController.navigationItem.leftBarButtonItem = ...
    println(detailViewController.carteItem!.name)
}
```


License
-------

Carte is under MIT license. See the LICENSE file for more info.
