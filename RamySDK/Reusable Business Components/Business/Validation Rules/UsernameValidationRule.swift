//
//  UsernameValidationRule.swift
//  SQ10
//
//  Created by Ahmed Ramy on 19/10/2021.
//

import Foundation

public struct UsernameValidationRule: ValidationRule, IsMandatory, HasMinimum, HasMaximum {
    public var value: String
    public var field: SQConfigurations.Validation.Field = .username

    public init(username: String = "") {
        value = username
    }

    public func validate() throws {
        try validateIsEmpty()
        try validateMinimum()
        try validateMaximum()
        guard value.rangeOfCharacter(from: .whitespacesAndNewlines) == nil else { throw ValidationError.cantContain(.whiteSpaces, field.title) }
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        guard value.rangeOfCharacter(from: characterset) != nil else { throw ValidationError.cantContain(.symbols, field.title) }
    }
}
