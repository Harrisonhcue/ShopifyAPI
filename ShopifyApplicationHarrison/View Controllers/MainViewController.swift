//
//  ViewController.swift
//  ShopifyApplicationHarrison
//
//  Created by Harrison U-Ebili  on 2019-01-19.
//  Copyright © 2019 com.Harrisonhcue. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var btnViewCollections:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   @IBAction func showCollections(sender:UIButton)
    {
        self.performSegue(withIdentifier: "showCustomCollections", sender: nil)
    }


}

