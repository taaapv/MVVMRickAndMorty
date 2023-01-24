//
//  HeroListViewModel.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 11.12.2022.
//

import Foundation

protocol HeroListViewModelProtocol: AnyObject {
    var rickAndMorty: RickAndMorty { get }
    var filteredHeros: [Hero] { get }
    var isFiltering: Bool { get }
    
    func searchUpdate(text: String?, isActive: Bool)
    func filterContentForSearchText(_ searchText: String)
    
    func updateData(barButtonTag: Int, completion: @escaping(String?) -> Void)
    
    func fetchHeroList(with link: String, completion: @escaping() -> Void)
    func numberOfRows() -> Int
    
    func cellViewModel(at indexPath: IndexPath) -> HeroViewModelProtocol
    func detailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol
}

class HeroListViewModel: HeroListViewModelProtocol {
    var rickAndMorty: RickAndMorty  = RickAndMorty(info: Info(pages: 0, next: "", prev: ""), results: [])
    var heroList: [Hero] = []
    var filteredHeros: [Hero] = []
    var isFiltering: Bool = false
    var searchText: String = ""
    
    func fetchHeroList(with link: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(dataType: RickAndMorty.self, with: link) { [unowned self] result in
            switch result {
            case .success(let rickAndMorty):
                self.rickAndMorty = rickAndMorty
                heroList = rickAndMorty.results
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateData(barButtonTag: Int, completion: @escaping(String?) -> Void) {
        barButtonTag == 1
        ? completion(rickAndMorty.info.next)
        : completion(rickAndMorty.info.prev)
    }
    
    func searchUpdate(text: String?, isActive: Bool) {
        guard let text = text, !text.isEmpty, isActive == true else { return }
        isFiltering = true
        searchText = text
        filterContentForSearchText(searchText)
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredHeros = heroList.filter { hero in
            hero.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func numberOfRows() -> Int {
        isFiltering ? filteredHeros.count : heroList.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HeroViewModelProtocol {
        let hero = isFiltering ? filteredHeros[indexPath.row] : heroList[indexPath.row]
        return HeroViewModel(hero: hero)
    }
    
    func detailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol {
        let hero = heroList[indexPath.row]
        return DetailViewModel(hero: hero)
    }
}
