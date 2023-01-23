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
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private let hero: Hero
    
    required init(hero: Hero) {
        self.hero = hero
    }
    
    
}
