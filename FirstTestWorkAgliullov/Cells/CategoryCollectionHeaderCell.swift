//
//  CategoryCollectionHeaderCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 16.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class CategoryCollectionHeaderCell: UICollectionReusableView { //Заголовок категорий
    
    private let headerTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }
    
    fileprivate func initSetup(){
        self.addSubview(headerTextLabel)
        
        let constraints: [NSLayoutConstraint] = [
            headerTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            headerTextLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 4),
            self.rightAnchor.constraint(equalTo: headerTextLabel.rightAnchor),
            self.layoutMarginsGuide.bottomAnchor.constraint(equalTo: headerTextLabel.bottomAnchor, constant: -4)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setup(headerText: String) {
        headerTextLabel.text = headerText
    }
}
