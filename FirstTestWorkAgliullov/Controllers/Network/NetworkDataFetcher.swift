//
//  NetworkDataFetcher.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 29.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
  
  var networkService = NetworkService()
  
  init(networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
  func dataFetcher(urlString: String){
    networkService.request(urlString: urlString) { (data, error) in
      let decoder = JSONDecoder()
      guard let data = data else { return }
      let response = try? decoder.decode([Events].self, from: data)
      print(response)
    }
  }
  
}
