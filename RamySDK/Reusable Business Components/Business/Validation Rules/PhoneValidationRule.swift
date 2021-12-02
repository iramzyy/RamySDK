//
//  PhoneValidationRule.swift
//  SQ10
//
//  Created by Ahmed Ramy on 19/10/2021.
//

import Foundation
import PhoneNumberKit

struct PhoneValidationRule: ValidationRule {
    public var value: String
    public var countryCode: String

    public var field: SQConfigurations.Validation.Field = .mobile

    public init(phone: String = "", countryCode: String = "") {
        value = phone
        self.countryCode = countryCode
    }

    public func validate() throws {
        try validateIsEmpty()
        try validateMaximum()
        guard value.containsLetter == false else { throw ValidationError.cantContain(.letters, field.title) }
        do {
            _ = try PhoneNumberKit().parse(countryCode + value)
        } catch let error {
            throw SQErrorParser().parse(error)
        }
    }
}

extension PhoneValidationRule: IsMandatory {}
extension PhoneValidationRule: HasMaximum {}

extension String {
    var containsSymbols: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[^a-z0-9 ]", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) {
                return true
            } else {
                return false
            }
        } catch {
            LoggersManager.error(message: error.localizedDescription.tagWith(.internal))
            return true
        }
    }
}
