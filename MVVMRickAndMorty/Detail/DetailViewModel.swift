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
    var isFavorite: Bool { get }
    var viewModelDidChange: ((DetailViewModelProtocol) -> Void)? { get set }
    
    init(hero: Hero)
    
    func favoriteButtonPressed()
    func buttonPressed()
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
    
    var isFavorite: Bool {
        get {
            DataManager.shared.getStatus(id: hero.id)
        } set {
            DataManager.shared.setStatus(id: hero.id, status: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((DetailViewModelProtocol) -> Void)?
    
    private let hero: Hero
    
    required init(hero: Hero) {
        self.hero = hero
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }
    
    func buttonPressed() {
        isFavorite.toggle()
    }
}
