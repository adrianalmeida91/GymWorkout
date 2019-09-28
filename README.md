# GymWorkout
iOS app to use for Venturus bootcamp to demo the automation test

# Setup project

1. Open terminal and run the command line "**pod install**" on project root,
to install the project's dependencies.

2. Open project .workspace on XCode

# UI Testing Cheat Sheet

References:
https://github.com/joemasilotti/UI-Testing-Cheat-Sheet
http://masilotti.com/ui-testing-cheat-sheet/

## Contents

- [Basic Functionality](#basic-functionality)
  - [Testing if an element exists](#testing-if-an-element-exists)
  - [Testing if text with an ellipsis exists](#testing-if-text-with-an-ellipsis-exists)
  - [Waiting for an element to appear](#waiting-for-an-element-to-appear)
  - [How to Print the Accessibility Hierarchy](#how-to-print-the-accessibility-hierarchy)
  - [Set the device orientation](#set-the-device-orientation)
- [Interacting with System Controls](#interacting-with-system-controls)
  - [Tapping tabs](#tapping-tabs)
  - [Tapping buttons](#tapping-buttons)
  - [Taps and long press](#taps-and-long-press)
  - [Swipes](#swipes)
  - [Typing text](#typing-text)
  - [Dismissing alerts](#dismissing-alerts)
  - [Handling system alerts](#handling-system-alerts)
  - [Sliding sliders](#sliding-sliders)
  - [Interacting with pickers](#interacting-with-pickers)
  - [Tapping links in web views](#tapping-links-in-web-views)
- [Interactions](#interactions)
  - [Verifying the current controller's title](#verifying-the-current-controllers-title)
  - [Verifying if the element is on screen and it is tappable](#verifying-if-the-element-is-on-screen-and-it-is-tappable)
  - [Reordering table cells](#reordering-table-cells)
  - [Pull to refresh](#pull-to-refresh)
  - [Pushing and popping view controllers](#pushing-and-popping-view-controllers)

## Basic Functionality

### Testing if an element exists

````swift
XCTAssert(app.staticTexts["Welcome"].exists)
````

### Testing if text with an ellipsis exists
A full text match will find an element even if the displayed text has an ellipsis due to truncation.

````swift
let longNameCell = app.staticTexts["Adolph Blaine Charles David Earl Frederick Gerald Hubert Irvin John Kenneth Lloyd Martin Nero Oliver Paul Quincy Randolph Sherman Thomas Uncas Victor William Xerxes Yancy Wolfeschlegelsteinhausenbergerdorff, Senior"]
XCTAssert(longNameCell.exists) // displayed text is "Adolph Blaine Charles David Earl Freder..."
````

### Waiting for an element to appear
Set up an expectation to use with `XCTest`. The predicate will wait until the element's `-exist` property is true.

````swift
let goLabel = app.staticTexts["Go!"]
XCTAssertFalse(goLabel.exists)

let exists = NSPredicate(format: "exists == true")
expectation(for: exists, evaluatedWithObject: goLabel, handler: nil)

app.buttons["Ready, set..."].tap()
waitForExpectations(timeout: 5, handler: nil)
XCTAssert(goLabel.exists)
````

### How to Print the Accessibility Hierarchy
Printing the accessibility heirarchy is a good way to "see what the framework sees."
You can use this and the Accessibility Inspector to debug querying and selecting elements

````swift
print(app.debugDescription)
````
### Set the device orientation
````swift
XCUIDevice.shared().orientation = .portrait
XCUIDevice.shared().orientation = .faceUp
````

## Interacting with System Controls

### Tapping tabs
````swift
let tabBarsQuery = app.tabBars
let calculatorButton = tabBarsQuery.buttons[calculator]
````

### Tapping buttons
By their accessibility label

````swift
app.buttons["Add"].tap()
````

By the first found in the hierarchy

````swift
app.buttons.firstMatch.tap()
````

Button inside a toolbar
````swift
app.toolbars.buttons["Toolbar Next Button"].tap()
````

Button inside a navigation bar
````swift
app.navigationBars["DISTRIBUTOR"].buttons["Select"].tap()
app.navigationBars["Rewards.HomeTableView"].children(matching: .button).element(boundBy: 0).tap()
````

### Taps and long press
````swift
startButton.tap()
startButton.press(forDuration: 3)

scrollView.doubleTap()
scrollView.twoFingerTap()
scrollView.tap(withNumberOfTaps: 1, numberOfTouches: 4)
````
### Swipes
````swift
scrollView.swipeUp()
scrollView.swipeRight()
````

### Typing text
First make sure the text field has focus by tapping on it.

````swift
let textField = app.textFields["Username"]
textField.tap()
textField.typeText("bootcamp")
````

### Dismissing alerts
````swift
app.alerts["Alert Title"].buttons["Button Title"].tap()
````

### Dismissing action sheets
````swift
app.sheets["Sheet Title"].buttons["Button Title"].tap()
````

### Handling system alerts
Present a location services authorization dialog to the user and dismiss it with the following code.

Before presenting the alert add a UI Interuption Handler. When this fires, dismiss with the "Allow" button.

````swift
addUIInterruptionMonitor(withDescription: "Location Services") { (alert) -> Bool in
  alert.buttons["Allow"].tap()
  return true
}

app.buttons["Request Location"].tap()
app.tap() // need to interact with the app again for the handler to fire
````

### Sliding sliders
This will slide the value of the slider to 70%.

````swift
app.sliders.element.adjust(toNormalizedSliderPosition: 0.7)
````

### Interacting with pickers
A picker with one wheel:

````swift
app.pickerWheels.element.adjust(toPickerWheelValue: "Picker Wheel Item Title")
````

A picker with multiple wheels. Make sure to set the accessibility delegate so the framework can identify the different wheels.

````swift
let firstPredicate = NSPredicate(format: "label BEGINSWITH 'First Picker'")
let firstPicker = app.pickerWheels.element(matching: firstPredicate)
firstPicker.adjust(toPickerWheelValue: "first value")

let secondPredicate = NSPredicate(format: "label BEGINSWITH 'Second Picker'")
let secondPicker = app.pickerWheels.element(matching: secondPredicate)
secondPicker.adjust(toPickerWheelValue: "second value")

````

### Tapping links in web views
````swift
app.links["Tweet this"].tap()
````

## Interactions

### Verifying the current controller's title
````swift
XCTAssert(app.navigationBars["Details"].exists)
````

### Verifying if the element is on screen and it is tappable
````swift
if startButton.isHittable {
  // Do something with button
}
````

### Reordering table cells
If you have a `UITableViewCell` with default style and set the text to "Title", the reorder control's accessibility label becomes "Reorder Title".

Using this we can drag one reorder control to another, essentially reordering the cells.

````swift
let topButton = app.buttons["Reorder Top Cell"]
let bottomButton = app.buttons["Reorder Bottom Cell"]
bottomButton.press(forDuration: 0.5, thenDragTo: topButton)

XCTAssertLessThanOrEqual(bottomButton.frame.maxY, topButton.frame.minY)
````

### Pull to refresh

Create a `XCUICoordinate` from the first cell in your table and another one with
a `dy` of six. Then drag the first coordinate to the second.

````swift
let firstCell = app.staticTexts["Adrienne"]
let start = firstCell.coordinate(withNormalizedOffset: (CGVectorMake(0, 0))
let finish = firstCell.coordinate(withNormalizedOffset: (CGVectorMake(0, 6))
start.press(forDuration: 0, thenDragTo: finish)
````

### Pushing and popping view controllers

Test if a view controller was pushed onto the navigation stack.

```swift
app.buttons["More Info"].tap()
XCTAssert(app.navigationBars["Volleyball?"].exists)
```

### Pop a view controller by tapping the back button in the navigation bar and assert that the title in the navigation bar has changed.

```swift
app.navigationBars.buttons.elementBoundByIndex(0).tap()
XCTAssert(app.navigationBars["Volley"].exists)
```
