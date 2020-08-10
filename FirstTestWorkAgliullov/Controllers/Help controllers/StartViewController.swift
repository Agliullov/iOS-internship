//
//  StartViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class StartViewController: UITabBarController, UITabBarControllerDelegate {
    
    private let centerButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.greenColor
        UINavigationBar.appearance().barTintColor = UIColor.greenColor
        UINavigationBar.appearance().tintColor = UIColor.white
        setSelectedIndex()
        setCenterButton()
    }
    
    func setCenterButton() {
        var menuButtonFrame = self.centerButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height - 15
        menuButtonFrame.origin.x = self.view.bounds.width / 2 - menuButtonFrame.width / 2
        centerButton.frame = menuButtonFrame
        
        centerButton.layer.cornerRadius = menuButtonFrame.height / 2
        centerButton.setImage(UIImage(named: "heart"), for: .normal)
        centerButton.contentMode = .scaleAspectFit
        centerButton.backgroundColor = UIColor.greenColor
        centerButton.addTarget(self, action: #selector(setSelectedIndex), for: .touchUpInside)
        
        //back white circle view
        let borderLine: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var borderLineFrame = borderLine.frame
        borderLineFrame.origin.y = view.bounds.height - borderLineFrame.height - 10
        borderLineFrame.origin.x = view.bounds.width / 2 - borderLineFrame.width / 2
        borderLine.frame = borderLineFrame
        borderLine.backgroundColor = .white
        borderLine.layer.cornerRadius = borderLine.frame.height / 2
        
        view.addSubview(borderLine)
        view.addSubview(self.centerButton)
    }
    
    @objc func setSelectedIndex() {
        selectedIndex = 2
        centerButton.backgroundColor = UIColor.greenColor
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is HelpViewController {
            centerButton.backgroundColor = UIColor.greenColor
        } else {
            centerButton.backgroundColor = UIColor.redColor
        }
    }
}
