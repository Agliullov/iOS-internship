//
//  EventTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 01.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell { //Благотворительные события
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8.0
        view.clipsToBounds = true
        return view
    }()
    
    private let eventImageView: UIImageView = {
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
    
    private let eventTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.imageColor
        label.font = UIFont.boldSystemFont(ofSize: 21.0)
        return label
    }()
    
    private let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "separator")
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    private let bottomButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.greenColor
        
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
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        if #available(iOS 13.0, *) {
            contentView.backgroundColor = UIColor.secondarySystemBackground
        } else {
            contentView.backgroundColor = UIColor.likesGrayImage
        }
        
        mainView.addSubview(eventImageView)
        mainView.addSubview(shadowImageView)
        mainView.addSubview(eventTitle)
        mainView.addSubview(heartImageView)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(bottomButtonView)
        
        contentView.addSubview(mainView)
        
        let constraints: [NSLayoutConstraint] = [
            //mainView
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            contentView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 8.0),
            contentView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 8.0),
            
            //eventImageView
            eventImageView.heightAnchor.constraint(equalToConstant: 230.0),
            eventImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 4.0),
            eventImageView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 4.0),
            mainView.rightAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: 4.0),
            
            //shadowImageView
            shadowImageView.leftAnchor.constraint(equalTo: eventImageView.leftAnchor),
            shadowImageView.bottomAnchor.constraint(equalTo: eventImageView.bottomAnchor),
            shadowImageView.rightAnchor.constraint(equalTo: eventImageView.rightAnchor),
            
            //eventTitle
            eventTitle.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            eventTitle.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.9),
            eventTitle.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: -14.0),
            eventTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 46.0),
            
            //heartImageView
            heartImageView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            heartImageView.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 8.0),
            
            //descriptionLabel
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60.0),
            descriptionLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.9),
            descriptionLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: heartImageView.bottomAnchor, constant: 8.0),
            
            //bottomButtonView
            bottomButtonView.heightAnchor.constraint(equalToConstant: 31.0),
            bottomButtonView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16.0),
            bottomButtonView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: bottomButtonView.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomButtonView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setup(event: EventsEntity) {
        if let image = UIImage(named: event.eventImageView) {
            eventImageView.image = image
        }
        
        eventTitle.text = event.eventTitle
        descriptionLabel.text = event.topDescriptionLabel
        
        for view in bottomButtonView.subviews {
            for label in view.subviews {
                if let timeLabel = label as? UILabel {
                    timeLabel.text = event.timeLabel
                }
            }
        }
        setNeedsLayout()
    }
}
