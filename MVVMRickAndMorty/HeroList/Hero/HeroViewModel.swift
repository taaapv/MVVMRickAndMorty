//
//  HeroViewModel.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 11.12.2022.
//

import Foundation

protocol HeroViewModelProtocol {
    var name: String { get }
    var imageData: Data? { get }
    
    init(hero: Hero)
}

class HeroViewModel: HeroViewModelProtocol {
    var name: String {
        hero.name
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImage(hero.image)
    }
    
    private let hero: Hero
    
    required init(hero: Hero) {
        self.hero = hero
    }
    
    
}
