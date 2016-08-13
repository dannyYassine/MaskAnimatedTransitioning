//
//  NavigationController.swift
//  MaskAway
//
//  Created by Danny Yassine on 2016-08-12.
//  Copyright © 2016 DannyYassine. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    var navigationControllerDelegate: NavigationControllerDelegate? = NavigationControllerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self.navigationControllerDelegate
        
    }
    
    override func awakeFromNib() {
        self.navigationControllerDelegate?.navigationController = self
        self.navigationControllerDelegate?.addPanGesture()
    }
    
}
