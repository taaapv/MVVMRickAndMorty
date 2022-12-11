//
//  HeroListViewModel.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 11.12.2022.
//

import Foundation

protocol HeroListViewModelProtocol: AnyObject {
    var heroList: [Hero] { get }
    
    func fetchHeroList(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    
    func cellViewModel(at indexPath: IndexPath) -> HeroViewModelProtocol
    func detailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol
}

class HeroListViewModel: HeroListViewModelProtocol {
    var heroList: [Hero] = []
    
    func fetchHeroList(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [unowned self] heroes in
            self.heroList = heroes
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        heroList.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HeroViewModelProtocol {
        let hero = heroList[indexPath.row]
        return HeroViewModel(hero: hero)
    }
    
    func detailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol {
        let hero = heroList[indexPath.row]
        return DetailViewModel(hero: hero)
    }
}
