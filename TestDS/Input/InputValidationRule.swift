//
//  InputValidationRule.swift
//  TestDS
//
//  Created by FREDERIC ASTIC on 08/11/2023.
//

import Foundation
struct InputValidationResult {
    let isValid: Bool
    let errors: [String]?
}

protocol InputValidationRuleProtocol {
    var errorMessage: String { get }
    func isValid(object: Any?) -> InputValidationResult
}

class InputValidationRuleBase: InputValidationRuleProtocol {
    
    var errorMessage: String = ""
    init(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    func isValid(object: Any?) -> InputValidationResult { InputValidationResult(isValid: false, errors: nil) }
    func build(_ isValueValid: Bool) -> InputValidationResult {
        InputValidationResult(
            isValid: isValueValid,
            errors: isValueValid ? nil : [self.errorMessage]
        )
    }
}

final class InputValidationRuleTextNotEmpty: InputValidationRuleBase {
    override func isValid(object: Any?) -> InputValidationResult {
        guard let stringValue = object as? String else {
            return build(false)
        }

        return build(stringValue.isEmpty == false)
    }
}

final class InputValidationRuleTextLength: InputValidationRuleBase {

    private let minLength: Int
    private let maxLength: Int?

    init(_ errorMessage: String, minLength: Int = 3, maxLength: Int? = nil) {
        self.minLength = minLength
        self.maxLength = maxLength
        super.init(errorMessage)
    }

    override func isValid(object: Any?) -> InputValidationResult {
        guard let stringValue = object as? String else {
            return build(false)
        }

        guard let maxLength else {
            return build(stringValue.count >= minLength)
        }

        return build(stringValue.count >= minLength && stringValue.count <= maxLength)
    }
}

final class InputValidationRuleEmail: InputValidationRuleBase {

    private let regexValue = "[here cool regex to check email]"

    override func isValid(object: Any?) -> InputValidationResult {
        guard let stringValue = object as? String else {
            return build(false)
        }

        let result = stringValue.range(
            of: regexValue,
            options: .regularExpression
        )

        return build(result != nil)
    }
}
