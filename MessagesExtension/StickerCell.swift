//
//  StickerCell.swift
//  customStickerApp
//
//  Created by Jelena on 11/28/16.
//  Copyright © 2016 Byteout. All rights reserved.
//

import UIKit
import Messages

class StickerCell: UICollectionViewCell {
    // Sticker view - a view that is holding a sticker
    @IBOutlet weak var stickerView: MSStickerView!
    
    /*!
     @discussion MSStickerView provides drag and drop functionality so that user may drag the displayed sticker from this view and place it in the Messages transcript. It has a sticker property, which is of type MSSticker. A sticker can be sent as a new message or attached to an existing balloon in the transcript.
     */
}
