//
//  ViewController.swift
//  LocationManager
//
//  Created by shahidlatif2005@gmail.com on 02/20/2020.
//  Copyright (c) 2020 shahidlatif2005@gmail.com. All rights reserved.
//

import UIKit
import LocationManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = LocationManager.shared
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

