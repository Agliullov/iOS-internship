//
//  EventFilterTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class EventFilterTableViewCell: UITableViewCell { //Ячейка фильтра
    
    var complitionHandler: (() -> ())?
    
    private let filterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    
    let filterSwitch: UISwitch = {
        let filterSwitch = UISwitch()
        filterSwitch.translatesAutoresizingMaskIntoConstraints = false
        filterSwitch.onTintColor = UIColor.greenColor
        return filterSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }
    
    fileprivate func initSetup(){
        contentView.addSubview(filterLabel)
        contentView.addSubview(filterSwitch)
        
        filterSwitch.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
        
        let constraints: [NSLayoutConstraint] = [
            //filterLabel
            filterLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            filterLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: filterLabel.bottomAnchor),
            
            //filterSwitch
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: filterSwitch.rightAnchor),
            filterSwitch.centerYAnchor.constraint(equalTo: filterLabel.centerYAnchor),
            filterSwitch.leftAnchor.constraint(equalTo: filterLabel.rightAnchor, constant: 8.0)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setup(filter: FiltersEntity) {
        filterLabel.text = filter.text
        filterSwitch.isOn = filter.isOn
    }
    
    @objc func switchValueChange() {
        complitionHandler?()
    }
}
