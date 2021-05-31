//
//  ValidationRule.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

protocol ValidationRule {
  func validate(text: String) -> String?
}

struct EmailRule: ValidationRule {
  func validate(text: String) -> String? {
    return text.isValidEmail ? nil : LocalError.invalidEmail.localizedDescription
  }
}

struct PasswordRule: ValidationRule {
  func validate(text: String) -> String? {
    return text.count < 8 ? LocalError.passwordTooShort.localizedDescription : nil
  }
}

struct NameRule: ValidationRule {
  
  let fieldName: String
  
  func validate(text: String) -> String? {
    guard !text.isEmpty else { return LocalError.fieldCantBeEmpty(fieldName).localizedDescription }
    guard !text.isAlphaNumeric && !text.isNumeric else { return LocalError.namesCantContainNumbers.localizedDescription }
    guard !text.containEmoji else { return LocalError.namesCantContainEmojis.localizedDescription }
    return nil
  }
}

struct PhoneRule: ValidationRule {
  func validate(text: String) -> String? {
    guard PhoneNumberKitHelper.validate(string: text) else { return LocalError.phoneNumberNotValid.localizedDescription }
    return nil
  }
}

struct NationalIDRule: ValidationRule {
  func validate(text: String) -> String? {
    let trimmedText = text
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .replacingOccurrences(of: " ", with: "")
    guard trimmedText.count == 14 else { return LocalError.nationalIDLengthIsNotValid.localizedDescription }
    guard trimmedText.matches("^\\d{3}(0[1-9]|1[0-2])([0-2][1-9]|[1-2]0|3[0-1])\\d{7}") else { return LocalError.nationalIDNotValid.localizedDescription }
    return nil
  }
}
