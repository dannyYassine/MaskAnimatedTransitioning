//
//  ViewController.swift
//  MaskAway
//
//  Created by Danny Yassine on 2016-08-12.
//  Copyright © 2016 DannyYassine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor(red: CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            , green: CGFloat(Float(arc4random()) / Float(UINT32_MAX))
, blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX))
, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.add))
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func add() {
        self.performSegueWithIdentifier("show", sender: self)
    }

}

