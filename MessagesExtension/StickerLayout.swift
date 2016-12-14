//
//  StickerLayout.swift
//  customStickerApp
//
//  Created by Jelena on 11/25/16.
//  Copyright © 2016 Byteout. All rights reserved.
//

import UIKit

class StickerLayout: UICollectionViewLayout {
    // MARK: Constants

    // Space between sticker cells
    private let cellPadding = 6
    
    // Height of a sticker - equal for all of them
    private let height = 100
    
    // MARK: Properties
    
    // Total number of rows
    private var row = 0
    
    // Number of columns in a row
    private var col = 2
    
    // Current column
    private var colCounter = 0
    
    // Sticker width
    private var width = 1
    
    // Cached attributes
    private var cache = [UICollectionViewLayoutAttributes]()
    
    // MARK: - Getters
    
    // Content width
    private var contentWidth: CGFloat {
        // Returns width of the collection view
        return collectionView!.bounds.width
    }
    
    // CollectionView content size - used for scrolling
    override var collectionViewContentSize: CGSize {
        if (colCounter != 0) {
            // If the last row is not full
            return CGSize(width: contentWidth, height: CGFloat((row + 1) * height + (row + 2) * cellPadding))
        }
        else {
            // If the last row is completely filled with stickers, variable row is increased by one
            return CGSize(width: contentWidth, height: CGFloat(row * height + (row + 1) * cellPadding))
        }
    }
    
    // MARK: - Layout related functions
    
    // Prepare - used for main calculations and defining positions of stickers
    override func prepare() {
        // Only if cache is empty - we do not need to calculate this every time the function is called
        if cache.isEmpty {
            for i in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                // Create index path from index
                let indexPath = IndexPath(item: i, section: 0)
                
                // Create new attributes for cell with index path
                let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                
                // First row has two columns, second row has three columns, third row has two columns, ...
                if ((row % 2) == 0) {
                    col = 2
                }
                else {
                    col = 3
                }
                
                // Calculate sticker width based on number of columns
                width = Int((Double(contentWidth) - Double((col + 1) * cellPadding)) / Double(col))

                // Set sticker attributes: only frame in this case
                attributes.frame = CGRect(x:(colCounter * width + (colCounter + 1) * cellPadding), y:(row * height + (row + 1) * cellPadding), width:width, height:height)
                
                // Add attributes to cache
                cache.append(attributes)
                
                // After we calculate attributes for one sticker, we increase columns counter
                colCounter += 1
                
                // If we have filled a row, we proceed to another row
                if (colCounter == col) {
                    row += 1
                    colCounter = 0
                }
            }
        }
    }
    
    // Layout attributes for elements in rect - to return layout attributes for for supplementary or decoration views, or to perform layout in an as-needed-on-screen fashion.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Get attributes from cache...
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        // ... and return them
        return layoutAttributes
    }
}
