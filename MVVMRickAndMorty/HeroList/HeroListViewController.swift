//
//  HeroListViewController.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 09.12.2022.
//

import UIKit

class HeroListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: HeroListViewModelProtocol! {
        didSet {
            viewModel.fetchHeroList(with: Link.rickAndMorty.rawValue) { [unowned self] in
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        setupNavigationBar()
        setupSearchController()
        
        activityIndicator = showActivityIndicator(in: view)
        viewModel = HeroListViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        detailVC.viewModel = sender as? DetailViewModelProtocol
    }
    
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        viewModel.updateData(barButtonTag: sender.tag) { [unowned self] link in
            self.viewModel.fetchHeroList(with: link ?? "") { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        return activityIndicator
    }
    
    private func setupNavigationBar() {
        title = "Rick & Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navigBarAppearance = UINavigationBarAppearance()
        navigBarAppearance.configureWithOpaqueBackground()
        navigBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigBarAppearance.backgroundColor = .systemTeal
        
        navigationController?.navigationBar.standardAppearance = navigBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigBarAppearance
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .darkGray
        }
    }
}

extension HeroListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as? HeroCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
}

extension HeroListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = viewModel.detailViewModel(at: indexPath)
        performSegue(withIdentifier: "showDetail", sender: viewModel)
    }
}

extension HeroListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchUpdate(text: searchController.searchBar.text, isActive: searchController.isActive)
        tableView.reloadData()
    }
}
