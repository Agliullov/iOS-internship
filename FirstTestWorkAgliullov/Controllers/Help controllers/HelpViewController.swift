//
//  HelpViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

let COLLECTION_HEADER_HEIGHT: CGFloat = 50

struct CategoryDataSourse{
    let imageName: String
    let title: String
    
    static func dataSourse() -> [CategoryDataSourse] {
        let dataSourse = [
            CategoryDataSourse.init(imageName: "Kids", title: "Дети"),
            CategoryDataSourse.init(imageName: "Adults", title: "Взрослые"),
            CategoryDataSourse.init(imageName: "Elderly", title: "Пожилые"),
            CategoryDataSourse.init(imageName: "Animals", title: "Животные"),
            CategoryDataSourse.init(imageName: "Events", title: "Мероприятия")
        ]
        return dataSourse
    }
}

class HelpViewController: UIViewController {
  
  fileprivate var categories: Categories
  fileprivate var events: Events
    
    @IBOutlet weak var helpCenterCollectionView: UICollectionView!
    
    private let titleCellIdentifier: String = "CategoryCollectionHeaderCell"
    private let cellIdentifier: String = "HelpCenterCollectionCell"
    private let dataSourse: [CategoryDataSourse] = CategoryDataSourse.dataSourse()
    
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
    }
    
    @objc func exitApp() {
        UIControl().sendAction(#selector((NSXPCConnection.suspend)), to: UIApplication.shared, for: nil)
    }
  
  @objc fileprivate func openDetailsEvent(event: Events?) {
      guard let eventDetails = event else { return }
      
      let detailsTaskVC = AGLDetailsTaskViewController()
      detailsTaskVC.task = taskDetails
      self.navigationController?.pushViewController(detailsTaskVC, animated: true)
  }
}

extension HelpViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CategoryCollectionCell {
            let data = self.dataSourse[indexPath.row]
            cell.titleImageView.image = UIImage(named: data.imageName)
            cell.titleTextLabel.text = data.title
            return cell
        }
        return UICollectionViewCell()
    }
    
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
        return CGSize(width: self.view.bounds.width, height: COLLECTION_HEADER_HEIGHT)
    }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let section = self.dataSourse[indexPath.section]
    let cellType = section.self
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CategoryCollectionCell {
      
      
    }
    
    collectionView.deselectItem(at: indexPath, animated: true)
  }
}
