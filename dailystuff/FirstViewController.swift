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
    
    @IBOutlet var mainTableView: UITableView!
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         self.tabBarController?.delegate = self
        
        // 1
        let followingQuery = PFQuery(className: "Follow")
        //followingQuery.whereKey("fromUser", equalTo:PFUser.currentUser()!)
                
        // 2
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey("user", matchesKey: "toUser", inQuery: followingQuery)
        
        // 3
        let postsFromThisUser = Post.query()
        //postsFromThisUser!.whereKey("user", equalTo: PFUser.currentUser()!)
        
        // 4
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        // 5
        //query.includeKey("user")
        // 6
        query.orderByDescending("createdAt")
        
        
        
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

extension FirstViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell")!
        
        cell.textLabel!.text = "Post"
        
        return cell
    }
    
}

