# RocketAlert

Would you like to improve your User Experiece's while asking user to do some action? 

Rockert Alert resolve the problem of be distracted by a boring AlertView with a user friendly boarding process similar to a Chat Bot. 

With a modern style and a powerful personalization RocketAlert will help you to increase your conversion rate.

![alt text](https://media.giphy.com/media/5QLxkjz2nq5cHBENqr/giphy.gif)![alt text](https://media.giphy.com/media/9u15NC295RsZIKCDWj/giphy.gif)


## Usage

```swift
import RocketAlert

let author = RocketAuthor.init(image: yourUIImage, style: RocketImageStyle.round)
let textBlock = TextRocketBlock.init(text: "This is your first Block")
let rocket = Rocket.init(author: author, block: textBlock)

rocket.show()
```

The manager of the alert is the `Rocket` class. You can istantiate a `Rocket` by passing to his parameters a `RocketAuthor` and one `RocketBlock` object.

After that you can present the `Rocket` by performing the method `show()`.

you could destroy the alert by invoking the method `dismiss()` on the same rocket object:

```swift
rocket.dismiss()
```

## The RocketBlock Objects




## How does it work internally?

**A `Rocket` is a subclass of `UIViewController`**. 

When you create an object of a `Rocket` class the **init start searching inside the hierarchy of the `UIApplication.shared.keyWindow` and try to extract the topmost view controller.** If he can't find a VC he throw a `fatalError`.

Rocket is composed by some subviews and the most important are: 
1. `RocketTableView` that handle, show and manage the `RocketBlocks`
2. `RocketAuthorView` that show the content of the `RocketAuthor`

When you call the `show()` the `present()` method will be fired over the topmost VC that will present the rocket VC with `.modalPresentationStyle = .overCurrentContext`. Likewise the `dismiss()` will dismiss the rocket VC.

### The RocketTableController 

The `RocketTableView` is managed by the `RockeTableController` that implement the `UITableViewDataSource` and `UITableViewDelegate` protocols.


