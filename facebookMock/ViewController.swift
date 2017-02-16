//
//  ViewController.swift
//  facebookMock
//
//  Created by Bishal Kurumbang on 09/02/17.
//  Copyright © 2017 kBangProduction. All rights reserved.
//

import UIKit

class Post: NSObject{
    
    var name: String?
    var statusText: String?
    var profileImageName: String?
    var statusImageName: String?
    var location: Location?
    var numLikes: NSNumber?
    var numComments: NSNumber?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location" {
            location = Location()
            location?.setValuesForKeys(value as! [String: AnyObject])
        }else{
            super.setValue(value, forKey: key)
        }
    }

    
}

class Location: NSObject{
    var city: String?
    var state: String?
}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News Feed"
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        
        if let path = Bundle.main.path(forResource: "Posts", ofType: "json") {
            
            do {
                
                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
                
                let jsonDictionary = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any]
                
                if let postsArray = jsonDictionary?["posts"] as? [[String: AnyObject]] {
                    
                    self.posts = [Post]()
                    
                    for postDictionary in postsArray {
                        let post = Post()
                        post.setValuesForKeys(postDictionary)
                        self.posts.append(post)
                    }
                    
                }
                
            } catch let err {
                print(err)
            }
            
        }
        
//        let post1 = Post()
//        post1.name = "Alex Cortney"
//        post1.statusText = "When you find peace within yourself, you become the kind of person who can live at peace with others"
//        post1.profileImageName = "profileImage1"
//        //post1.statusImage = "statusImage1"
//        post1.statusImageName = "https://images.unsplash.com/photo-1472461936147-645e2f311a2b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1600&h=900&fit=crop&s=7dd6961d773918b1ea8446bafae89386"
//        
//        let post2 = Post()
//        post2.name = "Jessica Smith"
//        post2.statusText = "Your life is a sacred journey. It is about change, growth, discovery, movement, transformation, continuously expanding your vision of what is possible, stretching your soul, learning to see clearly and deeply, listening to your intuition, taking courageous challenges at every step along the way. You are on the path... exactly where you are meant to be right now... And from here, you can only go forward, shaping your life story into a magnificent tale of triumph, of healing, of courage, of beauty, of wisdom, of power, of dignity, and of love."
//        post2.profileImageName = "profileImage2"
//       // post2.statusImage = "statusImage2"
//        post2.statusImageName = "https://images.unsplash.com/photo-1484627147104-f5197bcd6651?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1600&h=900&fit=crop&s=f461c672b8c2abcd140042e8954403f2"
//        
//        let post3 = Post()
//        post3.name = "Miles Bonn"
//        post3.statusText = "I Love my new Camera!!"
//        post3.profileImageName = "profileImage3"
//        post3.statusImageName = "https://images.unsplash.com/photo-1461187655092-c5597dbaf59f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1600&h=900&fit=crop&s=fdb1d93644d8ca712979e1f9d249ba40"
//        posts.append(post1)
//        posts.append(post2)
//        posts.append(post3)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        cell.backgroundColor = UIColor.white
        cell.posts = posts[indexPath.item]
        
        cell.feedController = self
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].statusText{
            // It gives the roughly estamited height of the textView.
            let rect = NSString(string: statusText).boundingRect(with: CGSize.init(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)], context: nil)
            
            let knownHeight: CGFloat = 8+44+4+4+200+8+24+8+1+44+24
            
            return CGSize.init(width: view.frame.width, height: rect.height + knownHeight)
            
        }
        return CGSize.init(width: view.frame.width, height: 450)
    }
    
    
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        collectionView?.collectionViewLayout.invalidateLayout()
//    }
    
    let blackbackgroundView = UIView()
    var statusImageView: UIImageView?
    let zoomImageView = UIImageView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    
    func animateImageView(statusImageView: UIImageView){
        self.statusImageView = statusImageView
        
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            
            blackbackgroundView.backgroundColor = UIColor.black
            blackbackgroundView.frame = self.view.frame
            blackbackgroundView.alpha = 0
            view.addSubview(blackbackgroundView)
            
            statusImageView.alpha = 0
            
            
            // 20 for the heigh of status bar and 44 is the height of navbar
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = UIColor.black
            navBarCoverView.alpha = 0
            
           
            // TabBarCoverView
           
            
            // since navbar is at the top navBarCoverView needs/should be top of the navBar.. the following code give ur the entier main window which has subviews lying on it
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
                
                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: 1000, height: 49)
                tabBarCoverView.backgroundColor = UIColor.black
                tabBarCoverView.alpha = 0
                
                keyWindow.addSubview(tabBarCoverView)
            }
            
            
            
            zoomImageView.backgroundColor = UIColor.red
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.frame = startingFrame
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedController.zoomOut)))
            
            UIView.animate(withDuration: 0.75) {
                let height = ( self.view.frame.width / startingFrame.width ) * startingFrame.height
                
                let y = self.view.frame.height / 2 - height / 2
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackbackgroundView.alpha = 1
                
                self.navBarCoverView.alpha = 1
                
                self.tabBarCoverView.alpha = 1
            }
        }
        
        
    }
    
    func zoomOut(){
        
        if let startingFrame = statusImageView!.superview?.convert(statusImageView!.frame, to: nil){
            
            UIView.animate(withDuration: 0.75, animations: { 
                self.zoomImageView.frame = startingFrame
                self.blackbackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
            }, completion: { (didComplete) in
                self.zoomImageView.removeFromSuperview()
                self.blackbackgroundView.removeFromSuperview()
                self.statusImageView?.alpha = 1
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
            })
        }
        
    }
    
}



