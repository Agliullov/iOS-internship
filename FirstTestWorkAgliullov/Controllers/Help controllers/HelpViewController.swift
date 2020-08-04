//
//  HelpViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

enum CategoryEnum: Int, CaseIterable { //Фильтрация по категориям
  case Kids
  case Adults
  case Elderly
  case Animals
  case Events
  case Default
  
  init(name: String) {
    switch name {
    case "Kids":
      self = .Kids
    case "Adults":
      self = .Adults
    case "Elderly":
      self = .Elderly
    case "Animals":
      self = .Animals
    case "Events":
      self = .Events
    default:
      self = .Default
    }
  }
}

class HelpViewController: UIViewController {
  
  @IBOutlet weak var helpCenterCollectionView: UICollectionView!
  
  private let titleCellIdentifier: String = "CategoryCollectionHeaderCell"
  private let cellIdentifier: String = "HelpCenterCollectionCell"
  
  fileprivate var sections: [Categories] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Помочь"
    self.view.backgroundColor = UIColor.white
    
    let textColorAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21.0), NSAttributedString.Key.foregroundColor: UIColor.white]
    self.navigationController?.navigationBar.titleTextAttributes = textColorAttribute
    
    self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "rectangle"), style: .done, target: self, action: #selector(exitApp)), animated: true)
    
    self.helpCenterCollectionView.delegate = self
    self.helpCenterCollectionView.dataSource = self
    
    self.helpCenterCollectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
    self.helpCenterCollectionView.register(CategoryCollectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: titleCellIdentifier)
    
    if let categories = self.getDataSourceFromJSON(fileName: "categories") {
      self.sections = categories
    }
  }
  
  func getDataSourceFromJSON(fileName: String) -> [Categories]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let objects = NetworkDataFetcher.shared.decodeJSONData(type: [Categories].self, from: data)
        return objects
      } catch {
        print("Error! Unable to parse  \(fileName).json")
      }
    }
    return nil
  }
  
  @objc func exitApp() {
    UIControl().sendAction(#selector((NSXPCConnection.suspend)), to: UIApplication.shared, for: nil)
  }
  
  fileprivate func openEventsVC(section: Categories) {
    let eventVC = EventViewController()
    let selectedEvent = CategoryEnum(name: section.primaryKey)
    eventVC.categoryEnum = selectedEvent
    eventVC.navigationTitle = title
    self.navigationController?.pushViewController(eventVC, animated: true)
  }
}

extension HelpViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.sections.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CategoryCollectionCell {
      let data = self.sections[indexPath.row]
      cell.setup(titleImageName: data.imageName, titleTextLabel: data.title)
      return cell
    }
    return UICollectionViewCell()
  }
}

extension HelpViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let section = self.sections[indexPath.row]
    self.openEventsVC(section: section)
  }
}

extension HelpViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      let reusableCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.titleCellIdentifier, for: indexPath) as! CategoryCollectionHeaderCell
      return reusableCell
    default:
      fatalError("Not implemented")
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if #available(iOS 13.0, *) {
          return CGSize(width: self.view.bounds.width, height: COLLECTION_HEADER_HEIGHT)
    } else {
      return CGSize(width: self.view.bounds.width, height: 40.0)
    }
  }
}
