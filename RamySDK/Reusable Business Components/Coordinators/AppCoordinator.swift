//
//  AppCoordinator.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 30/03/2021.
//

import UIKit.UIViewController

public enum AppCoordinator {
//  public static func startFlow() -> UIViewController {
////    let numberOfInstalls = (try? ServiceLocator.shared.cacheManager.fetch(Int.self, for: .launchCount)) ?? 1
//    let isUserCached = (try? ServiceLocator.shared.cacheManager.fetch(User.self, for: .user)) != nil
//    let isUserLoggedIn = ServiceLocator.shared.auth.userToken != nil
////    let isFirstInstall = (numberOfInstalls > 1) == false
////    let doesntNeedUserVerification = AuthenticationService.shared.verificationStatus == .valid
////    let needsUserVerification = AuthenticationService.shared.verificationStatus == .expired
////    try? ServiceLocator.shared.cacheManager.save(numberOfInstalls + 1, for: .launchCount)
////    else if userIsCached && doesntNeedUserVerification { return goToMainFlow() }
////    else if userIsCached && needsUserVerification { return goToVerify(then: goToMainFlow()) )
//    if isUserLoggedIn && isUserCached { return goToMainFlow() }
////    else if isFirstInstall { return goToOnboardingFlow() }
////    else if hasNewUpdate { return goToOnboardingFlow() }
//    else { return goToAuthenticationFlow() }
//  }
//  
//  private static func goToAuthenticationFlow() -> UIViewController {
//    let vc = LoginViewController()
//    let vm = LoginViewModel(router: vc.router)
//    vc.bind(to: vm)
//    return UINavigationController(rootViewController: vc)
//  }
//  
//  private static func goToOnboardingFlow() -> UIViewController {
//    return WelcomeViewController()
//  }
//  
////  private static func goToVerify(then nextFlow: UIViewController) -> UIViewController {
////    let vc = VerificationViewController()
////    let vm = VerificationViewModel(router: vc.router, types: [.fingerPrint, .pin], afterVerification: nextFlow)
////    vc.bind(to: vm)
////    return vc
////  }
//  
//  private static func goToMainFlow() -> UIViewController {
//    return MainCoordinator.startFlow()
//  }
}
