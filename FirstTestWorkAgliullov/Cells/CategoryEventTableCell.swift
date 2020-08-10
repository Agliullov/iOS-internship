//
//  CategoryEventCollectionViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 27.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class CategoryEventCollectionViewCell: UICollectionViewCell {
  
  var mainLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = .boldSystemFont(ofSize: 21.0)
    label.textColor = UIColor(red: 98 / 255, green: 127 / 255, blue: 143 / 255, alpha: 1.0)
    return label
  }()
  
  var imageName: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .center
    return imageView
  }()
  
  var imageLogo: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .center
    return imageView
  }()
  
  var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = .boldSystemFont(ofSize: 15.0)
    label.textColor = UIColor(red: 22 / 255, green: 59 / 255, blue: 79 / 255, alpha: 1.0)
    return label
  }()
  
  var calendarLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.backgroundColor = GREEN_COLOR
    label.font = .boldSystemFont(ofSize: 11.0)
    label.textColor = UIColor.white
    return label
  }()
  
  var stackView: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    stack.alignment = .center
    stack.spacing = 20
    
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .center
    imageView.image = UIImage(named: "shape")
    stack.addSubview(imageView)
    return stack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.backgroundColor = WHITE_COLOR
    self.initSetup()
  }
  
//  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//    super.init(style: style, reuseIdentifier: reuseIdentifier)
//    self.contentView.backgroundColor = WHITE_COLOR
//    self.initSetup()
//  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.initSetup()
  }
  
  fileprivate func initSetup(){
    self.contentView.addSubview(imageName)
    self.contentView.addSubview(mainLabel)
    self.contentView.addSubview(imageLogo)
    self.contentView.addSubview(descriptionLabel)
    self.stackView.addSubview(calendarLabel)
    self.contentView.addSubview(stackView)
    let constraints: [NSLayoutConstraint] = [
      
      //imageName
      self.imageName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4.0),
      self.imageName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 4.0),
      self.contentView.rightAnchor.constraint(equalTo: self.imageName.rightAnchor, constant: 4.0),
      self.imageName.heightAnchor.constraint(equalToConstant: 231.0),
      
      //mainLabel
      self.mainLabel.topAnchor.constraint(equalTo: self.imageName.bottomAnchor, constant: -10.0),
      self.mainLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      self.mainLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 40.0),
      self.contentView.rightAnchor.constraint(equalTo: self.mainLabel.rightAnchor, constant: 40.0),
      
      
      //imageLogo
      self.imageLogo.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor, constant: 8.0),
      self.imageLogo.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      
      
      //descriptionLabel
      self.descriptionLabel.topAnchor.constraint(equalTo: self.imageLogo.bottomAnchor, constant: 8.0),
      self.descriptionLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      self.descriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20.0),
      self.contentView.rightAnchor.constraint(equalTo: self.descriptionLabel.rightAnchor, constant: 20.0),
      
      //stackView
      self.stackView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16.0),
      self.contentView.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor),
      self.stackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8.0),
      self.contentView.rightAnchor.constraint(equalTo: self.stackView.rightAnchor, constant: 8.0),
      self.stackView.heightAnchor.constraint(equalToConstant: 30.0)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  func setup(event: Events) {
    if let image = UIImage(named: event.imageName) {
      self.imageName.image = image
    }
    
    self.mainLabel.text = event.mainLabel
    
    if let image = UIImage(named: event.imageLogo) {
      self.imageLogo.image = image
    }
    
    self.descriptionLabel.text = event.descriptionLabel
    
    self.calendarLabel.text = event.calendarLabel    
  }
}
