//
//  PokeCell.swift
//  Pokédex
//
//  Created by Ceasar Barbosa on 8/10/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
    }
    
    
    func configureCell(_ pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
    }
    
}
