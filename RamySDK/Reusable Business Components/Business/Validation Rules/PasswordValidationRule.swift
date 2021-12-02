//
//  PasswordValidationRule.swift
//  SQ10
//
//  Created by Ahmed Ramy on 18/10/2021.
//

import Foundation

public final class PasswordValidationRule: ValidationRule {
    public var field: SQConfigurations.Validation.Field { isConfirmPassword ? .confirmPassword : .password }

    public var value: String
    public var isConfirmPassword: Bool
    public private(set) lazy var checks: [PasswordStrengthCheck] = {
        [
            atLeastOneNumberExists,
        ]
    }()

    private lazy var atLeastOneNumberExists: PasswordStrengthCheck = { password in
        guard password.containsNumber else {
            throw ValidationError.passwordWeak(
                reason: .noNumbers
            )
        }
    }

    public init(password: String = "", isConfirmPassword: Bool = false) {
        value = password
        self.isConfirmPassword = isConfirmPassword
    }

    public func validate() throws {
        try validateIsEmpty()
        try validateMinimum()
        try validateStrength()
    }
}

extension PasswordValidationRule: HasMinimum {}
extension PasswordValidationRule: HasMaximum {}
extension PasswordValidationRule: IsMandatory {}
extension PasswordValidationRule: PasswordStrengthValidator {}
