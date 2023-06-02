//
//  CurrencyService.swift
//  Converter
//
//  Created by mozeX on 02.06.2023.
//

import Foundation

struct CurrencyService {
    
    var delegate: CurrencyServiceDelegate?
    var defaults = UserDefaults.standard
    
    func fetchJSON() {
        guard let url = URL(string: Constans.baseUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                delegate?.didFailError(error: error.localizedDescription)
                return
            }
            guard let safeData = data else {
                delegate?.didFailError(error: "Error")
                return
            }
            saveData(safeData)
        }.resume()
    }
    
    private func saveData(_ data: Data) {
        defaults.setValue(data, forKey: Constans.dataSaveKey)
        return
    }
}
