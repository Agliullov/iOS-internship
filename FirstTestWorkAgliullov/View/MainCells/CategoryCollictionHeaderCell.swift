//
//  CategoryCollectionHeaderCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 16.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class CategoryCollectionHeaderCell: UICollectionViewCell {
    
    var headerTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите категорию помощи"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSetup()
    }
    
    fileprivate func initSetup(){
        self.contentView.addSubview(headerTextLabel)
        let constraints: [NSLayoutConstraint] = [
            self.headerTextLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.headerTextLabel.rightAnchor),
            self.headerTextLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor, constant: 5),
            self.headerTextLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor, constant: 5),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
