//
//  FirstViewController.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 20/11/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var locationTextField : UITextField!
    @IBOutlet var locationLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func calculateTapped(sender : AnyObject) {
    }
    @IBAction func taxPercentageChanged(sender : AnyObject) {
    }
    @IBAction func viewTapped(sender : AnyObject) {
    } 

}

