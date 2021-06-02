//
//  RatingsFactory.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 31/05/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import SwiftEntryKit

public final class RatingsFactory {
  private func showRatingView(attributes: EKAttributes) {
    let unselectedImage = EKProperty.ImageContent(
      image: UIImage(named: "ic_star_unselected")!.withRenderingMode(.alwaysTemplate),
      displayMode: .inferred,
      tint: .standardContent
    )
    let selectedImage = EKProperty.ImageContent(
      image: UIImage(named: "ic_star_selected")!.withRenderingMode(.alwaysTemplate),
      displayMode: .inferred,
      tint: .clear
    )
    let initialTitle = EKProperty.LabelContent(
      text: "Rate our food",
      style: .init(
        font: .systemFont(ofSize: 17),
        color: .standardContent,
        alignment: .center,
        displayMode: .inferred
      )
    )
    let initialDescription = EKProperty.LabelContent(
      text: "How was it?",
      style: .init(
        font: .systemFont(ofSize: 17),
        color: EKColor.standardContent.with(alpha: 0.5),
        alignment: .center,
        displayMode: .inferred
      )
    )
    let items = [("💩", "Pooish!"), ("🤨", "Ahhh?!"), ("👍", "OK!"),
                 ("👌", "Tasty!"), ("😋", "Delicius!")].map { texts -> EKProperty.EKRatingItemContent in
                  let itemTitle = EKProperty.LabelContent(
                    text: texts.0,
                    style: .init(
                      font: .systemFont(ofSize: 17),
                      color: .standardContent,
                      alignment: .center,
                      displayMode: .inferred
                    )
                  )
                  let itemDescription = EKProperty.LabelContent(
                    text: texts.1,
                    style: .init(
                      font: .systemFont(ofSize: 17),
                      color: .standardContent,
                      alignment: .center,
                      displayMode: .inferred
                    )
                  )
                  return EKProperty.EKRatingItemContent(
                    title: itemTitle,
                    description: itemDescription,
                    unselectedImage: unselectedImage,
                    selectedImage: selectedImage
                  )
                 }
    
    var message: EKRatingMessage!
    let lightFont = UIFont.systemFont(ofSize: 17)
    let mediumFont = UIFont.systemFont(ofSize: 17)
    let closeButtonLabelStyle = EKProperty.LabelStyle(
      font: mediumFont,
      color: .standardContent,
      displayMode: .inferred
    )
    let closeButtonLabel = EKProperty.LabelContent(
      text: "Dismiss",
      style: closeButtonLabelStyle
    )
    let closeButton = EKProperty.ButtonContent(
      label: closeButtonLabel,
      backgroundColor: .clear,
      highlightedBackgroundColor: EKColor.standardBackground.with(alpha: 0.2),
      displayMode: .inferred) {
      SwiftEntryKit.dismiss {
        // Here you may perform a completion handler
      }
    }
    
    let okButtonLabelStyle = EKProperty.LabelStyle(
      font: lightFont,
      color: .clear,
      displayMode: .inferred
    )
    let okButtonLabel = EKProperty.LabelContent(
      text: "Tell us more",
      style: okButtonLabelStyle
    )
    let okButton = EKProperty.ButtonContent(
      label: okButtonLabel,
      backgroundColor: .clear,
      highlightedBackgroundColor: EKColor(.clear),
      displayMode: .inferred) {
      SwiftEntryKit.dismiss()
    }
    let buttonsBarContent = EKProperty.ButtonBarContent(
      with: closeButton, okButton,
      separatorColor: EKColor(light: .clear, dark: .clear),
      horizontalDistributionThreshold: 1,
      displayMode: .inferred,
      expandAnimatedly: true
    )
    message = EKRatingMessage(
      initialTitle: initialTitle,
      initialDescription: initialDescription,
      ratingItems: items,
      buttonBarContent: buttonsBarContent) { index in
      // Rating selected - do something
    }
    
    let contentView = EKRatingMessageView(with: message)
    SwiftEntryKit.display(entry: contentView, using: attributes)
  }
}
