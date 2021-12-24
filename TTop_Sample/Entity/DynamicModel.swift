//
//  DynamicModel.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/3/1400 AP.
//

import Foundation

struct DynamicModel: Codable {
    let title: String?
    let items: [Items]?
}

struct Items: Codable {
    let key: String?
    let value: String?
}
