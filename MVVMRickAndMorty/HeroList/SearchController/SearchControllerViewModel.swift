//
//  SearchControllerViewModel.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 20.01.2023.
//

import Foundation

protocol SearchControllerViewModelProtocol {
    var searchBarIsEmpty: Bool { get }
    var isFiltering: Bool { get }
}

class SearchControllerViewModel: SearchControllerViewModelProtocol {
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
}
