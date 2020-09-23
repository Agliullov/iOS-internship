//
//  MainMenuTabbar.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 04.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class MainMenuTabbar: UITabBar {
    
    var centerButton: UIButton?
    
    override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        if let centerButton = centerButton {
            if centerButton.frame.contains(point) {
                return true
            }
        }
        
        return self.bounds.contains(point)
    }
    
}
