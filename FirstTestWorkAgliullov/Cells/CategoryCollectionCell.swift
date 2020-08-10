//
//  CategoryCollectionCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell { //Категории помощи
    
    private let screenFrame: CGSize = UIScreen.main.bounds.size
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()
    
    private let titleTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor.greenColor
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
        contentView.backgroundColor = UIColor.collectionCategoryCellColor
        contentView.addSubview(titleImageView)
        contentView.addSubview(titleTextLabel)
        
        let constraints: [NSLayoutConstraint] = [
            //titleImageView
            titleImageView.heightAnchor.constraint(equalToConstant: screenFrame.height / 5),
            titleImageView.widthAnchor.constraint(equalToConstant: screenFrame.width / 2.2),
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: titleImageView.rightAnchor),
            
            //titleTextLabel
            titleTextLabel.topAnchor.constraint(equalTo: titleImageView.bottomAnchor),
            titleTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: +10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setup(titleImageName: String, titleText: String) {
        if let image = UIImage(named: titleImageName) {
            titleImageView.image = image
        }
        titleTextLabel.text = titleText
    }
}
