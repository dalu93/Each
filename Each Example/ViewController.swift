//
//  ViewController.swift
//  Each
//
//  Created by Luca D'Alberti on 10/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit
import Each

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Instantiate the Each class with a value
        // 2. Define the value mesure (milliseconds, seconds, minutes, hours)
        // 3. Register the perfom closure
        // 4. Return .continue in the closure to continue, otherwise .stop to stop the timer
        Each(1).seconds.perform {
            print("second passed")
            return .continue
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

