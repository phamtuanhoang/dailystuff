//
//  FirstViewController.swift
//  dailystuff
//
//  Created by hoangpham on 19/10/15.
//  Copyright © 2015 hoangpham. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

var photoTakingHelper: PhotoHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         self.tabBarController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //handle take photo 
    func takePhoto(){
        //instantiate photo taking class, provide callback
      photoTakingHelper = PhotoHelper(viewController: self.tabBarController!, callback: { (image: UIImage?) in
        let post = Post()
        post.image = image
        post.uploadPost()
        })
    
    }
}

//extension tab bar delage


extension FirstViewController: UITabBarControllerDelegate{
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is SecondViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }
}

