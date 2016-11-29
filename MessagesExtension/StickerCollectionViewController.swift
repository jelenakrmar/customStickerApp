//
//  StickerCollectionViewController.swift
//  winterStickers
//
//  Created by Jelena on 11/25/16.
//  Copyright © 2016 Byteout. All rights reserved.
//

import UIKit
import Messages

class StickerCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: Constants
    
    // Sticker Cell Identifier
    private let reuseIdentifier = "StickerCell"
    
    // Early App Store ID
    private let appStoreAppID = "1065376327"
    
    // MARK: Properties
    
    // Collection view
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Array of stickers
    var stickers = [MSSticker]()
    
    // MARK: - Lifecycle
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStickers()
    }

    // View did receive memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UICollectionViewDataSource

    // Number of sections in collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // Number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers.count
    }

    // Cell for item at index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Load reusable cell using its identifier; the loaded cell should be of the class StickerCell - we also defined this in the storyboard
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StickerCell
    
        // Set up cell with its sticker
        cell.stickerView.sticker = stickers[indexPath.row]
        
        return cell
    }
    
    // MARK: - Helpers
    
    // Create sticker
    func createSticker(asset: String, localizedDescription: String) {
        // Get path for asset
        guard let stickerPath = Bundle.main.path(forResource: asset, ofType:"png") else {
            print("couldn't create the sticker for asset ", asset)
            return
        }
        
        // Create url from the path
        let stickerUrl = URL(fileURLWithPath: stickerPath)
        
        // Load asset into sticker and append the array of stickers with the new element
        let sticker: MSSticker
        do {
            try sticker = MSSticker(contentsOfFileURL: stickerUrl, localizedDescription:localizedDescription)
            stickers.append(sticker)
        }
        catch {
            print(error)
            return
        }
    }
    
    // Load all assets and create stickers from them
    func loadStickers() {
        createSticker(asset: "heart", localizedDescription: NSLocalizedString("Heart", comment: ""))
        createSticker(asset: "romb", localizedDescription: NSLocalizedString("Romb", comment: ""))
        createSticker(asset: "club", localizedDescription: NSLocalizedString("Club", comment: ""))
        createSticker(asset: "square", localizedDescription: NSLocalizedString("Square", comment: ""))
        createSticker(asset: "star", localizedDescription: NSLocalizedString("Star", comment: ""))
        createSticker(asset: "circle", localizedDescription: NSLocalizedString("Circle", comment: ""))
    }
    
    
    // MARK: - Actions
    @IBAction func downloadButtonTouchUpInside(_ sender: UIButton) {
        NSLog("%@", "You just tapped on the pink button")
    }
    
}
