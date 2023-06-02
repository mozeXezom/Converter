//
//  Alert.swift
//  Converter
//
//  Created by mozeX on 02.06.2023.
//

import Foundation
import UIKit

extension UIViewController {
   
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
      
        self.present(alert, animated: true, completion: nil)
    }
}
