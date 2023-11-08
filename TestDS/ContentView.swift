//
//  ContentView.swift
//  TestDS
//
//  Created by FREDERIC ASTIC on 13/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    private var validator = InputValidationUseCase(
        rules: [
            InputValidationRuleTextNotEmpty("Non vide"),
            InputValidationRuleTextLength("Au moins 3 caractères")
        ]
    )

    @State var value: String = ""
    @State var result: InputValidationResult = InputValidationResult(isValid: true, errors: nil)
    @State var isChanged = false

    private var errors: [String] {
        guard let messages = result.errors else { return [] }

        return messages

    }
    var body: some View {
        VStack {
            TextField("My value", text: $value)
                .onChange(of: value) {
                    isChanged = true
                    result = validator.perform(value: value)
                }
            if isChanged {
                Text(result.isValid ? "" : "Erreurs : ")
                if !result.isValid {
                    VStack {
                        ForEach(errors, id: \.self) { message in
                            Text(message)
                        }
                    }
                }
            }

        }.padding()

    }
}
