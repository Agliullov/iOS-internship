//
//  StartViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 06.09.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.style = .gray
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.activityIndicator.stopAnimating()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarViewController = storyboard.instantiateViewController(withIdentifier: String(describing: MainTabBarViewController.self))
            tabBarViewController.modalPresentationStyle = .fullScreen
            self?.present(tabBarViewController, animated: true, completion: nil)
        }
    }
    
}
