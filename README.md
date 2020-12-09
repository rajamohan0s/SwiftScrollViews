<p align="center">
  <img src="https://raw.githubusercontent.com/RAJAMOHAN-S/rajamohan-s.github.io/master/SwiftScrollViews/logo.png">
</p>
<p>
A simple approach to handle UITextField & UITextViews over scroll view accross keyboard. The SwiftScrollViews framework is written with the extension UIScrollView.
</p>
<p align="center">
  <img width = "280" height = "543" src="https://raw.githubusercontent.com/RAJAMOHAN-S/rajamohan-s.github.io/SwiftScrollViews/demo/SwiftScrollView.gif">
  <img width = "280" height = "543" src="https://raw.githubusercontent.com/RAJAMOHAN-S/rajamohan-s.github.io/SwiftScrollViews/demo/SwiftTableView.gif">
  <img width = "280" height = "543" src="https://raw.githubusercontent.com/RAJAMOHAN-S/rajamohan-s.github.io/SwiftScrollViews/demo/SwiftCollectionView.gif">
</p>

## Features

- Auto scroll for actvie `UITextFied` and `UITextView` over `UIScrollView`, `UITableView` and `UICollectionView`.
- Set grouping by using `ReturnKeyType` of `UITextField`.
- Execute action when last `UITextField` of the group did end editing if need by using `SwiftScrollViewDelegate`. (Refer `SwiftScrollViewExample` project).
- Set custom `ReturnKeyType` and vertical space between keyboard and active `UITextField` or `UITextView`.

## Requirements

- iOS 8.0+
- Xcode 10.1+

## Installation

### Using Cocoapods

```ruby
pod 'SwiftScrollViews', '~>1.0' # Swift 4.2.1
```

### Manually
1. Download and drop ```Source``` folder in your project.  
2. Congratulations! 

## Usage

### The Basic Setup
   1. Select scrollview in xib or storyboard in viewcontroller.
   2. Go to **Assistand Editor/Identity Inspector/Custom Class/Class** as `SwiftScrollView`. If you have `UITableView` then use `SwiftTableView` and then `SwiftCollectionView` for `UICollectionView`.

### SwiftScrollViewDelegate

It is delegating the method ```func didEditingDone(for textField: UITextField) {}``` will exceute when **view did end editing**.

 The view will end edit when directly taping the **ScrollViews** or Taping the keyboard return button if ` textField.returnKeyType != .default || textField.returnKeyType != .next`.
 
 ### Grouping
 
  The group of `UITextFields` in a view by setting `textField.returnKeyType != .default || textField.returnKeyType != .next` at last field of that group.

### Aditional Configuration 

```swift
SwiftScrollViews.config.textComponentSpaceFromKeyboard = 40 //vertical space between keyboard and active text field or text view.
SwiftScrollViews.config.defaultDoneKey = .done // The default return key of last text field over the scroll view.
```

### Example:
```swift
class ScrollViewExample: UIViewController,SwiftScrollViewDelegate {
  
    @IBOutlet weak var scrollView: SwiftScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.swiftScrollViewsDelegate =  self
    }
    
    func didEditingDone(for textField: UITextField) {
          
         //TODO:- Do further with by comparing textField with self.textField
        let controller  = UIAlertController(title: textField.placeholder ?? "Place Holder Nil", message: "✅ Editing Done!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "👍", style: .default, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
```
## Contribute
I would love you for the contribution to **SwiftScrollViews**, check the [LICENSE](https://github.com/RAJAMOHAN-S/SwiftScrollViews/blob/master/LICENSE.md) file for more info.

## Meta

Rajamohan S – (https://rajamohan-s.github.io/)

Distributed under the MIT license. See [LICENSE](https://github.com/RAJAMOHAN-S/SwiftScrollViews/blob/master/LICENSE.md) for more information.
