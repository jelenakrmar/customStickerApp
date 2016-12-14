# Introduction

The code in this repository is a part of short tutorial series, that should explain how to easily create different types of customized iMessage sticker apps.

In this example I am using **UICollectionViewController with a custom layout**, in order to set different size and position of each sticker.

**To create similar app, just follow these steps:**

* Create iMessage app
* Subclass UIViewController and add subviews
  * views, buttons, labels, … (optional)
  * UICollectionView (required)
* implement UICollectionView dataSource methods:
  * numberOfSections(in:)
  * collectionView(_:numberOfItemsInSection:)
  * collectionView(_:cellForItemAt:)
* Subclass UICollectionViewCell and add MSStickerView to it (possible through Storyboard)
* Load sticker into MSStickerView in collectionView(_:cellForItemAt:) method
* Load UIViewController into MessageViewController

You can use this app as a starter kit when creating your own app - just replace existing images with your own.
If you also want to change the layout, only piece of code you need to change is prepare() function.
