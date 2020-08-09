//
//  HelpViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import CoreData
import UIKit
import Alamofire

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
    
    private let dataService = DataService()
    private let firebaseDataService = FirebaseDataService()
    
    private var mode: ControllerMode = .viewing
    
    private var sections: [CategoriesEntity] = []
    
    var firebaseDataCategories: [CategoriesEntity] = []
    
    private var coreDataSection: [Categories] = []
    
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
        
        
        self.setMode(mode: .updating)
        if let coreData = self.fetchDataFromCoreData() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.sections = coreData
                self.setMode(mode: .viewing)
                self.helpCenterCollectionView.reloadData()
            }
            
        } else {
            let _ = dataService.getCategories { categories in
                self.saveCoreData(categories) { (category) in
                    guard let category = category else { return }
                    var objects: [CategoriesEntity] = []
                    
                    for categor in category {
                        let object = CategoriesEntity(id: categor.id, primaryKey: categor.primaryKey ?? "", title: categor.title ?? "", imageName: categor.imageName ?? "")
                        objects.append(object)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.sections = objects
                        self.setMode(mode: .viewing)
                        self.helpCenterCollectionView.reloadData()
                    }
                    
                }
            }
        }
        
        //        AF.request("https://httpbin.org/get").response { response in
        //            print(response)
        //        }
        
        //        dataService.getCategories { (categories) in
        //            self.sections = categories!
        //        }
        
        //        firebaseDataService.getCategoriesFirebaseData { (categories) in
        //            self.firebaseDataCategories = categories!
        //
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //                self.sections = categories!
        //                self.helpCenterCollectionView.reloadData()
        //                self.setMode(mode: .viewing)
        //            }
        //        }
        
        //        firebaseDataService.getEventsFirebaseData { (events) in
        //            print(events)
        //        }
        
        //        firebaseDataService.getFiltersFirebaseData { (filters) in
        //            print(filters)
        //        }
        
    }
    
    func saveCoreData(_ categories: [CategoriesEntity]?, completion: @escaping ([Categories]?) -> Void) {
        guard let categories = categories, let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Categories", in: context) else { return }
        
        var taskObjects: [Categories] = []
        for category in categories {
            let taskObject = NSManagedObject(entity: entity, insertInto: context) as! Categories
            taskObject.id = category.id
            taskObject.imageName = category.imageName
            taskObject.primaryKey = category.primaryKey
            taskObject.title = category.title
            taskObjects.append(taskObject)
        }
        
        do {
            try context.save()
            completion(taskObjects)
            print("saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchDataFromCoreData() -> [CategoriesEntity]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        var objects: [CategoriesEntity] = []
        
        do {
            let fetchRequest : NSFetchRequest<Categories> = Categories.fetchRequest()
            let fetchedResults = try context.fetch(fetchRequest)
            
            
            for categor in fetchedResults {
                let object = CategoriesEntity(id: categor.id, primaryKey: categor.primaryKey ?? "", title: categor.title ?? "", imageName: categor.imageName ?? "")
                objects.append(object)
            }
            return objects
        }
        catch {
            print ("fetch task failed", error)
        }
        return objects
    }
    
    @objc func exitApp() {
        UIControl().sendAction(#selector((NSXPCConnection.suspend)), to: UIApplication.shared, for: nil)
    }
    
    private func openEventsVC(section: CategoriesEntity) {
        let eventVC = EventViewController()
        let selectedEvent = CategoryEnum(name: section.primaryKey)
        eventVC.categoryEnum = selectedEvent
        eventVC.navigationTitle = title
        navigationController?.pushViewController(eventVC, animated: true)
    }
    
    
    //MARK: - Activity Indicator
    private func updateNavigationItems(animated: Bool) {
        switch self.mode {
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
    
    private func setMode(mode: ControllerMode) {
        self.mode = mode
        self.updateNavigationItems(animated: true)
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
