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
    UITabBar.appearance().tintColor = GREEN_COLOR
    UINavigationBar.appearance().barTintColor = GREEN_COLOR
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
    self.centerButton.backgroundColor = GREEN_COLOR
    self.centerButton.addTarget(self, action: #selector(setSelectedIndex), for: .touchUpInside)
    
    //back white circle view
    let borderLine: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    var borderLineFrame = borderLine.frame
    borderLineFrame.origin.y = self.view.bounds.height - borderLineFrame.height - 10
    borderLineFrame.origin.x = self.view.bounds.width / 2 - borderLineFrame.width / 2
    borderLine.frame = borderLineFrame
    borderLine.backgroundColor = .white
    borderLine.layer.cornerRadius = borderLine.frame.height / 2
    
    self.view.addSubview(borderLine)
    self.view.addSubview(self.centerButton)
    self.view.layoutIfNeeded()
  }
  
  @objc func setSelectedIndex() {
    self.selectedIndex = 2
    self.centerButton.backgroundColor = GREEN_COLOR
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    if viewController is HelpViewController {
      self.centerButton.backgroundColor = GREEN_COLOR
    } else {
      self.centerButton.backgroundColor = RED_COLOR
      
    }
  }
}
