//
//  ViewController.swift
//  fasionshop2
//
//  Created by do duy hung on 05/09/2016.
//  Copyright © 2016 do duy hung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pageimage : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addItem()
        print(pageimage.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addItem(){
        for (var i = 0 ; i < 8 ; i++ ){
            pageimage.append("shop1-\(i)")
        }
    }

}

