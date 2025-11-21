//
//  ViewController.swift
//  LyraZoho
//
//  Created by 19464793 on 11/20/2025.
//  Copyright (c) 2025 19464793. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let vc = UIHostingController(rootView: ContentView())

            let swiftuiView = vc.view!
            swiftuiView.translatesAutoresizingMaskIntoConstraints = false
            
            // 2
            // Add the view controller to the destination view controller.
            addChildViewController(vc)
            view.addSubview(swiftuiView)
            
            // 3
            // Create and activate the constraints for the swiftui's view.
            NSLayoutConstraint.activate([
                swiftuiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                swiftuiView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
            
            // 4
            // Notify the child view controller that the move is complete.
            vc.didMove(toParent: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

