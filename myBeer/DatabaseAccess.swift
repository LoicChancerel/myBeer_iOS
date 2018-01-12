
//
//  DatabaseAccess.swift
//  myBeer
//
//  Created by CHANCEREL Loic on 20/12/2017.
//  Copyright © 2017 CHANCEREL Loic. All rights reserved.
//

import UIKit
import SQLite

class DatabaseAccess {
    
    var db: Connection!
    
    let beersTable = Table("beers")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let strength = Expression<Double>("strength")
    let note = Expression<Double>("note")
    
    init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("beers").appendingPathExtension("slite3")
            let db = try Connection(fileUrl.path)
            self.db = db
            try self.createTable()
        } catch {
            print(error)
        }
    }
    
    func createTable() throws {
        let createTable = self.beersTable.create { (t) in
            t.column(self.id, primaryKey: true)
            t.column(self.name)
            t.column(self.strength)
            t.column(self.note)
        }
        
        do {
            try self.db.run(createTable)
            print("Created table Beer")
        } catch {
            print(error)
            throw error
        }
    }
    
    func insertBeer(beer: Beer) throws -> Beer {
        let insertBeerQuery = self.beersTable.insert(self.name <- beer.getName(), self.strength <- beer.getStrength(), self.note <- beer.getNote())
        
        do {
            let beerId = try self.db.run(insertBeerQuery)
            beer.setId(id: Int(beerId))
            return beer
        } catch {
            print(error)
            throw error
        }
    }
    
    func getAllBeers() throws -> Array<Beer> {
        var arrayBeers = Array<Beer>()
        do {
            let beers = try self.db.prepare(self.beersTable)
            for beerRow in beers {
                arrayBeers.append(rowToBeer(row: beerRow))
            }
        } catch {
            print(error)
            throw error
        }
        return arrayBeers
    }
    
    func getBeerById(id: Int) throws -> Beer {
        do {
            let beer = beersTable.filter(self.id == id)
            return rowToBeer(row: try self.db.pluck(beer))
        }
    }
    
    func deleteBeer(beer: Beer) throws {
        do {
            let beer = beersTable.filter(self.id == beer.getId())
            try db.run(beer.delete())
        }
    }
    
    func updateBeer(beer: Beer) {
        let beerQuery = self.beersTable.filter(self.id == beer.getId())
        let updateBeer = beerQuery.update(self.name <- beer.getName(), self.strength <- beer.getStrength(), self.note <- beer.getNote())
        do {
            try self.db.run(updateBeer)
        } catch {
            print(error)
        }
    }
    
    func rowToBeer(row: Row!) -> Beer {
        return Beer.init(id: row[self.id], name: row[self.name], strength: row[self.strength], note: row[self.note])
    }

}
