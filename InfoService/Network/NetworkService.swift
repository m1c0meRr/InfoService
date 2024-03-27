//
//  NetworkService.swift
//  InfoService
//
//  Created by Sergey Savinkov on 27.03.2024.
//

import UIKit

protocol NetworkProtocol {
    func getData(completion: @escaping (Model) -> (Void))
}

final class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func getData(completion: @escaping (Model) -> Void) {
        
        let apiURL = API.api
       
        guard let url = URL(string: apiURL) else { fatalError() }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, responce, error) in
            guard let data = data else { return }
            do {
                let currentModel = try JSONDecoder().decode(Model.self, from: data)
                completion(currentModel)
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    public func requestImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        task.resume()
    }
}
