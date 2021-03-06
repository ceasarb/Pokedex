//
//  Pokemon.swift
//  Pokédex
//
//  Created by Ceasar Barbosa on 8/8/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            
            _nextEvolutionId = ""
        }
        
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            
            _nextEvolutionLevel = ""
        }
        
        return _nextEvolutionLevel
    }
    
    var nextEvolutionText: String {
        
        if _nextEvolutionText == nil {
            
            _nextEvolutionText = ""
        }
        
        return _nextEvolutionText
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = ""
        }
        
        return _attack
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = "NIL"
        }
        
        return _weight
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = "NIL"
        }
        
        return _height
        
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
        }
        
        return _defense
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        
        return _type
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        
        return _description
    }
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self.pokedexId)/"
    }
    
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        Alamofire.request(_pokemonURL, withMethod: .get).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String,AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for obj in 1..<types.count {
                            
                            if let name = types[obj]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        let descURL = "\(BASE_URL)\(url)"
                        
                        Alamofire.request(descURL, withMethod: .get).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let pokeDescription = descDict["description"] as? String {
                                    
                                    let newDesc = pokeDescription.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDesc
                            
                                }
                            }
                            completed()

                        })

                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvolution = evolutions[0]["to"] as? String {
                        
                        if nextEvolution.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvolution
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                
                                let nextEvolutionId = newString.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvolutionId
                                
                                if let levelExist = evolutions[0]["level"] {
                                    
                                    if let level = levelExist as? Int {
                                        
                                        self._nextEvolutionLevel = "\(level)"
                                    }
                                    
                                } else {
                                    
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                    print(self.nextEvolutionLevel)
                }
            }
            
            completed()
        }
    }
}

