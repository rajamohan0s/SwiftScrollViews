<p align="center">
  <img src="https://rajamohan-s.github.io/swiftscrollviews/logo.png">
</p>
<p>
A simple approach to handle UITextField & UITextViews over scroll view accross keyboard. The SwiftScrollViews framework is written with the extension UIScrollView.
</p>
<p align="left">
  <img width = "300" height = "500" src="./images/demo.gif">
</p>
## Requirements

- iOS 8.0+
- Xcode 10.1+

## Installation

### Using Cocoapods

```ruby
pod 'SwiftScrollViews', '~>1.0' # Swift 4.2.1
```

#### Manually
1. Download and drop ```Source``` folder in your project.  
2. Congratulations! 

## Usage

#### With Interface Builder

##### The Basic Setup
   1. Select scrollview in xib or storyboard in viewcontroller.
   2. Go to **Assistand Editor/Identity Inspector/Custom Class/Class** as `SwiftScrollView`. If you have `UITableView` then use `SwiftTableView` and then `SwiftCollectionView` for `UICollectionView`.

##### SwiftScrollViewDelegate

It is delegating the method `func didEditingDone(for textField: UITextField) {}` to get **Done** action over `UITextField`.

Example:
```swift
class ScrollViewExample: UIViewController,SwiftScrollViewDelegate {
  
    @IBOutlet weak var scrollView: SwiftScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.swiftScrollViewsDelegate =  self
    }
    
    func didEditingDone(for textField: UITextField) {
        
        let controller  = UIAlertController(title: textField.placeholder ?? "Place Holder Nil", message: "✅ Editing Done!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "👍", style: .default, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
```
## Contribute
I would love you for the contribution to **SNet**, check the [LICENSE](https://github.com/RAJAMOHAN-S/SwiftScrollViews/blob/master/LICENSE.md) file for more info.

## Meta

Rajamohan S – (https://rajamohan-s.github.io/)

Distributed under the MIT license. See [LICENSE](https://github.com/RAJAMOHAN-S/SwiftScrollViews/blob/master/LICENSE.md) for more information.
