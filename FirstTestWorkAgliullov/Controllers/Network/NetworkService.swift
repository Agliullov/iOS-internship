//
//  NetworkService.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 04.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

class NetworkService {
    
    //Построение запроса по URL
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        DispatchQueue.global(qos: .background).sync {
            return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, error)
            })
        }
    }
}
