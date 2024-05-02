//
//  CatsModel.swift
//  CatFacts
//
//  Created by Bakar Kharabadze on 5/1/24.
//

import Foundation

struct CatFactsList: Codable {
    let data: [CatFact]
}

struct CatFact: Codable {
    let fact: String
    let length: Int
}
