//
//  CurrencyModel.swift
//  Converter
//
//  Created by mozeX on 02.06.2023.
//

import Foundation

struct CurrencyModel: Codable {
    let base_code: String
    var rates: [String: Double]
}
