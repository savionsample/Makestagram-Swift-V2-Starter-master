//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Savion Sample on 7/7/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Bond
import UIKit
import Parse


class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesIconImageView: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    
    var postDisposable: DisposableType?
    var likeDisposable: DisposableType?
    
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
         post?.toggleLikePost(PFUser.currentUser()!)
    }
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
    }
    
//    var post: Post? {
//        didSet {
//            // 1
//            if let post = post {
//                //2
//                // bind the image of the post to the 'postImage' view
//                post.image.bindTo(postImageView.bnd_image)
//            }
//        }
//    }
//    
//}



    var post: Post? {
        didSet {
            // 1
            postDisposable?.dispose()
            likeDisposable?.dispose()
            
            if let post = post {
                // 2
                postDisposable = post.image.bindTo(postImageView.bnd_image)
                likeDisposable = post.likes.observe { (value: [PFUser]?) -> () in
                    // 3
                    if let value = value {
                        // 4
                        self.likesLabel.text = self.stringFromUserList(value)
                        // 5
                        self.likeButton.selected = value.contains(PFUser.currentUser()!)
                        // 6
                        self.likesIconImageView.hidden = (value.count == 0)
                    } else {
                        // 7
                        self.likesLabel.text = ""
                        self.likeButton.selected = false
                        self.likesIconImageView.hidden = true
                    }
                }
            }
        }
    }
    
    // Generates a comma separated list of usernames from an array (e.g. "User1, User2")
    func stringFromUserList(userList: [PFUser]) -> String {
        // 1
        let usernameList = userList.map { user in user.username! }
        // 2
        let commaSeparatedUserList = usernameList.joinWithSeparator(", ")
        
        return commaSeparatedUserList
    }

}