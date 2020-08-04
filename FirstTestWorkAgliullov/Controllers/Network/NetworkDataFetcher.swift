//
//  NetworkDataFetcher.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 29.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
  
  static let shared: NetworkDataFetcher = {
    return NetworkDataFetcher()
  }()
  
//  func getDataSourceFromJSON<T: Codable>(fileName: String) -> [T]? {
//    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//      do {
//        let data = try Data(contentsOf: url)
//        let objects = self.decodeJSONData(type: [T].self, from: data)
//        return objects
//      } catch {
//        print("Error! Unable to parse \(fileName).json")
//      }
//    }
//    return nil
//  }
  
  func decodeJSONData<T: Codable>(type: T.Type, from: Data?) -> T? {
    let decoder = JSONDecoder()
    guard let data = from else { return nil }
    do {
      let objects = try decoder.decode(type.self, from: data)
      return objects
    } catch let jsonError {
      print("Failed to decode JSON", jsonError)
      return nil
    }
  }
}
