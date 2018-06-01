# RocketAlert

Would you like to improve your User Experiece's while asking user to do some action? 

Rockert Alert resolve the problem of be distracted by a boring AlertView with a user friendly boarding process similar to a Chat Bot. 

![alt text](https://media.giphy.com/media/5QLxkjz2nq5cHBENqr/giphy.gif)![alt text](https://media.giphy.com/media/9u15NC295RsZIKCDWj/giphy.gif)

With a modern style and a powerful personalization RocketAlert could help you to increase your conversion rate.

## Usage

**You can istantiate a `Rocket` by passing to his parameters a `RocketAuthor` and a `RocketBlock` object.** After that you can **present the `Rocket` by performing the method `show()`**:

```swift
import RocketAlert

let author = RocketAuthor.init(image: yourUIImage, style: RocketImageStyle.round)
let textBlock = TextRocketBlock.init(text: "This is your first Block")
let rocket = Rocket.init(author: author, block: textBlock)

rocket.show()
```

You can **destroy the alert by invoking the method `dismiss()`** on the same rocket object:

```swift
rocket.dismiss()
```

## The RocketBlock

 **`RocketBlock` is container of data and functionality** and under the hood `RocketBlock` is nothing else a simple `UITableViewCell`.

**Depends on block type a user can interact with a block by: *Tap*, *Control Events*** (for example button click) **and *Input Events*** (at the moment only text input). **After an event `Rocket` could show the next block** that has been attached to the interacted block.

**`RocketBlock` is a protocol that give to all blocks a `var id: String? {get set}` property** (created to be used in some advanced circumstances). There is also a `var cellIdentifier: String {get}` which is used internally to match the block with a reusable cell. 

```swift
public protocol RocketBlock {
    var id: String? { get set }
    var cellIdentifier: String { get }
}
```

**The `RocketBlock` protocol is never used as base protocol of the implemented class.** Instead you will use the inherited protocols that gives to the blocks some useful stuff. 


## TappableRocketBlock

The `TappableRocketBlock` is a inherited protocol from `RocketBlock`. The `TappableRocketBlock` protocol describe the block that could be tapped by the user. He gives to the implemented class two properties:

```swift
protocol TappableRocketBlock: RocketBlock {
    var next: RocketBlock? { get set }
    var showNextAfter: TimeInterval? { get set }
}
```

1. The `next` property represent the next `RocketBlock` that will be shown after the tap.  
2. The `showNextAfter` property allows the next block, if presented, to be shown automatically after an amount of time. If you provide a value the `TapGestureRecognizer` will be disabled.


### TextRocketBlock

**You can use `TextRocketBlock` object to show a line or multiline string.** The `TextRocketBlock` is an implemented class of the `TappableRocketBlock` protocol.

You can create a `TextRocketBlock` by using on of these init:

```swift
init(text: String, next: RocketBlock, showNextAfter: TimeInterval? = nil)
init(text: String, showNextAfter: TimeInterval)
init(text: String, next: RocketBlock? = nil, showNextAfter: TimeInterval? = nil, id: String? = nil, font: RocketFont = .text)
```

#### Example 1.

```swift
let secondBlock = TextRocketBlock.init(text: "This is your second block")
let firstBlock = TextRocketBlock.init(text: "This is your first block", next: secondBlock)
        
let rocket = Rocket.init(author: author, block: firstBlock)
rocket.show()
```
The `secondBlock` will be presented after the tap on the `firstBlock`. Note that I passed the `firstBlock` to the `rocket`.

#### Example 2. ShowNextAfter

```swift
let thirdBlock = TextRocketBlock.init(text: "Third")
let secondBlock = TextRocketBlock.init(text: "Second", next: thirdBlock, showNextAfter: 2.0)
let firstBlock = TextRocketBlock.init(text: "First", next: secondBlock)
```

The `thirdBlock` will be shown automatically after 2.0 seconds and after the `secondBlock`.

#### Example 3. Flatten style

```swift
let firstBlock = TextRocketBlock.init(text: "First")
let secondBlock = TextRocketBlock.init(text: "Second")
let thirdBlock = TextRocketBlock.init(text: "Third")

firstBlock.next = second 
firstBlock.showNextAfter = 2.0

secondBlock.next = third
secondBlock.font = RocketFont.textBold
```

![Screenshot](https://image.ibb.co/nC4kLy/Schermata_2018_06_01_alle_17_23_18.png)

#### RocketFont

You can change the `UIFont` by providing a `RocketFont` object to the `font` property. 

```swift
let firstBlock = TextRocketBlock.init(text: "First", next: secondBlock)
firstBlock.font = RocketFont.init(font: UIFont, color: UIColor)
// or 
firstBlock.font = RocketFont.text // the default
```

The `RocketFont` provide some default styles:

```swift
public struct RocketFont {
    public static var text = RocketFont.init(font: UIFont.systemFont(ofSize: 18, weight: .regular), color: #colorLiteral(red: 0.1621472239, green: 0.2301641703, blue: 0.3008684814, alpha: 1))
    public static var textBold = RocketFont.init(font: UIFont.systemFont(ofSize: 18, weight: .bold), color: #colorLiteral(red: 0.1621472239, green: 0.2301641703, blue: 0.3008684814, alpha: 1))
    public static var button = RocketFont.init(font: UIFont.systemFont(ofSize: 20, weight: .black), color: #colorLiteral(red: 0.1902082911, green: 0.6098146351, blue: 0.968627451, alpha: 1))
    public static var lightButton = RocketFont.init(font: UIFont.systemFont(ofSize: 18, weight: .regular), color: #colorLiteral(red: 0.1902082911, green: 0.6098146351, blue: 0.968627451, alpha: 1))
    public static var cancel = RocketFont.init(font: UIFont.systemFont(ofSize: 20, weight: .semibold), color: #colorLiteral(red: 0.9267585874, green: 0.367726624, blue: 0.3804723024, alpha: 1))
    public static var emoji = RocketFont.init(font: UIFont.systemFont(ofSize: 25, weight: .black), color: #colorLiteral(red: 0.1621472239, green: 0.2301641703, blue: 0.3008684814, alpha: 1))
    
    public var color: UIColor
    public var font: UIFont
    
    public init() {
        self.color = UIColor.black
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    public init(font: UIFont, color: UIColor) {
        self.font = font
        self.color = color
    }
}

// USE:
block.font = RocketFont.text
block.font = RocketFont.emoji
block.font = RocketFont.textBold
```

## How does it work internally?

**A `Rocket` is a subclass of `UIViewController`**. 

When you create an object of a `Rocket` class the **init start searching inside the hierarchy of the `UIApplication.shared.keyWindow` and try to extract the topmost view controller.** If he can't find a VC he throw a `fatalError`.

Rocket is composed by some subviews and the most important are: 
1. `RocketTableView` that handle, show and manage the `RocketBlocks`
2. `RocketAuthorView` that show the content of the `RocketAuthor`

When you call the `show()` the `present()` method will be fired over the topmost VC that will present the rocket VC with `.modalPresentationStyle = .overCurrentContext`. Likewise the `dismiss()` will dismiss the rocket VC.

### The RocketTableController 

The `RocketTableView` is managed by the `RockeTableController` that implement the `UITableViewDataSource` and `UITableViewDelegate` protocols.



