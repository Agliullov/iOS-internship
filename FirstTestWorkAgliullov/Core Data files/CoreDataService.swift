//
//  CoreDataService.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 06.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit
import CoreData

class CoreDataService {
    
    //MARK: - Категории
    func saveCategoryDataInCoreData(_ categoriesEntity: [CategoriesEntity]?, completion: @escaping ([Categories]?) -> Void) {
        DispatchQueue.main.async {
            guard let categories = categoriesEntity, let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext// Main thread
            guard let entity = NSEntityDescription.entity(forEntityName: "Categories", in: context) else { return }
            var taskObjects: [Categories] = []
            for category in categories {
                let task = NSManagedObject(entity: entity, insertInto: context) as! Categories
                task.id = category.id
                task.imageName = category.imageName
                task.primaryKey = category.primaryKey
                task.title = category.title
                taskObjects.append(task)
            }
            do {
                try context.save()
                completion(taskObjects)
                print("Categories data saved in Core Data")
            } catch {
                print("Error save data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCategoryDataFromCoreData() -> [CategoriesEntity]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext// Main thread
        var objectsCategoryEntity: [CategoriesEntity] = []
        do {
            let fetchRequest : NSFetchRequest<Categories> = Categories.fetchRequest()
            let fetchedResults = try context.fetch(fetchRequest)
            for category in fetchedResults {
                let object = CategoriesEntity(id: category.id,
                                              primaryKey: category.primaryKey ?? "",
                                              title: category.title ?? "",
                                              imageName: category.imageName ?? "")
                objectsCategoryEntity.append(object)
            }
            return objectsCategoryEntity
        }
        catch {
            print ("Fetch task failed: \(error.localizedDescription)")
        }
        return objectsCategoryEntity
    }
    
    //MARK: - События
    func saveEventDataInCoreData(_ eventEntity: [EventsEntity]?, completion: @escaping ([Events]?) -> Void) {
        DispatchQueue.main.async {
            guard let events = eventEntity, let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext// Main thread
            guard let entity = NSEntityDescription.entity(forEntityName: "Events", in: context) else { return }
            var taskObjects: [Events] = []
            for event in events {
                let task = NSManagedObject(entity: entity, insertInto: context) as! Events
                task.id = event.id
                task.eventTitle = event.eventTitle
                task.eventImageView = event.eventImageView
                task.topDescriptionLabel = event.topDescriptionLabel
                task.timeLabel = event.timeLabel
                if let detailsInfo = event.detailsInfo {
                    do {
                        let jsonData = try JSONEncoder().encode(detailsInfo)
                        task.detailsInfo = jsonData
                    } catch { print(error) }
                }
                taskObjects.append(task)
            }
            do {
                try context.save()
                completion(taskObjects)
                print("Events data saved in Core Data")
            } catch {
                print("Error save data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchEventDataFromCoreData() -> [EventsEntity]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext// Main thread
        var objectsEventsEntity: [EventsEntity] = []
        do {
            let fetchRequest: NSFetchRequest<Events> = Events.fetchRequest()
            let fetchedResults = try context.fetch(fetchRequest)
            for event in fetchedResults {
                var detailsInfo: DetailsInfo?
                if let _ = event.detailsInfo {
                    let decoder = JSONDecoder()
                    guard let data = event.detailsInfo else { return nil }
                    do {
                        detailsInfo = try decoder.decode(DetailsInfo.self, from: data)
                    } catch let jsonError {
                        print("Failed to decode JSON", jsonError)
                    }
                }
                let object = EventsEntity(id: event.id,
                                          eventTitle: event.eventTitle ?? "",
                                          eventImageView: event.eventImageView ?? "",
                                          topDescriptionLabel: event.topDescriptionLabel ?? "",
                                          timeLabel: event.timeLabel ?? "",
                                          detailsInfo: detailsInfo)
                objectsEventsEntity.append(object)
            }
            return objectsEventsEntity
        }
        catch {
            print ("Fetch task failed: \(error.localizedDescription)")
        }
        return objectsEventsEntity
    }
}
