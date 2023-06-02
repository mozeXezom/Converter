//
//  ListViewModel.swift
//  Converter
//
//  Created by mozeX on 02.06.2023.
//

import Foundation
import UIKit

class ListViewModel {
    
    var currencyData: [String] = []
    let defaults = UserDefaults.standard
    
    func getDataDefaults() {
        guard let data = defaults.value(forKey: Constans.dataSaveKey) as? Data else { return }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyModel.self, from: data)
            currencyData.append(contentsOf: decodedData.rates.keys)
            print(currencyData)
        } catch {
            print("Bad data")
        }
    }
    
    func dismiss(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}
