Carte
=====

[![CocoaPods](http://img.shields.io/cocoapods/v/Carte.svg?style=flat)](https://cocoapods.org/pods/Carte)

Open source notice generator for Cocoa.


Features
--------

- **Automatic:** Carte automatically generates OSS notice from [CocoaPods](https://cocoapods.org) and [CocoaSeeds](https://github.com/devxoul/CoocaSeeds).
- **Easy Integration:** Install Carte, add run scripts, then push CarteViewController. It's done.
- **Customizable:** Adding custom items, customizing CarteViewController.


Installation
------------

### Step 1. Getting Carte

#### For iOS 8+ projects

Use [CocoaPods](https://cocoapods.org) with Podfile:

```ruby
pod 'Carte'
```


#### For iOS 7 projects

I recommend you to try [CocoaSeeds](https://github.com/devxoul/CocoaSeeds), which uses source code instead of dynamic frameworks. Sample Seedfile:

```ruby
github 'devxoul/Carte', '0.1.0', :files => 'Carte/*.{swift,rb}'
```


### Step 2. Adding Run Scripts

Carte has a simple ruby script that reads third-party libraries from CocoaPods and CocoaSeeds directory. You have to add run scripts **before and after copying bundle resources**.

1. Go to project settings by clicking project name in Xcode project navigator.

    ![1-project-navigator](https://cloud.githubusercontent.com/assets/931655/9232379/47f3d612-4168-11e5-8322-5c07274d54e4.png)

2. Click [Build Phases] at the top of the page.

    ![2-build-phases](https://cloud.githubusercontent.com/assets/931655/9232417/7e56daec-4168-11e5-9a05-10a02430a59d.png)
    
3. Click [+] button and select [New Run Script Phase] and change name to 'Carte Pre'.

    ![3-new-run-script](https://cloud.githubusercontent.com/assets/931655/9232473/d88df518-4168-11e5-91b4-c7dc7b0e7b47.png)

4. Enter the script.

    <pre>
    ruby <i>/your/carte.rb/location</i> <b>pre</b>
    </pre>

    For example, if you installed Carte via:

    - CocoaPods, then script would be: `ruby $SRCROOT/Pods/Carte/Carte/carte.rb pre`
    - CocoaSeeds, then script would be: `ruby $SRCROOT/Seeds/Carte/Carte/carte.rb pre`

    ![4-carte-pre](https://cloud.githubusercontent.com/assets/931655/9232486/f98cc078-4168-11e5-8cd8-65aa2459a21a.png)

5. Add another Run Script Phase named 'Carte Post' and enter:

    <pre>
    ruby <i>/your/carte.rb/location</i> <b>post</b>
    </pre>

6. Change phases order to make 'Carte Pre' locates before 'Copy Bundle Resources' and 'Carte Post' after it.

    ![6-phase-order](https://cloud.githubusercontent.com/assets/931655/9232206/6cd6cec2-4167-11e5-8bcd-9d911cf59a50.png)


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


Screenshot
----------

You can find a demo project in CarteDemo directory. These are the screenshots of demo project.

![carte](https://cloud.githubusercontent.com/assets/931655/9231520/8c0d4216-4163-11e5-86c0-610028ea92b8.png)


License
-------

Carte is under MIT license. See the LICENSE file for more info.
