//
//  DefaultGalleryImageCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 02.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DefaultGalleryImageCell: DefaultGridViewBlockCell {
    
    private var imageNames: [String] = []
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let thirdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubview(mainImageView)
        contentView.addSubview(secondImageView)
        contentView.addSubview(thirdImageView)
    }
    
    func setup(imageNames: [String]) {
        
        if let mainImage = UIImage(named: imageNames[0]) {
            mainImageView.image = mainImage
        }
        if let secondImage = UIImage(named: imageNames[1]) {
            secondImageView.image = secondImage
        }
        if let thirdImage = UIImage(named: imageNames[2]) {
            thirdImageView.image = thirdImage
        }
        
        let constraints: [NSLayoutConstraint] = [
            
            //mainImageView
            contentView.heightAnchor.constraint(equalTo: mainImageView.heightAnchor, constant: 15.0),
            mainImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height * 0.3),
            mainImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.7),
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            mainImageView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            
            //secondImageView
            secondImageView.topAnchor.constraint(equalTo: mainImageView.topAnchor),
            secondImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width * 0.25),
            secondImageView.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10.0),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: secondImageView.rightAnchor),
            
            //thirdImageView
            thirdImageView.topAnchor.constraint(equalTo: secondImageView.bottomAnchor, constant: 10.0),
            thirdImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width * 0.25),
            thirdImageView.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10.0),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: thirdImageView.rightAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: thirdImageView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
