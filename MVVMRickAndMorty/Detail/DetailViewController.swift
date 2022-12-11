//
//  DetailViewController.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 09.12.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var button: UIButton!
    
    var viewModel: DetailViewModelProtocol! {
        didSet {
            viewModel.viewModelDidChange = { [unowned self] viewModel in
                self.setColorForFavoriteButton(viewModel.isFavorite)
                self.setTitleForButton(viewModel.isFavorite)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        button.layer.cornerRadius = 20
        setupUI()
    }

    @IBAction func toggleButton(_ sender: UIButton) {
        viewModel.favoriteButtonPressed()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        viewModel.buttonPressed()
    }
    
    private func setupUI() {
        setColorForFavoriteButton(viewModel.isFavorite)
        setTitleForButton(viewModel.isFavorite)
        
        nameLabel.text = viewModel.name
        infoLabel.text = viewModel.info
        guard let imageData = viewModel.image else { return }
        heroImage.image = UIImage(data: imageData)
    }
    
    private func setColorForFavoriteButton(_ status: Bool) {
        favoriteButton.tintColor = status ? .red : .gray
    }
    
    private func setTitleForButton(_ status: Bool) {
        button.titleLabel?.text = status ? "В избранном" : "Добавить в избранное"
    }
}
