//
//  StartViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class StartViewController: UITabBarController, UITabBarControllerDelegate {
    
    private let greenColor : UIColor = UIColor(displayP3Red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1.0)
    private let redColor: UIColor = UIColor(displayP3Red: 254 / 255, green: 116 / 255, blue: 96 / 255, alpha: 1.0)
    private let centerButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor(red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor(red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.setSelectedIndex()
        self.setCenterButton()
    }
    
    func setCenterButton() {
        var menuButtonFrame = self.centerButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height - 15
        menuButtonFrame.origin.x = self.view.bounds.width / 2 - menuButtonFrame.width / 2
        self.centerButton.frame = menuButtonFrame
        
        self.centerButton.layer.cornerRadius = menuButtonFrame.height / 2
        self.centerButton.setImage(UIImage(named: "heart"), for: .normal)
        self.centerButton.contentMode = .scaleAspectFit
        self.centerButton.backgroundColor = self.greenColor
        self.centerButton.addTarget(self, action: #selector(setSelectedIndex), for: .touchUpInside)
        
        //back white circle view
        let borderLine: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var borderLineFrame = borderLine.frame
        borderLineFrame.origin.y = self.view.bounds.height - borderLineFrame.height - 10
        borderLineFrame.origin.x = self.view.bounds.width / 2 - borderLineFrame.width / 2
        borderLine.frame = borderLineFrame
        borderLine.backgroundColor = UIColor.white
        borderLine.layer.cornerRadius = borderLine.frame.height / 2
        
        self.view.addSubview(borderLine)
        self.view.addSubview(self.centerButton)
        self.view.layoutIfNeeded()
    }
    
    @objc func setSelectedIndex() {
        self.selectedIndex = 2
        self.centerButton.backgroundColor = self.greenColor
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is HelpViewController {
            self.centerButton.backgroundColor = self.greenColor
        } else {
            self.centerButton.backgroundColor = self.redColor
        }
    }
}
