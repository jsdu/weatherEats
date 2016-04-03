//
//  homeController.swift
//  weatherEats
//
//  Created by Jason Du on 2016-04-02.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit

class homeController: UIViewController {

    @IBOutlet var foodButton: UIButton!
    
    override func viewDidLoad() {
        let blur3 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur3.frame = foodButton.bounds
        blur3.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        foodButton.insertSubview(blur3, atIndex: 0)
        
        foodButton.layer.cornerRadius = 5
        foodButton.layer.borderWidth = 1
        foodButton.layer.borderColor = UIColor.whiteColor().CGColor
        foodButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
    }
}
