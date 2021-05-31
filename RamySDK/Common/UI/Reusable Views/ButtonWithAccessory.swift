//
//  ButtonWithAccessory.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 21/05/2021.
//

import UIKit

public protocol ButtonWithAccessoryUIDataModelProtocol {
  var title: String { get set }
  var buttonStyle: ButtonStyle { get set }
  var accessoryView: UIView { get set }
  var onTap: VoidCallback { get set }
}

public struct ButtonWithAccessoryUIDataModel: ButtonWithAccessoryUIDataModelProtocol {
  public var title: String
  public var buttonStyle: ButtonStyle
  public var accessoryView: UIView
  public var onTap: VoidCallback
}

public final class ButtonWithAccessory: UIView, Configurable {
  let label = Label(font: TextStyles.button, color: R.color.textButtonTextColor()!).then {
    $0.textAlignment = .center
    $0.setContentResistancePriorityCustom(.both(.must))
    $0.setContentHuggingPriorityCustom(.both(.must))
  }
  
  let overlayButton = Button(type: .system)
  
  lazy var hStack = UIStackView(
    arrangedSubviews: [
      label
    ], axis: .horizontal,
    spacing: 8,
    alignment: .center,
    distribution: .fillProportionally
  )
  
  public func configure(with viewModel: ButtonWithAccessoryUIDataModelProtocol) {
    label.text(viewModel.title)
    label.customTextColor = viewModel.buttonStyle.textColor
    hStack.addArrangedSubview(viewModel.accessoryView)
    overlayButton.type = .text(.empty, style: OverlayButtonStyle())
    overlayButton.setControlEvent(.touchUpInside) {
      viewModel.onTap()
    }
    backgroundColor = viewModel.buttonStyle.backgroundColor
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
}

private extension ButtonWithAccessory {
  func initialize() {
    self.cornerRadius = Dimensions.Buttons.cornerRadius
    
    addSubview(hStack)
    addSubview(overlayButton)
    
    hStack.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.leading.trailing.equalToSuperview().priority(999)
    }
    overlayButton.fillSuperview()
  }
}
