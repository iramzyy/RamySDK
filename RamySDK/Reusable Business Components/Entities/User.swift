//
//  User.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 01/04/2021.
//

import Foundation

public class User: Cachable {
  public var uuid: String?
  public var code: String?
  public var name: String?
  public var nationalID: String?
  public var phoneNumber: String?
  public var email: String?
  public var verified: Bool?
  
  enum CodingKeys: String, CodingKey {
    case uuid = "uuid"
    case code = "code"
    case name = "name"
    case nationalID = "national_id"
    case phoneNumber = "phone_number"
    case email = "email"
    case verified = "verified"
  }
  
  public init(uuid: String?, code: String?, name: String?, nationalID: String?, phoneNumber: String?, email: String?, verified: Bool?) {
    self.uuid = uuid
    self.code = code
    self.name = name
    self.nationalID = nationalID
    self.phoneNumber = phoneNumber
    self.email = email
    self.verified = verified
  }
  
  public static func primaryKey() -> String? {
    "uuid"
  }
  
  public required init() { }
}

public extension User {
  final class Insensitive: Cachable {
    public var id: String
    public var code: String
    public var name: String
    
    public init(id: String, code: String, name: String) {
      self.id = id
      self.code = code
      self.name = name
    }
    
    public required init() {
      self.id = ""
      self.code = ""
      self.name = ""
    }
  }
  
  func toInsensitive() -> Insensitive {
    .init(id: uuid ?? "", code: code ?? "", name: name ?? "")
  }
}

extension User {
  static var mockedAhmedRamy: User = User(uuid: "", code: "123456", name: "Ahmed Ramy", nationalID: "12345678901234", phoneNumber: "+201068476461", email: "dev.ahmedramy@gmail.com", verified: true)
}
