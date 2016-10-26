//
//  ViewController.swift
//  Each
//
//  Created by Luca D'Alberti on 10/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var a = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Instantiate the Each class with a value
        // 2. Define the value mesure (milliseconds, seconds, minutes, hours)
        // 3. Register the perfom closure
        // 4. Return .continue in the closure to continue, otherwise .stop to stop the timer
//        Each(1).seconds.perform {
//            print("second passed")
//            return .continue
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard a else { return }
        a = false
        self.present(BVC(), animated: true, completion: nil)
    }
}

final class BVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Each(1).seconds.perform(on: self) {
            print("timer called")
            return .continue
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dismiss(animated: true, completion: nil)
    }
}
