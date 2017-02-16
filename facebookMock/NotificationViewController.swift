//
//  NotificationViewController.swift
//  facebookMock
//
//  Created by Bishal Kurumbang on 14/02/17.
//  Copyright © 2017 kBangProduction. All rights reserved.
//

import UIKit

class Notifications: NSObject {
    var imageName: String?
    var smallIcon: String?
    var notificationLabel: String?
    var dateandTime: String?
}

class NotificationViewController: UITableViewController {
    private let cellId = "cellId"
    
    var notifications = [Notifications]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notifications"
        tableView.register(TableCell.self, forCellReuseIdentifier: cellId)
        
        let notification1 = Notifications()
        notification1.imageName = "jessicaSmith"
        notification1.smallIcon = "message_notification_icon"
        notification1.notificationLabel = "It's Jessica Smith's birthday today. Let her know that you're thinking about her."
        notification1.dateandTime = "Today at 12:00"
        
        let notification2 = Notifications()
        notification2.imageName = "alexCortney"
        notification2.smallIcon = "message_notification_icon"
        notification2.notificationLabel = "Alex Cortnex commented on your status.."
        notification2.dateandTime = "Yesterday at 12:00"
        
        let notification3 = Notifications()
        notification3.imageName = "milesBonn"
        notification3.smallIcon = "message_notification_icon"
        notification3.notificationLabel = "Miles Bonn replied on your status.."
        notification3.dateandTime = "Wednesday at 12:00"
        
        self.notifications.append(notification1)
        self.notifications.append(notification2)
        self.notifications.append(notification3)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableCell
        cell.notifications = notifications[indexPath.item]
        return cell
    }
    
    
}

class TableCell: UITableViewCell{
    
    var notifications: Notifications?{
        didSet{
            
            if let imageName = notifications?.imageName{
                notificationimageView.image = UIImage(named: imageName)
            }
            
            if let label = notifications?.notificationLabel{
                notificationLabel.text = label
            }
            
            if let icon = notifications?.smallIcon{
                smallImageIcon.image = UIImage(named: icon)
            }
            
            if let date = notifications?.dateandTime {
                
                let attributedText = NSMutableAttributedString(string: date , attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.rgb(red: 155, green: 161, blue: 171)])
                datelabel.attributedText = attributedText
                
            }
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let notificationimageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "jessicaSmith")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "It's Jessica Smith's birthday today. Let her know that you're thinking about her. It's Jessica Smith's birthday today. Let her know that you're thinking about her. "
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let smallImageIcon:  UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "message_notification_icon")
        return imageView
    }()
    
    
    let datelabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setupViews() {
        addSubview(notificationimageView)
        addSubview(notificationLabel)
        addSubview(smallImageIcon)
        addSubview(datelabel)
        
        addConstraintsWithFormat(format: "H:|-12-[v0(60)]-12-[v1]-12-|", views: notificationimageView, notificationLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0(60)]-12-[v1]-4-[v2]|", views: notificationimageView, smallImageIcon, datelabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(65)]", views: notificationimageView)
        addConstraintsWithFormat(format: "V:|-5-[v0]-3-[v1]", views: notificationLabel, smallImageIcon, datelabel)
        addConstraintsWithFormat(format: "V:|-5-[v0]-3-[v1]", views: notificationLabel, datelabel)
    }
}
