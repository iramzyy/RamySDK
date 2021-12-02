//
//  EmailValidationRule.swift
//  SQ10
//
//  Created by Ahmed Ramy on 18/10/2021.
//

import Foundation

public struct EmailValidationRule: ValidationRule, IsMandatory {
    public var field: SQConfigurations.Validation.Field = .email

    public var value: String

    public init(email: String = "") {
        value = email
    }

    public func validate() throws {
        try validateIsEmpty()
        guard value.isValidEmail else { throw ValidationError.emailInvalid }
    }
}
