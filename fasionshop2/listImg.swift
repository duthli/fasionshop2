//
//  listImg.swift
//  fasionshop2
//
//  Created by do duy hung on 07/09/2016.
//  Copyright © 2016 do duy hung. All rights reserved.
//

import UIKit

class listImg: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchBut(sender: AnyObject) {
        switch (sender.tag)
        {
        case 101: pushView(0)
        case 102: pushView(1)
        case 103: pushView(2)
        case 104: pushView(3)
        case 105: pushView(4)
        case 106: pushView(5)

        default: break
        }
    }
    func pushView(index: Int)
    {
        let listView = self.storyboard?.instantiateViewControllerWithIdentifier("viewScroll") as? scrollView
        //listView?.currentPage = index
        listView?.shop = index+1
        self.navigationController?.pushViewController(listView!, animated: true)
    }
}
