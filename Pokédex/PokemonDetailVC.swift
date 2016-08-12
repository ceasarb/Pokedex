//
//  PokemonDetailVC.swift
//  Pokédex
//
//  Created by Ceasar Barbosa on 8/11/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nameLabel.text = pokemon.name.capitalized
    
    }


}
