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
    return self.cellTypes.count
  }
  
  init?() {
    var cellTypes: [DetailsEventCellType] = []
    cellTypes.append(contentsOf: DetailsEventCellType.allCases)
    self._cellTypes = cellTypes
    guard cellTypes.count == 0 else { return }
    return nil
  }
}

class DetailsEventViewController: UIViewController {
  
  private var displayedSections: [DetailsEventSection] = []
  
  var event: Events?
  
  var navigationTitle: String?
  
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width, bottom: 0, right: 0)
    
    tableView.register(DetailsInfoDefaultCell.self, forCellReuseIdentifier: String(describing: DetailsInfoDefaultCell.self))
    tableView.register(DefaultGalleryImageCell.self, forCellReuseIdentifier: String(describing: DefaultGalleryImageCell.self))
    tableView.register(DefaultLikesCell.self, forCellReuseIdentifier: String(describing: DefaultLikesCell.self))
    tableView.register(DefaultSingleInfoCell.self, forCellReuseIdentifier: String(describing: DefaultSingleInfoCell.self))
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = self.navigationTitle
    self.view.backgroundColor = UIColor.white
    
    self.navigationItem.setHidesBackButton(true, animated: true)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "rectangle"), style: .done, target: self, action: #selector(backVC)), animated: true)
    self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "sendIcon"), style: .done, target: self, action: #selector(sendVC)), animated: true)
    
    self.view.addSubview(self.tableView)
    self.tableView.frame = self.view.bounds
    
    self.tableView.dataSource = self
    
    self.getSections()
  }
  
  private func getSections() {
    var section: [DetailsEventSection] = []
    if let mainSection = DetailsEventSection() {
      section.append(mainSection)
    }
    self.displayedSections = section
  }
  
  @objc func backVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func sendVC(){
    
  }
}

extension DetailsEventViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.displayedSections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.displayedSections[section].cellCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let dataSource = self.event else { return UITableViewCell() }
    let section = self.displayedSections[indexPath.section]
    let cellType = section.cellTypes[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: section.cellTypes[indexPath.row].cellClass), for: indexPath)
    cell.selectionStyle = .none
    
    switch cellType {
    case .title:
      let titleCell = cell as! DefaultSingleInfoCell
      titleCell.defaultLabel.text = dataSource.eventTitle
      titleCell.defaultLabel.textColor = IMAGE_COLOR
      titleCell.defaultLabel.font = UIFont.boldSystemFont(ofSize: 21.0)
      return titleCell
      
    case .time:
      let timeCell = cell as! DetailsInfoDefaultCell
      timeCell.defaultTitleLabel.textColor = UIColor(red: 148 / 255, green: 153 / 255, blue: 138 / 255, alpha: 1.0)
      timeCell.setup(imageName: "calendarIcon", titles: [dataSource.timeLabel])
      return timeCell
      
    case .organizationName:
      let organizationNameCell = cell as! DefaultSingleInfoCell
      organizationNameCell.defaultLabel.text = dataSource.detailsInfo.organizationName
      organizationNameCell.defaultLabel.textColor = GRAY_COLOR
      organizationNameCell.defaultLabel.font = UIFont.systemFont(ofSize: 11.0)
      return organizationNameCell
      
    case .address:
      let addressCell = cell as! DetailsInfoDefaultCell
      addressCell.setup(imageName: "navIcon", titles: [dataSource.detailsInfo.eventAddress])
      addressCell.defaultTitleLabel.textColor = GRAY_COLOR
      addressCell.defaultTitleLabel.font = UIFont.systemFont(ofSize: 15.0)
      return addressCell
      
    case .phoneNumber:
      let phoneCell = cell as! DetailsInfoDefaultCell
      phoneCell.setup(imageName: "phoneIcon", titles: dataSource.detailsInfo.eventPhoneNumber.number)
      phoneCell.defaultTitleLabel.textColor = GRAY_COLOR
      phoneCell.defaultTitleLabel.font = UIFont.systemFont(ofSize: 15.0)
      return phoneCell
      
    case .help:
      let helpCell = cell as! DetailsInfoDefaultCell
      helpCell.setup(imageName: "mailIcon", titles: [dataSource.detailsInfo.serviceLabel])
      helpCell.defaultTitleLabel.font = UIFont.systemFont(ofSize: 15.0)
      helpCell.defaultTitleLabel.textColor = GREEN_COLOR
      helpCell.defaultTitleLabel.font = UIFont.systemFont(ofSize: 15.0)
      let url = URL(string: "https://www.google.com")!
      let helpString = dataSource.detailsInfo.serviceLabel + " " + dataSource.detailsInfo.topLinkLabel
      let attributedString = NSMutableAttributedString(string: helpString, attributes: [.foregroundColor : UIColor.gray])
      attributedString.setAttributes([.link: url], range: NSMakeRange(dataSource.detailsInfo.serviceLabel.count + 1, dataSource.detailsInfo.topLinkLabel.count))
      attributedString.setAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSMakeRange(dataSource.detailsInfo.serviceLabel.count + 1, dataSource.detailsInfo.topLinkLabel.count))
      helpCell.defaultTitleLabel.attributedText = attributedString
      return helpCell
      
    case .gallery:
      let galleryCell = cell as! DefaultGalleryImageCell
      galleryCell.setup(imageNames: dataSource.detailsInfo.imageCollection.imageName)
      return galleryCell
      
    case .centerDescription:
      let centerDescriptionCell = cell as! DefaultSingleInfoCell
      centerDescriptionCell.defaultLabel.text = dataSource.detailsInfo.centerDescriptionLabel
      centerDescriptionCell.defaultLabel.textColor = GRAY_COLOR
      centerDescriptionCell.defaultLabel.font = UIFont.systemFont(ofSize: 15.0)
      return centerDescriptionCell
      
    case .bottomDescription:
      let descriptionCell = cell as! DefaultSingleInfoCell
      descriptionCell.defaultLabel.text = dataSource.detailsInfo.bottomDescriptionLabel
      descriptionCell.defaultLabel.textColor = GRAY_COLOR
      descriptionCell.defaultLabel.font = UIFont.systemFont(ofSize: 15.0)
      return descriptionCell
      
    case .organozationWebSite:
      let organozationWebSiteCell = cell as! DefaultSingleInfoCell
      organozationWebSiteCell.defaultLabel.text = dataSource.detailsInfo.bottomLinkLabel
      organozationWebSiteCell.defaultLabel.textColor = GREEN_COLOR
      organozationWebSiteCell.defaultLabel.font = UIFont.systemFont(ofSize: 15.0)
      let attributedString = NSMutableAttributedString(string: dataSource.detailsInfo.bottomLinkLabel, attributes: [.foregroundColor : UIColor.gray])
      attributedString.setAttributes([.link: URL(string: "https://www.google.com")!], range: NSMakeRange(0, dataSource.detailsInfo.bottomLinkLabel.count))
      attributedString.setAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSMakeRange(0 , dataSource.detailsInfo.bottomLinkLabel.count))
      organozationWebSiteCell.defaultLabel.attributedText = attributedString
      return organozationWebSiteCell
      
    case .likes:
      let likesCell = cell as! DefaultLikesCell
      likesCell.setup(imageNames: dataSource.detailsInfo.likesImagesNames.imageName, likesCount: dataSource.detailsInfo.likesCountLabel)
      return likesCell
    }
  }
}
