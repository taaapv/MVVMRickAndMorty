//
//  ImageManager.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 09.12.2022.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    private init() {}
    
    func fetchImage(_ stringUrl: String) -> Data? {
        guard let url = URL(string: stringUrl) else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
}
