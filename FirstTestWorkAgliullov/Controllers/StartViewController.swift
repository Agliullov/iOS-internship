//
//  StartViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class StartViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor(red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor(red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.setCenterButton()
        self.setSelectedIndex()
    }
    
    func setCenterButton() {
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        var menuButtonFrame = button.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height - 15
        menuButtonFrame.origin.x = self.view.bounds.width / 2 - menuButtonFrame.width / 2
        button.frame = menuButtonFrame
        button.backgroundColor = UIColor(red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1.0)
        button.layer.cornerRadius = menuButtonFrame.height / 2
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(setSelectedIndex), for: .touchUpInside)
        
        //back white circle view
        let borderLine: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var borderLineFrame = borderLine.frame
        borderLineFrame.origin.y = self.view.bounds.height - borderLineFrame.height - 10
        borderLineFrame.origin.x = self.view.bounds.width / 2 - borderLineFrame.width / 2
        borderLine.frame = borderLineFrame
        borderLine.backgroundColor = UIColor.white
        borderLine.layer.cornerRadius = borderLine.frame.height / 2
        
        //back gray half circle line
        let arcCenter = CGPoint(x: borderLine.frame.size.width / 2, y: borderLine.frame.size.height / 2)
        let circleRadius = borderLine.frame.size.width / 2
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: circleRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
        let color = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.2)
        let semiCircleLayer = CAShapeLayer()
        semiCircleLayer.path = circlePath.cgPath
        semiCircleLayer.fillColor = color.cgColor
        borderLine.layer.addSublayer(semiCircleLayer)
        
        self.view.addSubview(borderLine)
        self.view.addSubview(button)
        self.view.layoutIfNeeded()
    }
    
    @objc func setSelectedIndex() {
        self.selectedIndex = 2
    }
}
