//
//  HelpViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

struct CategoryDataSourse{
    let imageName: String
    let title: String
    
    static func dataSourse() -> [CategoryDataSourse] {
        let dataSourse = [
            CategoryDataSourse.init(imageName: "Young", title: "Дети"),
            CategoryDataSourse.init(imageName: "Normal", title: "Взрослые"),
            CategoryDataSourse.init(imageName: "OldMen", title: "Пожилые"),
            CategoryDataSourse.init(imageName: "Animals", title: "Животные"),
            CategoryDataSourse.init(imageName: "Event", title: "Мероприятия")
        ]
        return dataSourse
    }
}

class HelpViewController: UIViewController {
    
    @IBOutlet weak var helpCenterCollectionView: UICollectionView!
    
    private let cellIdentifier: String = "HelpCenterCollectionCell"
    private let dataSourse: [CategoryDataSourse] = CategoryDataSourse.dataSourse()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Помочь"
        self.view.backgroundColor = UIColor.white
        
        let textColorAttribute = [NSAttributedString.Key.font: UIFont(name: "Palatino-Bold", size: 21)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textColorAttribute
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "rectangle"), style: .done, target: nil, action: nil), animated: true)
        
        self.helpCenterCollectionView.delegate = self
        self.helpCenterCollectionView.dataSource = self
        
        self.helpCenterCollectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
        // let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: self.view.frame.width / 2 - 15, height: self.view.frame.height / 5)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.view.frame.width / 2 - 15, height: self.view.frame.height / 5)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return inset
    }
    
}
