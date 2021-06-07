//
//  PlaygroundViewController.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 05/04/2021.
//

import UIKit

//let uiModel = LocalVerificationUIDataModel(
//  supportedMethods: [
//    LocalVerificationMethodsUIDataModel(name: "Biometric", icon: .url("https://upload.wikimedia.org/wikipedia/commons/a/a0/%D7%94%D7%9C%D7%95%D7%92%D7%95_%D7%A9%D7%9C_%D7%9E%D7%A2%D7%A8%D7%9B%D7%AA_%D7%94%D6%BEFace_ID.jpg"), onTap: {
//      ServiceLocator.shared.auth.verifyUserLocally(preferredMethod: .biometric) { (results) in
//        switch results {
//        case .success:
//          print("ew3a da5al".tagWith(.internal))
//        case let .failure(error):
//          switch error {
//          case InternalError.iOSCantAuthenticateUserLocally:
//            print("7elw")
//          default:
//            print("error")
//          }
//        }
//      }
//    }),
//    LocalVerificationMethodsUIDataModel(
//      name: "Pin",
//      icon: .url("https://upload.wikimedia.org/wikipedia/commons/a/a0/%D7%94%D7%9C%D7%95%D7%92%D7%95_%D7%A9%D7%9C_%D7%9E%D7%A2%D7%A8%D7%9B%D7%AA_%D7%94%D6%BEFace_ID.jpg"),
//      onTap: {
//        ServiceLocator.shared.auth.verifyUserLocally(preferredMethod: .pin) { (results) in
//          switch results {
//          case .success:
//            print("ew3a da5al".tagWith(.internal))
//          case let .failure(error):
//            switch error {
//            case InternalError.iOSCantAuthenticateUserLocally:
//              print("7elw")
//            default:
//              print("error")
//            }
//          }
//        }
//      }
//    ),
//  ]
//)
//let builder = LocalVerificationUIBuilder(uiModel: uiModel)

//RatingsFactory.showRatingView(viewModel: .init(steps: [
//  .init(
//    title: "How big is your love to Salma?",
//    description: "❤️",
//    content: [
//      .init(title: "🌊", description: "As big as the ocean!"),
//      .init(title: "🌚", description: "As big as the moon!"),
//      .init(title: "🌍", description: "As big as the world!"),
//      .init(title: "🌞", description: "As big as the Sun!"),
//      .init(title: "🌌", description: "Aaaaad keda aho (Galaxies) 😌❤️")
//    ]
//  )
//]))

final class PlaygroundViewController: ListableViewController, NavigationComponentProtocol {
  public let scrollView = ScrollView().then {
    $0.clipsToBounds = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let uiModel = StaticUIDataModel(
      sections: [
        StaticSectionUIDataModel(
          elements: [
            StaticSectionElementUIDataModel(
              type: .text(
                .init(
                  .body,
                  "How's it going?",
                  .title
                )
              )
            )
          ],
          header: .init(
            .header,
            "Hi 🙌",
            .title
          )
        )
      ]
    )

    let builder = StaticUIBuilder(uiModel: uiModel)
    let renderedView = builder.build()
    
    self.view.addSubview(self.scrollView)
    
    self.scrollView.snp.remakeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(self.view.safeArea.top)
      $0.bottom.equalToSuperview()
    }
    
    self.scrollView.scrollableContentView = renderedView
  }
}
