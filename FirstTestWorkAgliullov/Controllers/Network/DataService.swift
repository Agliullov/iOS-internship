//
//  DataService.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 04.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

class DataService {
    
    var networkData: NetworkDataFetcher!
    
    init(networkData: NetworkDataFetcher = NetworkDataFetcher()) {
        self.networkData = networkData
    }
    
    func getCategories(completion: @escaping ([CategoriesEntity]?) -> Void) {
        let fileName = "categories"
        networkData.getDataSourceFromJSON(fileName: fileName, response: completion)
    }
    
    func getEventKids(completion: @escaping ([EventsEntity]?) -> Void) {
        let fileName = "kids_events"
        networkData.getDataSourceFromJSON(fileName: fileName, response: completion)
    }
    
    func getEventFilters(completion: @escaping ([FiltersEntity]?) -> Void) {
        let fileName = "filters"
        networkData.getDataSourceFromJSON(fileName: fileName, response: completion)
    }
}
