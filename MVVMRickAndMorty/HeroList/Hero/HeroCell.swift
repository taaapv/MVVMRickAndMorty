//
//  HeroCell.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 09.12.2022.
//

import UIKit

class HeroCell: UITableViewCell {
    var viewModel: HeroViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.name
            
            guard let imageData = viewModel.imageData else { return }
            content.image = UIImage(data: imageData)
            
            contentConfiguration = content
        }
    }
}
