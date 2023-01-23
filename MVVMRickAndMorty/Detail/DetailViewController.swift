//
//  DetailViewController.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 09.12.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var viewModel: DetailViewModelProtocol! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        setupUI()
    }

    @IBAction func toggleButton(_ sender: UIButton) {
        viewModel.favoriteButtonPressed()
    }
    
    private func setupUI() {
        setColorForFavoriteButton(viewModel.isFavorite.value)
        
        viewModel.isFavorite.bind { [unowned self] value in
            setColorForFavoriteButton(value)
        }
        title = viewModel.name
        infoLabel.text = viewModel.info
        guard let imageData = viewModel.image else { return }
        heroImage.image = UIImage(data: imageData)
    }
    
    private func setColorForFavoriteButton(_ status: Bool) {
        favoriteButton.tintColor = status ? .red : .gray
    }
}
