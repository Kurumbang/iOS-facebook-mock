//
//  Extensions.swift
//  facebookMock
//
//  Created by Bishal Kurumbang on 09/02/17.
//  Copyright © 2017 kBangProduction. All rights reserved.
//

import UIKit


extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictonary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictonary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictonary))
        
    }
}

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
