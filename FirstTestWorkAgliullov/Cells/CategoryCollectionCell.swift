//
//  CategoryCollectionCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()
    
    var titleTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 0.7)
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
        self.contentView.backgroundColor = UIColor(red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 0.4)
        self.contentView.addSubview(titleImageView)
        self.contentView.addSubview(titleTextLabel)
        let constraints: [NSLayoutConstraint] = [
            
            //titleImageView
            self.titleImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.titleImageView.rightAnchor),
            
            //titleTextLabel
            self.titleTextLabel.topAnchor.constraint(equalTo: self.titleImageView.bottomAnchor),
            self.titleTextLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.titleTextLabel.rightAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.titleTextLabel.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
