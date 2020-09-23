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
    
    private let localDataService = LocalDataService()
    private let firebaseDataService = FirebaseDataService()
    private let coreDataService = CoreDataService()
    private let alamofireDataService = AlamofireNetworkService()
    
    private var controllerMode: ControllerMode = .viewing
    
    private var sections: [CategoriesEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Помочь"
        view.backgroundColor = UIColor.white
        
        let textColorAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21.0), NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textColorAttribute
        
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "rectangle"), style: .done, target: self, action: #selector(exitApp)), animated: true)
        
        helpCenterCollectionView.delegate = self
        helpCenterCollectionView.dataSource = self
        
        helpCenterCollectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        helpCenterCollectionView.register(CategoryCollectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: titleCellIdentifier)
        
        checkDataWithAlamofire()
    }
    
    private func checkDataWithAlamofire() {
        self.setMode(mode: .updating)
        alamofireDataService.getAlamofireCategories { (data, error) in
            if let data = data, data.count != 0 {
                DispatchQueue.main.async {
                    self.sections = data
                    self.helpCenterCollectionView.reloadData()
                    self.setMode(mode: .viewing)
                }
            } else {
                self.firebaseFetchService()// Check data from Firebase.getData
            }
        }
    }
    
    private func firebaseFetchService() {
        self.setMode(mode: .updating)
        firebaseDataService.getCategoriesFirebaseData { (categories) in
            if let categoryInFB = categories, categoryInFB.count != 0 {
                DispatchQueue.main.async() {
                    self.sections = categoryInFB
                    self.helpCenterCollectionView.reloadData()
                    self.setMode(mode: .viewing)
                }
            } else {
                let alertController = UIAlertController(title: "Произошла ошибка подключения", message: "Не удалось подключиться к серверу. Данные могут быть устаревшими.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                self.coreDataFetchService()// Check data from CoreData
                self.setMode(mode: .viewing)
            }
        }
    }
    
    private func coreDataFetchService() {
        self.setMode(mode: .updating) 
        if let coreDataFetch = coreDataService.fetchCategoryDataFromCoreData(), coreDataFetch.count != 0 {
            DispatchQueue.main.async() {
                self.sections = coreDataFetch
                self.helpCenterCollectionView.reloadData()
                self.setMode(mode: .viewing)
            }
        } else {
            let _ = localDataService.getLocalCategories { categoriesFromJSON in // Get local data and save in CoreData
                self.coreDataService.saveCategoryDataInCoreData(categoriesFromJSON) { categoriesSaveInCoreData in
                    guard let localCategories = categoriesSaveInCoreData else { return }
                    var objectsCategoryEntity: [CategoriesEntity] = []
                    
                    for category in localCategories {
                        let object = CategoriesEntity(id: category.id,
                                                      primaryKey: category.primaryKey ?? "",
                                                      title: category.title ?? "",
                                                      imageName: category.imageName ?? "")
                        objectsCategoryEntity.append(object)
                    }
                    DispatchQueue.main.async() {
                        self.sections = objectsCategoryEntity
                        self.helpCenterCollectionView.reloadData()
                    }
                }
                self.setMode(mode: .viewing)
            }
        }
    }
    
    private func openEventsVC(section: CategoriesEntity) {
        let eventVC = EventViewController()
        let selectedEvent = CategoryEnum(name: section.primaryKey)
        eventVC.categoryEnum = selectedEvent
        eventVC.navigationTitle = title
        navigationController?.pushViewController(eventVC, animated: true)
    }
    
    @objc func exitApp() {
        UIControl().sendAction(#selector((NSXPCConnection.suspend)), to: UIApplication.shared, for: nil)
    }
    
    //MARK: - Activity Indicator
    private func setMode(mode: ControllerMode) {
        self.controllerMode = mode
        self.updateNavigationItems(animated: true)
    }
    
    private func updateNavigationItems(animated: Bool) {
        switch self.controllerMode {
        case .viewing:
            self.navigationItem.setHidesBackButton(false, animated: animated)
            self.navigationItem.setRightBarButton(nil, animated: animated)
        case .editing:()
        case .updating:
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.color = UIColor.white
            activityIndicator.startAnimating()
            
            let rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
            self.navigationItem.setRightBarButton(rightBarButtonItem, animated: animated)
            self.navigationItem.setHidesBackButton(true, animated: animated)
        }
    }
}

extension HelpViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CategoryCollectionCell {
            let data = sections[indexPath.row]
            cell.setup(titleImageName: data.imageName, titleText: data.title)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HelpViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = sections[indexPath.row]
        openEventsVC(section: section)
    }
}

extension HelpViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: titleCellIdentifier, for: indexPath) as! CategoryCollectionHeaderCell
            reusableCell.setup(headerText: "Выберите категорию помощи")
            return reusableCell
        default:
            fatalError("Not implemented")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 50.0)
    }
}
