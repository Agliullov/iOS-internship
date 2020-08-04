//
//  EventTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 01.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell { //Благотворительные события
  
  private var mainView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.white
    view.layer.cornerRadius = 8.0
    view.clipsToBounds = true
    return view
  }()
  
  private var eventImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 8.0
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let shadowImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "shadow")
    return imageView
  }()
  
  private var eventTitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = IMAGE_COLOR
    label.font = UIFont.boldSystemFont(ofSize: 21.0)
    return label
  }()
  
  private let heartImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "separator")
    return imageView
  }()
  
  private var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = UIColor.black
    label.font = UIFont.systemFont(ofSize: 15.0)
    return label
  }()
  
  private var bottomButtonView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = GREEN_COLOR
    
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "calendarIcon")
    
    let timeLabel = UILabel()
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.textColor = UIColor.white
    timeLabel.font = UIFont.systemFont(ofSize: 11.0)
    
    let stackView = UIView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .clear
    
    stackView.addSubview(imageView)
    stackView.addSubview(timeLabel)
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      imageView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
      imageView.topAnchor.constraint(equalTo: stackView.topAnchor),
      
      timeLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8.0),
      timeLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
      stackView.rightAnchor.constraint(equalTo: timeLabel.rightAnchor),
      
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -7.0),
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initialSetup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.initialSetup()
  }
  
  private func initialSetup() {
    self.mainView.addSubview(self.eventImageView)
    self.mainView.addSubview(self.shadowImageView)
    self.mainView.addSubview(self.eventTitle)
    self.mainView.addSubview(self.heartImageView)
    self.mainView.addSubview(self.descriptionLabel)
    self.mainView.addSubview(self.bottomButtonView)
    
    self.contentView.addSubview(self.mainView)
    
    let constraints: [NSLayoutConstraint] = [
      //mainView
      self.mainView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8.0),
      self.mainView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
      self.contentView.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: 8.0),
      self.contentView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 8.0),
      
      //eventImageView
      self.eventImageView.heightAnchor.constraint(equalToConstant: 230.0),
      self.eventImageView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 4.0),
      self.eventImageView.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 4.0),
      self.mainView.rightAnchor.constraint(equalTo: self.eventImageView.rightAnchor, constant: 4.0),
      
      //shadowImageView
      self.shadowImageView.leftAnchor.constraint(equalTo: self.eventImageView.leftAnchor),
      self.shadowImageView.bottomAnchor.constraint(equalTo: self.eventImageView.bottomAnchor),
      self.shadowImageView.rightAnchor.constraint(equalTo: self.eventImageView.rightAnchor),
      
      //eventTitle
      self.eventTitle.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
      self.eventTitle.widthAnchor.constraint(equalToConstant: self.contentView.frame.width * 0.9),
      self.eventTitle.topAnchor.constraint(equalTo: self.eventImageView.bottomAnchor, constant: -14.0),
      self.eventTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 46.0),
      
      //heartImageView
      self.heartImageView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
      self.heartImageView.topAnchor.constraint(equalTo: self.eventTitle.bottomAnchor, constant: 8.0),
      
      //descriptionLabel
      self.descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60.0),
      self.descriptionLabel.widthAnchor.constraint(equalToConstant: self.contentView.frame.width * 0.9),
      self.descriptionLabel.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
      self.descriptionLabel.topAnchor.constraint(equalTo: self.heartImageView.bottomAnchor, constant: 8.0),
      
      //bottomButtonView
      self.bottomButtonView.heightAnchor.constraint(equalToConstant: 31.0),
      self.bottomButtonView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16.0),
      self.bottomButtonView.leftAnchor.constraint(equalTo: self.mainView.leftAnchor),
      self.mainView.rightAnchor.constraint(equalTo: self.bottomButtonView.rightAnchor),
      self.mainView.bottomAnchor.constraint(equalTo: self.bottomButtonView.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
    if #available(iOS 13.0, *) {
      self.contentView.backgroundColor = UIColor.secondarySystemBackground
    } else {
      self.contentView.backgroundColor = UIColor.gray
    }
  }
  
  func setup(event: Events) {
    if let image = UIImage(named: event.eventImageView) {
      self.eventImageView.image = image
    }
    
    self.eventTitle.text = event.eventTitle
    self.descriptionLabel.text = event.topDescriptionLabel
    
    for view in self.bottomButtonView.subviews {
      for label in view.subviews {
        if let timeLabel = label as? UILabel {
          timeLabel.text = event.timeLabel
        }
      }
    }
    self.setNeedsLayout()
  }
}
