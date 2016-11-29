//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Jelena on 11/25/16.
//  Copyright © 2016 Byteout. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    // MARK: Constants
    private let StickersViewController = "StickersViewController"
    
    // MARK: - Lifecycle
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load StickerCollectionViewController
        let _ = loadViewController(StickersViewController)
    }
    
    // View did receive memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Helpers
    
    // Load a view controller with given identifier
    func loadViewController(_ viewControllerIdentifier: String) -> Bool {
        // Remove any existing child controllers.
        childViewControllers.forEach {
            $0.willMove(toParentViewController: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParentViewController()
        }
        
        // Instantiate view controller from storyboard, using its identifier...
        guard let vc = storyboard?
            .instantiateViewController(withIdentifier: viewControllerIdentifier) else {return false}
        
        // ... and then add it to message app
        vc.addTo(appViewController: self)
        
        return true

    }
}

// MARK: - UIViewController Extension

// Extension for UIViewController class - adds additional functions to a class
extension UIViewController {
    
    // Load any view controller into Messages App
    func addTo(appViewController host: MSMessagesAppViewController) {
        
        // Add child view controller
        willMove(toParentViewController: host)
        host.addChildViewController(self)
        
        // Set up the frame of child view controller
        view.frame = host.view.bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        host.view.addSubview(view)
        
        // Set up constraints
        view.leftAnchor.constraint(equalTo: host.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: host.view.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: host.view.bottomAnchor).isActive = true
        
        // We do not want our view controller to be covered with the contact name, that is why this one is different
        view.topAnchor.constraint(equalTo: host.topLayoutGuide.bottomAnchor).isActive = true
        
        /*!
         @discussion The NSLayoutAnchor class is a factory class for creating NSLayoutConstraint objects using a fluent API. Use these constraints to programatically define your layout using Auto Layout.
        */
        
        didMove(toParentViewController: host)
        
    }
}
