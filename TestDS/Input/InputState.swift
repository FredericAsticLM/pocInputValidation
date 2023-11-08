//
//  InputState.swift
//  TestDS
//
//  Created by FREDERIC ASTIC on 08/11/2023.
//

import Foundation
enum InputState {

    case invalid(errorMessage: String?)
    case neutral
    case valid

    var isValid: Bool {
        guard case .valid = self else {
            return false
        }

        return true
    }
}
