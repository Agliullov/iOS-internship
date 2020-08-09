//
//  DetailsEventViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

private enum DetailsEventCellType: CaseIterable {
    case title
    case time
    case organizationName
    case address
    case phoneNumber
    case help
    case gallery
    case centerDescription
    case bottomDescription
    case organozationWebSite
    case likes
    
    var cellClass: UITableViewCell.Type {
        let cellClass: UITableViewCell.Type
        switch self {
        case .title, .organizationName, .centerDescription, .organozationWebSite, .bottomDescription:
            cellClass = DefaultSingleInfoCell.self
        case .time, .address, .phoneNumber, .help:
            cellClass = DetailsInfoDefaultCell.self
        case .gallery:
            cellClass = DefaultGalleryImageCell.self
        case .likes:
            cellClass = DefaultLikesCell.self
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

class DetailsEventViewController: UIViewController {
    
    private var displayedSections: [DetailsEventSection] = []
    
    var events: EventsEntity?
    
    var navigationTitle: String?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width, bottom: 0, right: 0)
        
        tableView.register(DetailsInfoDefaultCell.self, forCellReuseIdentifier: String(describing: DetailsInfoDefaultCell.self))
        tableView.register(DefaultGalleryImageCell.self, forCellReuseIdentifier: String(describing: DefaultGalleryImageCell.self))
        tableView.register(DefaultLikesCell.self, forCellReuseIdentifier: String(describing: DefaultLikesCell.self))
        tableView.register(DefaultSingleInfoCell.self, forCellReuseIdentifier: String(describing: DefaultSingleInfoCell.self))
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = navigationTitle
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "rectangle"), style: .done, target: self, action: #selector(backVC)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "sendIcon"), style: .done, target: self, action: #selector(sendVC)), animated: true)
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
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
    
    @objc func sendVC(){
        
    }
}

extension DetailsEventViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayedSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedSections[section].cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = events else { return UITableViewCell() }
        let section = displayedSections[indexPath.section]
        let cellType = section.cellTypes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: section.cellTypes[indexPath.row].cellClass), for: indexPath)
        cell.selectionStyle = .none
        
        switch cellType {
        case .title:
            let titleCell = cell as! DefaultSingleInfoCell
            titleCell.setup(title: dataSource.eventTitle, textColor: UIColor.imageColor, font: UIFont.boldSystemFont(ofSize: 21.0), attributedText: nil)
            return titleCell
            
        case .time:
            let timeCell = cell as! DetailsInfoDefaultCell
            timeCell.setup(imageName: "calendarIcon", titles: [dataSource.timeLabel], textColor: UIColor.likesGrayColor, font: nil, attributedText: nil)
            return timeCell
            
        case .organizationName:
            let organizationNameCell = cell as! DefaultSingleInfoCell
            organizationNameCell.setup(title: dataSource.detailsInfo.organizationName, textColor: UIColor.grayColor, font: UIFont.systemFont(ofSize: 11.0), attributedText: nil)
            return organizationNameCell
            
        case .address:
            let addressCell = cell as! DetailsInfoDefaultCell
            addressCell.setup(imageName: "navIcon", titles: [dataSource.detailsInfo.eventAddress], textColor: UIColor.grayColor, font: UIFont.systemFont(ofSize: 15.0), attributedText: nil)
            return addressCell
            
        case .phoneNumber:
            let phoneCell = cell as! DetailsInfoDefaultCell
            phoneCell.setup(imageName: "phoneIcon", titles: dataSource.detailsInfo.eventPhoneNumber.number, textColor: UIColor.grayColor, font: UIFont.systemFont(ofSize: 15.0), attributedText: nil)
            return phoneCell
            
        case .help:
            let helpCell = cell as! DetailsInfoDefaultCell
            
            let attributedString = NSMutableAttributedString(string: dataSource.detailsInfo.serviceLabel + " " + dataSource.detailsInfo.topLinkLabel, attributes: [.foregroundColor : UIColor.gray])
            attributedString.setAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSMakeRange(dataSource.detailsInfo.serviceLabel.count + 1, dataSource.detailsInfo.topLinkLabel.count))
            attributedString.setAttributes([.foregroundColor: UIColor.greenColor], range: NSMakeRange(dataSource.detailsInfo.serviceLabel.count + 1, dataSource.detailsInfo.topLinkLabel.count))
            
            helpCell.setup(imageName: "mailIcon", titles: [dataSource.detailsInfo.serviceLabel, dataSource.detailsInfo.topLinkLabel], textColor: UIColor.greenColor, font: UIFont.systemFont(ofSize: 15.0), attributedText: attributedString)
            return helpCell
            
        case .gallery:
            let galleryCell = cell as! DefaultGalleryImageCell
            galleryCell.setup(imageNames: dataSource.detailsInfo.imageCollection.imageName)
            return galleryCell
            
        case .centerDescription:
            let centerDescriptionCell = cell as! DefaultSingleInfoCell
            centerDescriptionCell.setup(title: dataSource.detailsInfo.centerDescriptionLabel, textColor: UIColor.grayColor, font: UIFont.systemFont(ofSize: 15.0), attributedText: nil)
            return centerDescriptionCell
            
        case .bottomDescription:
            let descriptionCell = cell as! DefaultSingleInfoCell
            descriptionCell.setup(title: dataSource.detailsInfo.bottomDescriptionLabel, textColor: UIColor.grayColor, font: UIFont.systemFont(ofSize: 15.0), attributedText: nil)
            return descriptionCell
            
        case .organozationWebSite:
            let organozationWebSiteCell = cell as! DefaultSingleInfoCell
            
            let attributedString = NSMutableAttributedString(string: dataSource.detailsInfo.bottomLinkLabel, attributes: [.foregroundColor : UIColor.gray])
            attributedString.setAttributes([.link: URL(string: "https://www.google.com")!], range: NSMakeRange(0, dataSource.detailsInfo.bottomLinkLabel.count))
            attributedString.setAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSMakeRange(0 , dataSource.detailsInfo.bottomLinkLabel.count))
            
            organozationWebSiteCell.setup(title: dataSource.detailsInfo.bottomLinkLabel, textColor: UIColor.greenColor, font: UIFont.systemFont(ofSize: 15.0), attributedText: attributedString)
            return organozationWebSiteCell
            
        case .likes:
            let likesCell = cell as! DefaultLikesCell
            likesCell.setup(imageNames: dataSource.detailsInfo.likesImagesNames.imageName, likesCount: dataSource.detailsInfo.likesCountLabel)
            return likesCell
        }
    }
}
