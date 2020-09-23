//
//  EventFilterHeaderTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class EventFilterHeaderTableViewCell: UITableViewHeaderFooterView { //Заголовок фильтра
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }
    
    private func initSetup() {
        contentView.addSubview(titleLabel)
        
        let constraints: [NSLayoutConstraint] = [
            titleLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setup(textHeader: String) {
        titleLabel.text = textHeader
    }
}
