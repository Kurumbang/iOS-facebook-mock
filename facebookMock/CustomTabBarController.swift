//
//  CustomTabBarController.swift
//  facebookMock
//
//  Created by Bishal Kurumbang on 14/02/17.
//  Copyright © 2017 kBangProduction. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let feedController = FeedController(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: feedController)
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        let friendRequestController = FriendRequestsController()
        let freindRequestNavigationController = UINavigationController(rootViewController: friendRequestController)
        freindRequestNavigationController.title = "Requests"
        freindRequestNavigationController.tabBarItem.image = UIImage(named: "requests_icon")
        
        let messengerViewController = UIViewController()
        let messengerNavigationViewController = UINavigationController(rootViewController: messengerViewController)
        messengerNavigationViewController.title = "Messenger"
        messengerNavigationViewController.tabBarItem.image = UIImage(named: "messenger_icon")
        
        let notificationViewController = NotificationViewController()
        let notificationNavigationViewController = UINavigationController(rootViewController: notificationViewController)
        notificationNavigationViewController.title = "Notifications"
        notificationNavigationViewController.tabBarItem.image = UIImage(named: "globe_icon")
        
        let moreViewController = UIViewController()
        let moreNavigationViewController = UINavigationController(rootViewController: moreViewController)
        moreNavigationViewController.title = "More"
        moreNavigationViewController.tabBarItem.image = UIImage(named: "more_icon")
        
        viewControllers = [navigationController, freindRequestNavigationController, messengerNavigationViewController, notificationNavigationViewController, moreNavigationViewController]
        
        tabBar.isTranslucent = false
        
        
        let topBorder = CALayer()
        topBorder.frame = CGRect.init(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        
    }
    
    

    
}
