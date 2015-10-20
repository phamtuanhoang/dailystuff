//
//  Post.swift
//  dailystuff
//
//  Created by hoangpham on 19/10/15.
//  Copyright © 2015 hoangpham. All rights reserved.
//

import Foundation


// 1
class Post : PFObject, PFSubclassing {
    
    // 2
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    var image: UIImage?
    var photoUploadTask: UIBackgroundTaskIdentifier?

    //MARK: PFSubclassing Protocol
    
    // 3
    static func parseClassName() -> String {
        return "Post"
    }
    
    // 4
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
    func uploadPost() {
        let imageData = UIImageJPEGRepresentation(image!, 0.8)
        let imageFile = PFFile(data: imageData!)
        
        // 1
        photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        
        // 2
        imageFile!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            // 3
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        
        imageFile!.saveInBackgroundWithBlock(nil)
        user = PFUser.currentUser()
        user!.saveInBackground()
        self.imageFile = imageFile
        saveInBackgroundWithBlock(nil)
    }
}