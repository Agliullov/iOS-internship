//
//  Helpers.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 27.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var redColor: UIColor {
        return UIColor(red: 254 / 255, green: 116 / 255, blue: 96 / 255, alpha: 1.0)
    }
    
    static var greenColor: UIColor {
        return UIColor(displayP3Red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1.0)
    }
    
    static var grayColor: UIColor {
        return UIColor(red: 73 / 255, green: 74 / 255, blue: 74 / 255, alpha: 1.0)
    }
    
    static var imageColor: UIColor {
        return UIColor(red: 98 / 255, green: 127 / 255, blue: 143 / 255, alpha: 1.0)
    }
    
    static var likesGrayImage: UIColor {
        return UIColor(red: 232 / 255, green: 237 / 255, blue: 237 / 255, alpha: 1.0)
    }
    
    static var likesGrayColor: UIColor {
        return UIColor(red: 148 / 255, green: 153 / 255, blue: 138 / 255, alpha: 1.0)
    }
    
    static var collectionCategoryCellColor: UIColor {
        return UIColor(red: 234 / 255, green: 237 / 255, blue: 232 / 255, alpha: 1.0)
    }
}

extension UIView { //Activity indicator
    
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 1111
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(1111){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
