//
//  LocalError.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

enum LocalError: Error {
  case genericError
  case invalidEmail
  case passwordTooShort
  case namesCantContainNumbers
  case namesCantContainEmojis
  case namesCantContainSpecialCharacters
  case fieldCantBeEmpty(_ fieldName: String)
  case phoneNumberNotValid
  case nationalIDLengthIsNotValid
  case nationalIDNotValid
}

extension LocalError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .genericError:
      return R.string.localizables.generic_error()
    case .invalidEmail:
      return R.string.localizables.email_not_valid()
    case .passwordTooShort:
      return R.string.localizables.password_too_short()
    case .namesCantContainNumbers:
      return R.string.localizables.names_cant_contain_numbers()
    case .namesCantContainSpecialCharacters:
      return R.string.localizables.names_cant_contain_special_characters()
    case .namesCantContainEmojis:
      return R.string.localizables.names_cant_contain_emojis()
    case .fieldCantBeEmpty(let fieldName):
      return R.string.localizables.field_cant_be_empty(fieldName)
    case .phoneNumberNotValid:
      return "Phone number is not valid.".localized()
    case .nationalIDLengthIsNotValid:
      return "National ID must be 14 character, please double check.".localized()
    case .nationalIDNotValid:
      return "National ID is not valid, please double check.".localized()
    }
  }
}

enum InternalError: Error {
  case iOSCantAuthenticateUserLocally
}

extension InternalError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .iOSCantAuthenticateUserLocally:
      return "iOS Biometric & Pin Authentication Methods failed".localized()
    }
  }
}
