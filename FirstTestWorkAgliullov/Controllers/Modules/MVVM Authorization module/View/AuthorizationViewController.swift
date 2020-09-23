//
//  AuthorizationViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

private enum DetailsEventCellType: CaseIterable {
    case topText
    case socialActions
    case centerText
    case email
    case password
    case loginButton
    case registerLabel
    
    var cellClass: UITableViewCell.Type {
        let cellClass: UITableViewCell.Type
        switch self {
        case .topText, .centerText:
            cellClass = AuthorizationLabelTableViewCell.self
        case .socialActions:
            cellClass = AuthorizationSocialTableViewCell.self
        case .email, .password:
            cellClass = AuthorizationTextFieldTableViewCell.self
        case .loginButton:
            cellClass = AuthorizationButtonTableViewCell.self
        case .registerLabel:
            cellClass = AuthorizationRegisterLinkTableViewCell.self
        }
        return cellClass
    }
}

fileprivate struct DetailsEventSection {
    
    private var _cellTypes: [DetailsEventCellType] = []
    
    var cellTypes: [DetailsEventCellType] {
        return _cellTypes
    }
    
    var cellCount: Int {
        return cellTypes.count
    }
    
    init?() {
        var cellTypes: [DetailsEventCellType] = []
        cellTypes.append(contentsOf: DetailsEventCellType.allCases)
        _cellTypes = cellTypes
        guard cellTypes.count == 0 else { return }
        return nil
    }
}

class AuthorizationViewController: UIViewController {
    
    var navigationTitle: String?
        
    private var mode: ControllerMode = .viewing
    
    private var displayedSections: [DetailsEventSection] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.white
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width, bottom: 0, right: 0)
        
        tableView.register(AuthorizationLabelTableViewCell.self, forCellReuseIdentifier: String(describing: AuthorizationLabelTableViewCell.self))
        tableView.register(AuthorizationSocialTableViewCell.self, forCellReuseIdentifier: String(describing: AuthorizationSocialTableViewCell.self))
        tableView.register(AuthorizationTextFieldTableViewCell.self, forCellReuseIdentifier: String(describing: AuthorizationTextFieldTableViewCell.self))
        tableView.register(AuthorizationButtonTableViewCell.self, forCellReuseIdentifier: String(describing: AuthorizationButtonTableViewCell.self))
        tableView.register(AuthorizationRegisterLinkTableViewCell.self, forCellReuseIdentifier: String(describing: AuthorizationRegisterLinkTableViewCell.self))
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = navigationTitle
        view.addSubview(tableView)
        
        let textColorAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21.0), NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textColorAttribute
        
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "rectangle"), style: .done, target: self, action: #selector(backVC)), animated: true)
        
        tableView.frame = view.bounds
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getSections()
        
    }
    
    private func getSections() {
        var section: [DetailsEventSection] = []
        if let mainSection = DetailsEventSection() {
            section.append(mainSection)
        }
        displayedSections = section
    }
    
    @objc func backVC() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Activity Indicator
    private func setMode(mode: ControllerMode) {
        self.mode = mode
        self.updateNavigationItems(animated: true)
    }
    
    private func updateNavigationItems(animated: Bool) {
        switch self.mode {
        case .viewing:
            navigationItem.setRightBarButton(nil, animated: animated)
        case .editing:()
        case .updating:
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.color = UIColor.white
            activityIndicator.startAnimating()
            
            let rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
            navigationItem.setRightBarButton(rightBarButtonItem, animated: animated)
            navigationItem.setHidesBackButton(true, animated: animated)
        }
    }
}

extension AuthorizationViewController: UITableViewDelegate {
    
}

extension AuthorizationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayedSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedSections[section].cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = displayedSections[indexPath.section]
        let cellType = section.cellTypes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: section.cellTypes[indexPath.row].cellClass), for: indexPath)
        cell.selectionStyle = .none
        
        switch cellType {
        case .topText:
            let topCell = cell as! AuthorizationLabelTableViewCell
            let text = "Для участия в мероприятиях войдите в приложение через социальные сети"
            topCell.setupValue(textLabel: text, textAlignment: .center, textColor: UIColor.grayColor, attributedText: nil, padding: 75.0)
            return topCell
            
        case .socialActions:
            let galleryCell = cell as! AuthorizationSocialTableViewCell
            return galleryCell
            
        case .centerText:
            let centerCell = cell as! AuthorizationLabelTableViewCell
            let text = "Или авторизуйтесь через приложение"
            centerCell.setupValue(textLabel: text, textAlignment: .center, textColor: UIColor.grayColor, attributedText: nil, padding: 40.0)
            return centerCell
            
        case .email:
            let emailCell = cell as! AuthorizationTextFieldTableViewCell
            emailCell.setup(isPassTextField: false)
            return emailCell
            
        case .password:
            let passCell = cell as! AuthorizationTextFieldTableViewCell
            passCell.setup(isPassTextField: true)
            return passCell
            
        case .loginButton:
            let buttonCell = cell as! AuthorizationButtonTableViewCell
            return buttonCell
            
        case .registerLabel:
            let registerCell = cell as! AuthorizationRegisterLinkTableViewCell
            return registerCell
        }
        
    }
    
}
