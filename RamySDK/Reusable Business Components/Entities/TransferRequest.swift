//
//  TransferRequest.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/05/2021.
//

import Foundation

// MARK: - TransferRequest
public class TransferRequest: Cachable {
  public var requestUUID: String?
  public var userIdentifier: String?
  public var amount: String?
  public var reason: String?
  public var status: Status?
  private var timestamp: String?
  
  public var timeInterval: Date {
    Date(timeIntervalSince1970: (timestamp?.double() ?? 0.0))
  }
  
  public var signature: String?
  
  enum CodingKeys: String, CodingKey {
    case requestUUID = "request_uuid"
    case userIdentifier = "user_identifier"
    case amount = "amount"
    case reason = "reason"
    case status = "status"
    case timestamp = "timestamp"
    case signature = "signature"
  }
  
  public static func primaryKey() -> String? {
    "requestUUID"
  }
  
  public required init() { }
  
  public init(requestUUID: String?, userIdentifier: String?, amount: String?, reason: String?, status: Status?, timestamp: String?, signature: String?) {
    self.requestUUID = requestUUID
    self.userIdentifier = userIdentifier
    self.amount = amount
    self.reason = reason
    self.status = status
    self.timestamp = timestamp
    self.signature = signature
  }
  
  static let mock: [TransferRequest] = [
    .init(
      requestUUID: "123",
      userIdentifier: "123",
      amount: "123",
      reason: "123",
      status: .random(),
      timestamp: "1621800200",
      signature: "123"
    ),
    .init(
      requestUUID: "123",
      userIdentifier: "123",
      amount: "123",
      reason: "123",
      status: .random(),
      timestamp: "1621800314",
      signature: "123"
    ),
    .init(
      requestUUID: "123",
      userIdentifier: "123",
      amount: "123",
      reason: "123",
      status: .random(),
      timestamp: "1621800100",
      signature: "123"
    ),
    .init(
      requestUUID: "123",
      userIdentifier: "123",
      amount: "123",
      reason: "123",
      status: .random(),
      timestamp: "1621800000",
      signature: "123"
    ),
    .init(
      requestUUID: "123",
      userIdentifier: "123",
      amount: "123",
      reason: "123",
      status: .random(),
      timestamp: "162180099",
      signature: "123"
    ),
    .init(
      requestUUID: "123",
      userIdentifier: "123",
      amount: "123",
      reason: "123",
      status: .random(),
      timestamp: "1621800295",
      signature: "123"
    ),
    .init(
      requestUUID: "123",
      userIdentifier: "123",
      amount: "123",
      reason: "123",
      status: .random(),
      timestamp: "1621800099",
      signature: "123"
    ),
    .init(
      requestUUID: "123",
      userIdentifier: "123",
      amount: "123",
      reason: "123",
      status: .random(),
      timestamp: "1621800259",
      signature: "123"
    ),
  ]
}

public extension TransferRequest {
  enum Status: String, Codable, CaseIterable {
    case approved
    case pending
    case cancelled
    
    func toViewModel() -> RequestFromStatus {
      switch self {
      case .approved:
        return .init(title: "Approved", color: R.color.approvedStatusColor()!)
      case .cancelled:
        return .init(title: "Cancelled", color: R.color.cancelledStatusColor()!)
      case .pending:
        return .init(title: "Pending", color: R.color.pendingStatusColor()!)
      }
    }
    
    var fullfilledPriority: Int {
      switch self {
      case .approved: return 1
      case .pending: return 0
      case .cancelled: return 0
      }
    }
    
    var pendingPriority: Int {
      switch self {
      case .pending: return 1
      case .cancelled: return 0
      case .approved: return 0
      }
    }
    
    var cancelledPriority: Int {
      switch self {
      case .cancelled: return 1
      case .pending: return 0
      case .approved: return 0
      }
    }
    
    static func random() -> Status {
      Self.allCases.randomElement() ?? .pending
    }
  }
}
