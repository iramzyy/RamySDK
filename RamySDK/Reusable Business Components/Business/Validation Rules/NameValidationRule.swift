//
//  NameValidationRule.swift
//  SQ10
//
//  Created by Ahmed Ramy on 19/10/2021.
//

import Foundation

public struct NameValidationRule: ValidationRule {
    public var field: SQConfigurations.Validation.Field { isFirstName ? .firstName : .lastName }

    public var value: String
    public var isFirstName: Bool

    public init(name: String = "", isFirstName: Bool) {
        value = name
        self.isFirstName = isFirstName
    }

    public func validate() throws {
        try validateIsEmpty()
        try validateMinimum()
        try validateMaximum()
    }
}

extension NameValidationRule: IsMandatory {}
extension NameValidationRule: HasMinimum {}
extension NameValidationRule: HasMaximum {}
