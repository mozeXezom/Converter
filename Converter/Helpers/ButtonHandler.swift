//
//  ButtonHandler.swift
//  Converter
//
//  Created by mozeX on 02.06.2023.
//

import UIKit

enum ButtonDirection {
    case right
    case left
}

protocol ButtonHandlerDelegate: AnyObject {
    func select(key: String, button: ButtonDirection)
}
