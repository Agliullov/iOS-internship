//
//  AlamofireNetworkRequest.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 10.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkService {
    
    var networkData: NetworkDataFetcher!
    
    init(networkData: NetworkDataFetcher = NetworkDataFetcher()) {
        self.networkData = networkData
    }
    
    func getAlamofireCategories(completion: @escaping ([CategoriesEntity]?, Error?) -> Void) {
        let url = "https://firebasestorage.googleapis.com/v0/b/testworkagliullov.appspot.com/o/categories.json?alt=media&token=5cd08637-e3e4-4260-b231-9335e647ddd8"
        getAlamofireJSONData(url: url, completion: completion)
    }
    
    func getAlamofireEvents(completion: @escaping ([EventsEntity]?, Error?) -> Void) {
        let url = "https://firebasestorage.googleapis.com/v0/b/testworkagliullov.appspot.com/o/kids_events.json?alt=media&token=ff2905d9-6296-424a-9ad1-57f094757f23"
        getAlamofireJSONData(url: url, completion: completion)
    }
    
    func getAlamofireFilters(completion: @escaping ([FiltersEntity]?, Error?) -> Void) {
        let url = "https://firebasestorage.googleapis.com/v0/b/testworkagliullov.appspot.com/o/filters.json?alt=media&token=4c9731c8-1ab0-4b58-8173-10806c0678ce"
        getAlamofireJSONData(url: url, completion: completion)
    }
    
    private func getAlamofireJSONData<T: Codable>(url: String, completion: @escaping (([T]?, Error?) -> Void)) {
        DispatchQueue.main.async {
            guard let url = URL(string: url) else { return }
            AF.request(url, method: .get).responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    let objects = self.networkData.decodeJSONData(type: [T].self, from: data)
                    completion(objects, nil)
                case .failure(let error):
                    completion([], error)
                }
            })
        }
    }
}
