//
//  MatchingPasswordValidationRule.swift
//  SQ10
//
//  Created by Ahmed Ramy on 19/10/2021.
//

import Foundation

public struct MatchingPasswordsValidationRule: ValidationRule {
    public var value: String
    private let repeatPassword: String

    public init(password: String, repeatPassword: String) {
        value = password
        self.repeatPassword = repeatPassword
    }

    public func validate() throws {
        guard value == repeatPassword else { throw ValidationError.passwordMismatch }
    }
}
