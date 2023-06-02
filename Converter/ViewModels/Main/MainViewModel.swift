//
//  MainViewModel.swift
//  Converter
//
//  Created by mozeX on 02.06.2023.
//

import Foundation

class MainViewModel {
    
    var currencyModel: CurrencyModel?
    var manager = CurrencyService()
    
    func fetchData() {
        let decoder = JSONDecoder()
        let defaults = UserDefaults.standard
        guard let dataModel = defaults.value(forKey: Constans.dataSaveKey) as? Data else { return }
        do {
            let decodedData = try decoder.decode(CurrencyModel.self, from: dataModel)
            self.currencyModel = decodedData
        } catch {
            print("Bad data")
        }
    }
}

extension MainViewModel: CurrencyServiceDelegate {
    func didFailError(error: String) {
        print(error)
    }
    
    
}
