//
//  BViewController.swift
//  Each
//
//  Created by Pan on 2016/10/22.
//  Copyright © 2016年 dalu93. All rights reserved.
//

import UIKit

class BViewController: UIViewController {

    private var each: Each?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. Instantiate the Each class with a value
        // 2. Define the value mesure (milliseconds, seconds, minutes, hours)
        // 3. Register the perfom closure
        // 4. Return false in the closure to continue, otherwise true to stop the timer
        each = Each(1).seconds
        each!.perform {
            print("second passed")
            return false
        }

    }


}
