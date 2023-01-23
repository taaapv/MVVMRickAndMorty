//
//  HeroListViewModel.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 11.12.2022.
//

import Foundation

protocol HeroListViewModelProtocol: AnyObject {
    var heroList: [Hero] { get }
    var filteredHeros: [Hero] { get }
    
    func searchUpdate(text: String?, completion: @escaping () -> Void)
    func filterContentForSearchText(_ searchText: String)
    
    func fetchHeroList(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    
    func cellViewModel(at indexPath: IndexPath) -> HeroViewModelProtocol
    func detailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol
}

class HeroListViewModel: HeroListViewModelProtocol {
    var heroList: [Hero] = []
    var filteredHeros: [Hero] = []
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    func searchUpdate(text: String?, completion: @escaping () -> Void) {
        guard let text = text else {
            return
        }
        
    }
    
    
    
    func fetchHeroList(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(dataType: RickAndMorty.self, with: Link.rickAndMorty.rawValue) { [unowned self] result in
            switch result {
            case .success(let rickAndMorty):
                self.heroList = rickAndMorty.results
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredHeros = heroList.filter { hero in
            hero.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func numberOfRows() -> Int {
        isFiltering ? filteredHeroes.count : heroList.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HeroViewModelProtocol {
        let hero = isFiltering ? filteredHeroes[indexPath.row] : heroList[indexPath.row]
        return HeroViewModel(hero: hero)
    }
    
    func detailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol {
        let hero = heroList[indexPath.row]
        return DetailViewModel(hero: hero)
    }
}
