//
//  NetworkManager.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 09.12.2022.
//

import Foundation

enum Link: String {
    case rickAndMorty = "https://rickandmortyapi.com/api/character"
}

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData<T: Codable>(dataType: T.Type, with urlString: String?, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let ulr = URL(string: urlString ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: ulr) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
