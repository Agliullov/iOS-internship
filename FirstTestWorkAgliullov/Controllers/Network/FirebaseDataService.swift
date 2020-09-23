//
//  FirebaseDataService.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 08.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseDataService {
    
    var networkData: NetworkDataFetcher = NetworkDataFetcher()
    
    func getUsersFirebaseData(completion: @escaping ([UsersEntity]?) -> Void) {
        let storeRef = Storage.storage().reference().child("/authorizationJson.json")
        storeRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            let objects = self.networkData.decodeJSONData(type: [UsersEntity].self, from: data)
            completion(objects)
        }
    }
    
    func getCategoriesFirebaseData(completion: @escaping ([CategoriesEntity]?) -> Void) {
        let storeRef = Storage.storage().reference().child("/categories.json")
        storeRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            let objects = self.networkData.decodeJSONData(type: [CategoriesEntity].self, from: data)
            completion(objects)
        }
    }
    
    func getEventsFirebaseData(completion: @escaping ([EventsEntity]?) -> Void) {
        let storeRef = Storage.storage().reference().child("/kids_events.json")
        storeRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            let objects = self.networkData.decodeJSONData(type: [EventsEntity].self, from: data)
            completion(objects)
        }
    }
    
    func getFiltersFirebaseData(completion: @escaping ([FiltersEntity]?) -> Void) {
        let storeRef = Storage.storage().reference().child("/filters.json")
        storeRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            let objects = self.networkData.decodeJSONData(type: [FiltersEntity].self, from: data)
            completion(objects)
        }
    }
}
