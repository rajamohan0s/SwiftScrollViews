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
pod 'SwiftScrollViews', '~>0.0.2' # Swift 4.2.1
```

#### Manually
1. Download and drop ```Source``` folder in your project.  
2. Congratulations! 

## Usage

#### With Interface Builder
   1. Select scrollview in xib or storyboard in viewcontroller.
   2. Go to **Assistand Editor/Identity Inspector/Custom Class/Class** as `SwiftScrollView`. If you have `UITableView` then use `SwiftTableView` and then `SwiftCollectionView` for `UICollectionView`.
