//
//  FirebasePlugin.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 15/04/2021.
//

//import Firebase
//
//struct FirebasePlugin { }
//
//extension FirebasePlugin: ApplicationPlugin {
//  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
//    setupFirebase()
//    setupPhoneAuthForSimulatorEnvIfNeeded()
//    return true
//  }
//
//  private func setupFirebase() {
//    FirebaseApp.configure()
//  }
//
//  private func setupPhoneAuthForSimulatorEnvIfNeeded() {
//    #if targetEnvironment(simulator)
//    Auth.auth().settings?.isAppVerificationDisabledForTesting = true
//    #endif
//  }
//}
