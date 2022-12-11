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

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData(completion: @escaping(_ heroes: [Hero]) -> Void) {
        guard let ulr = URL(string: Link.rickAndMorty.rawValue) else { return }
        
        URLSession.shared.dataTask(with: ulr) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }

            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                let heroList = rickAndMorty.results
                DispatchQueue.main.async {
                    completion(heroList)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
