//
//  NetworkManager.swift
//  Geographic atlas
//
//  Created by Arman on 25.11.2023.
//

import Foundation
import Alamofire

class NetworkManager{
    
    static let shared = NetworkManager()
    
    let url = "https://restcountries.com/v3.1/all"
    
    
    private init() {}
    
    func fetchRequest(_ url: String, completion: @escaping (Result<[CountryModel], Error> ) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: [CountryModel].self) { response in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func imageFetchRequest(_ url: String, completion: @escaping (Result<Data, Error> ) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(_):
                    guard let imageData = dataResponse.data else { return }
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
