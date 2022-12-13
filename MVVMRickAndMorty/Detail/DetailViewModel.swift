//
//  DetailViewModel.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 11.12.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    var name: String { get }
    var info: String { get }
    var image: Data? { get }
    var isFavorite: Box<Bool> { get }
    
    init(hero: Hero)
    
    func favoriteButtonPressed()
}

class DetailViewModel: DetailViewModelProtocol {
    var name: String {
        hero.name
    }
    
    var info: String {
        "Species: \(hero.species.rawValue), gender: \(hero.gender.rawValue), origin: \(hero.origin.name)"
    }
    
    var image: Data? {
        ImageManager.shared.fetchImage(hero.image)
    }
    
    var isFavorite: Box<Bool>
    
    private let hero: Hero
    
    required init(hero: Hero) {
        self.hero = hero
        isFavorite = Box(DataManager.shared.getStatus(id: hero.id))
    }
    
    func favoriteButtonPressed() {
        isFavorite.value.toggle()
        DataManager.shared.setStatus(id: hero.id, status: isFavorite.value)
    }
}
