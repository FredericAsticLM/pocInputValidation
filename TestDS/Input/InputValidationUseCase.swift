//
//  InputValidationUseCase.swift
//  TestDS
//
//  Created by FREDERIC ASTIC on 08/11/2023.
//

import Foundation

final class InputValidationUseCase {

    private let rules: [InputValidationRuleProtocol]

    init(rules: [InputValidationRuleProtocol]) {
        self.rules = rules
    }

    func perform(value: Any?) -> InputValidationResult {
        let results = rules.map { $0.isValid(object: value) }

        let foundError = results.first(where: { $0.isValid == false }) != nil
        var messages = [String]()
        results.forEach { result in
            if let errors = result.errors {
                messages.append(contentsOf: errors)
            }
        }
        return InputValidationResult(
            isValid: !foundError,
            errors: messages
        )
    }
}
