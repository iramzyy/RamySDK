//
//  PhoneAuthService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 15/04/2021.
//

//import Firebase
//
//public protocol PhoneAuthServiceProtocol: Service {
//  func sendOTP(to phoneNumber: String, onVerification: @escaping Handler<Void>)
//  func authenticate(with otp: String, onVerification: @escaping Handler<Firebase.User>)
//}
//
//public final class PhoneAuthService: PhoneAuthServiceProtocol {
//  private var verificationID: String?
//
//  private lazy var provider = PhoneAuthProvider.provider()
//
//  public func sendOTP(to phoneNumber: String, onVerification: @escaping Handler<Void>) {
//    provider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
//      guard let self = self else { return }
//      guard error == nil else {
//        onVerification(.failure(error!))
//        return
//      }
//
//      guard let verificationID = verificationID else {
//        onVerification(.failure(LocalError.genericError))
//        return
//      }
//
//      self.verificationID = verificationID
//      onVerification(.success(()))
//    }
//  }
//
//  public func authenticate(with otp: String, onVerification: @escaping Handler<Firebase.User>) {
//    guard let verificationID = verificationID else { return }
//    let credential = provider.credential(withVerificationID: verificationID, verificationCode: otp)
//    Auth.auth().signIn(with: credential) { (authData, error) in
//      guard error == nil else {
//        onVerification(.failure(error!))
//        return
//      }
//
//      guard let user = authData?.user else {
//        onVerification(.failure(LocalError.genericError))
//        return
//      }
//
//      onVerification(.success(user))
//    }
//  }
//
//  deinit {
//    LoggersManager.info("PhoneAuthService: Deinit")
//  }
//}
