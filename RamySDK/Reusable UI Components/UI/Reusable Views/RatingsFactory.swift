//
//  RatingsFactory.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 31/05/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import SwiftEntryKit

public final class RatingsFactory {
  
  private static func getDefaultRatingAttributes() -> EKAttributes {
    var attribute = EKAttributes()
    attribute.border = .none
    attribute.entryBackground = .color(color: .init(ThemeManager.shared.selectedTheme.transparency.light(by: 95)))
    attribute.screenBackground = .color(color: .init(ThemeManager.shared.selectedTheme.transparency.dark(by: 65)))
    attribute.entryInteraction = .absorbTouches
    attribute.displayDuration = .infinity
    attribute.displayMode = .inferred
    attribute.hapticFeedbackType = .success
    attribute.roundCorners = .all(radius: Metrics.radius.getMetric(for: .ratingForm))
    attribute.entranceAnimation = .translation
    attribute.exitAnimation = .translation
    attribute.exitAnimation = .translation
    attribute.position = .center
    attribute.positionConstraints = .float
    
    return attribute
  }
  
  static func showRatingView(viewModel: RatingViewModel) {
    let unselectedImage = EKProperty.ImageContent(
      image: R.image.star()!,
      displayMode: .inferred,
      tint: EKColor.init(R.color.monochromaticOffblack()!)
    )
    let selectedImage = EKProperty.ImageContent(
      image: R.image.filledStar()!,
      displayMode: .inferred,
      tint: EKColor.init(R.color.monochromaticOffblack()!)
    )
    
    let steps = viewModel.steps.map { step -> (title: EKProperty.LabelContent, description: EKProperty.LabelContent, items: [EKProperty.EKRatingItemContent]) in
      let title = EKProperty.LabelContent(
        text: step.title,
        style: .init(
          font: FontManager.shared.getSuitableFont(category: .link, scale: .medium, weight: .bold).font,
          color: EKColor.init(R.color.monochromaticOffblack()!),
          alignment: .center,
          displayMode: .inferred
        )
      )
      
      let description = EKProperty.LabelContent(
        text: step.description,
        style: .init(
          font: FontManager.shared.getSuitableFont(category: .link, scale: .xsmall, weight: .bold).font,
          color: EKColor.init(R.color.monochromaticBody()!),
          alignment: .center,
          displayMode: .inferred
        )
      )
      
      let items = step.content.map { item -> EKProperty.EKRatingItemContent in
        let itemTitle = EKProperty.LabelContent(
          text: item.title,
          style: .init(
            font: FontManager.shared.getSuitableFont(category: .display, scale: .huge, weight: .bold).font,
            color: .init(R.color.monochromaticOffblack()!),
            alignment: .center,
            displayMode: .inferred
          )
        )
        
        let itemDescription = EKProperty.LabelContent(
          text: item.description,
          style: .init(
            font: FontManager.shared.getSuitableFont(category: .link, scale: .xsmall, weight: .bold).font,
            color: EKColor.init(R.color.monochromaticBody()!),
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
      
      return (title: title, description: description, items: items)
    }
    
    var message: EKRatingMessage!
    let lightFont = FontManager.shared.getSuitableFont(
      category: .text,
      scale: .large,
      weight: .regular
    ).font
    
    let mediumFont = FontManager.shared.getSuitableFont(
      category: .text,
      scale: .large,
      weight: .bold
    ).font
    
    let closeButtonLabelStyle = EKProperty.LabelStyle(
      font: lightFont,
      color: .init(R.color.primaryDefault()!),
      displayMode: .inferred
    )
    
    let closeButtonLabel = EKProperty.LabelContent(
      text: "Dismiss".localized(),
      style: closeButtonLabelStyle
    )
    
    let closeButton = EKProperty.ButtonContent(
      label: closeButtonLabel,
      backgroundColor: .clear,
      highlightedBackgroundColor: .init(R.color.monochromaticOffblack()!),
      displayMode: .inferred) {
      SwiftEntryKit.dismiss {
        // Here you may perform a completion handler
      }
    }
    
    let okButtonLabelStyle = EKProperty.LabelStyle(
      font: mediumFont,
      color: .init(R.color.primaryDefault()!),
      displayMode: .inferred
    )
    let okButtonLabel = EKProperty.LabelContent(
      text: "Tell us more".localized(),
      style: okButtonLabelStyle
    )
    
    let okButton = EKProperty.ButtonContent(
      label: okButtonLabel,
      backgroundColor: .clear,
      highlightedBackgroundColor: EKColor(R.color.monochromaticOffblack()!),
      displayMode: .inferred) {
      SwiftEntryKit.dismiss()
    }
    
    let buttonsBarContent = EKProperty.ButtonBarContent(
      with: closeButton, okButton,
      separatorColor: .init(R.color.monochromaticLine()!),
      horizontalDistributionThreshold: 1,
      displayMode: .inferred,
      expandAnimatedly: true
    )
    
    message = EKRatingMessage(
      initialTitle: steps.first!.title,
      initialDescription: steps.first!.description,
      ratingItems: steps.first!.items,
      buttonBarContent: buttonsBarContent) { index in
      // Rating selected - do something
    }
    
    let contentView = EKRatingMessageView(with: message)
    SwiftEntryKit.display(entry: contentView, using: getDefaultRatingAttributes())
  }
}

public extension RatingsFactory {
  struct RatingViewModel {
    let steps: [RatingStep]
  }
}

public extension RatingsFactory.RatingViewModel {
  struct RatingStep {
    let title: String
    let description: String
    let content: [RatingContent]
  }
  
  struct RatingContent {
    let title: String
    let description: String
  }
}
