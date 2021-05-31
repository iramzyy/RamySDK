//
//  InformationUIBuilder.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 01/05/2021.
//

import UIKit

public protocol InformationUIDataModelProtocol {
  var fields: [InformationDataType] { get }
}

public protocol InformationFieldDataModelProtocol {
  var name: String { get }
  var value: String { get }
}

public enum InformationDataType {
  case image(VisualContent)
  case field(InformationFieldDataModelProtocol)
}

public struct InformationFieldDataModel: InformationFieldDataModelProtocol {
  public var name: String
  public var value: String
}

public struct InformationUIDataModel: InformationUIDataModelProtocol {
  public let fields: [InformationDataType]
}

public final class InformationUIBuilder: UIBuilder {
  
  let uiModel: InformationUIDataModelProtocol
  
  init(uiModel: InformationUIDataModelProtocol) {
    self.uiModel = uiModel
  }
  
  public func build() -> UIView {
    let vStack = UIStackView(
      arrangedSubviews: uiModel.fields.map {
        self.createViewFrom($0)
      },
      axis: .vertical,
      spacing: Configurations.UI.Spacing.p1,
      alignment: .fill,
      distribution: .fill
    )
    
    vStack.setLayoutMargin(.horizontal(Configurations.UI.Spacing.p2))
    
    return vStack
  }
  
  private func createViewFrom(_ type: InformationDataType) -> UIView {
    switch type {
    case let .image(visualContent):
      let imageView = UIImageView().then {
        $0.set(visual: visualContent)
        $0.cornerRadius = 8
        $0.contentMode = .scaleAspectFill
      }
      
      let view = UIView()
      view.addSubview(imageView)
      
      imageView.snp.makeConstraints {
        $0.size.equalTo(Configurations.UI.Profile.pictureSize)
        $0.centerX.equalToSuperview()
        $0.top.bottom.equalToSuperview()
      }
      
      return view
    case let .field(fieldData):
      return UIStackView(
        arrangedSubviews: [
          Label(font: Configurations.UI.Font.subheadline, color: R.color.primaryTextColor() ?? .red).then {
            $0.text(fieldData.name)
            $0.setContentHuggingPriorityCustom(.both(.must))
          },
          Label(font: Configurations.UI.Font.body, color: R.color.primaryTextColor() ?? .red).then {
            $0.text(fieldData.value)
            $0.edgeInsets = .init(horizontal: Configurations.UI.Spacing.p1, vertical: Configurations.UI.Spacing.p05)
            $0.backgroundColor = R.color.secondaryBackgroundColor() ?? .red
            $0.cornerRadius = 8
            $0.setContentHuggingPriorityCustom(.both(.must))
          },
        ],
        axis: .vertical,
        spacing: Configurations.UI.Spacing.p05,
        alignment: .fill,
        distribution: .fill
      )
    }
  }
}
