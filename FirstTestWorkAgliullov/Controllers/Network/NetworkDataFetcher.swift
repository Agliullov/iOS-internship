//
//  NetworkDataFetcher.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 29.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService: NetworkService!
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func getDataURlFromJSON<T: Codable>(urlString: String, response: @escaping ([T]?) -> Void) {
        networkService.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSONData(type: [T].self, from: data)
            response(decoded)
        }
    }
    
    func getDataSourceFromJSON<T: Codable>(fileName: String, response: @escaping ([T]?) -> Void) {
        DispatchQueue.main.async {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let objects = self.decodeJSONData(type: [T].self, from: data)
                    response(objects)
                } catch {
                    print("Failed to parse \(fileName).json")
                }
            }
        }
    }
    
    func decodeJSONData<T: Codable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON: \(jsonError.localizedDescription)")
            return nil
        }
    }
}
