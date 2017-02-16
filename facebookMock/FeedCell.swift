//
//  FeedCell.swift
//  facebookMock
//
//  Created by Bishal Kurumbang on 14/02/17.
//  Copyright © 2017 kBangProduction. All rights reserved.
//

import Foundation
import UIKit

class FeedCell: UICollectionViewCell{
    
    var feedController: FeedController?
    
    func animate(){
        feedController?.animateImageView(statusImageView: statusImageView)
        
    }
    
    var posts: Post?{
        didSet{
            
            statusImageView.image = nil
            if let statusImage = posts?.statusImageName{
                
                let url = URL(string: statusImage)
                let session = URLSession.shared
                session.dataTask(with: url!, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error as Any)
                        return
                    }
                    let image = UIImage(data: data!)
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.statusImageView.image = image
                        self.loader.stopAnimating()
                    })
                    
                }).resume()
                
                statusImageView.image = UIImage(named: statusImage)
                
            }
           setupNameLocationStatusAndProfileImage()
        }
    }
    
    let loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.startAnimating()
        return indicator
    }()
    
    let nambeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let statusTextView : UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let statusImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    let likeButton = FeedCell.buttonForTitle(title: "Like", imageName: "like")
    let commentButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment")
    let shareButton = FeedCell.buttonForTitle(title: "Share", imageName: "share")
    
    
    static func buttonForTitle(title: String, imageName: String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.setImage(UIImage(named:imageName), for: .normal)
        button.imageView?.tintColor = UIColor.rgb(red: 143, green: 150, blue: 163)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        addSubview(nambeLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        statusImageView.addSubview(loader)
        
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedCell.animate as (FeedCell) -> () -> ())))
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nambeLabel)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nambeLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(1)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
        addConstraintsWithFormat(format: "H:|-4-[v0]|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: loader)
        addConstraintsWithFormat(format: "V:|[v0]|", views: loader)
        
    }

    
    private func setupNameLocationStatusAndProfileImage(){
        
        if let name = posts?.name{
            if let location = posts?.location{
                let city = location.city!
                let state = location.state!
            
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "\nDecember 18 • \(city), \(state) • ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName: UIColor.rgb(red: 155, green: 161, blue: 171)]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "globe_small")
            attachment.bounds = CGRect.init(x: 0, y: -2, width: 12, height: 12)
            
            attributedText.append(NSAttributedString(attachment: attachment))
            
            nambeLabel.attributedText = attributedText
            }
        }
        
        if let statusText = posts?.statusText{
            statusTextView.text = statusText
        }
        
        if let profileImage = posts?.profileImageName{
            profileImageView.image = UIImage(named: profileImage)
        }
        
        if let likes = posts?.numLikes{
            if let comment = posts?.numComments{
                likesCommentsLabel.text = "\(likes) Likes   \(comment) Comments"
            }
        }
        
    }
}
