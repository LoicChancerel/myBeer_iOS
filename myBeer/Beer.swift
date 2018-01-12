//
//  Beer.swift
//  myBeer
//
//  Created by CHANCEREL Loic on 12/01/2018.
//  Copyright © 2018 CHANCEREL Loic. All rights reserved.
//

import Foundation

class Beer {
    
    var id: Int
    var name: String
    var strength: Double
    var note: Double
    
    init(id: Int, name: String, strength: Double, note: Double) {
        self.id = id
        self.name = name
        self.strength = strength
        self.note = note
    }
    
    init(name: String, strength: Double, note: Double) {
        self.id = 0
        self.name = name
        self.strength = strength
        self.note = note
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getStrength() -> Double {
        return self.strength
    }
    
    func getNote() -> Double {
        return self.note
    }
    
    func setId(id: Int) {
        self.id = id
    }
}
