//
//  SettingsUIBuilder.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 05/04/2021.
//

import UIKit

public protocol StaticUIDataModelProtocol {
  var sections: [StaticSectionUIDataModelProtocol] { get }
}

public protocol StaticSectionUIDataModelProtocol {
  var header: String { get }
  var elements: [StaticSectionElementUIDataModelProtocol] { get }
  var noBackground: Bool { get set }
}

public extension StaticSectionUIDataModelProtocol {
  var noBackground: Bool { false }
}

public protocol StaticSectionElementUIDataModelProtocol {
  var type: StaticSectionUIDataType { get }
}

public enum StaticSectionUIDataType {
  case multipleOptions(title: String, isExpanded: Bool, options: PickerUIDataModel, onTap: VoidCallback)
  case date(title: String, type: UIDatePicker.Mode, onChoosingDate: Callback<Date>)
  case phoneNumber(onType: Callback<String>)
  case field(title: String, value: String, onType: Callback<String>)
  case text(String, Font)
  case button(Button.TypeOfButton, onTap: VoidCallback)
  case picker(PickerUIDataModelProtocol)
  case stepper(title: String, startingValue: Double, onValueChanging: Callback<Double>)
  case `switch`(title: String, isOn: Bool, contents: [StaticSectionUIDataType], onSwitching: Callback<Bool>)
}

public struct StaticUIDataModel: StaticUIDataModelProtocol {
  public var sections: [StaticSectionUIDataModelProtocol]
}

public struct StaticSectionUIDataModel: StaticSectionUIDataModelProtocol {
  public var elements: [StaticSectionElementUIDataModelProtocol]
  public var header: String
  public var noBackground: Bool = false
}

public struct StaticSectionElementUIDataModel: StaticSectionElementUIDataModelProtocol {
  public var type: StaticSectionUIDataType
}

final class StaticUIBuilder: UIBuilder {
  
  let uiModel: StaticUIDataModelProtocol
  
  init(uiModel: StaticUIDataModelProtocol) {
    self.uiModel = uiModel
  }
  
  func build() -> UIView {
    let vStack = UIStackView(arrangedSubviews: uiModel.sections.map { buildSection(from: $0) }, axis: .vertical, spacing: Spacing.p3, alignment: .fill, distribution: .fill).then {
      $0.setLayoutMargin(.all(Spacing.p2))
    }
    
    return vStack
  }
  
  func buildSection(from model: StaticSectionUIDataModelProtocol) -> UIStackView {
    let containerView = UIView().then {
      $0.backgroundColor = model.noBackground ? .clear : .white
      $0.cornerRadius = 8
    }
    
    let containerContents = UIStackView(
      arrangedSubviews: model.elements.map { generateView(from: $0.type) },
      axis: .vertical,
      spacing: Spacing.p2,
      alignment: .fill,
      distribution: .fill
    ).then {
      $0.setLayoutMargin(.all(Spacing.p2))
    }
    
    containerView.addSubview(containerContents)
    
    containerContents.fillSuperview()
    
    return UIStackView(
      arrangedSubviews: [
        Label(font: FontStyles.title2, color: .black).then { $0.text(model.header) },
        containerView
      ],
      axis: .vertical,
      spacing: 8
    )
  }
  
  func generateView(from type: StaticSectionUIDataType) -> UIView {
    switch type {
    case let .text(text, font):
      return Label(font: font, color: .gray).then { $0.text(text) }
    case let .phoneNumber(onType):
      return PhoneTextFieldView().then { $0.textField.onInput = { text in onType(text ?? .empty) } }
    case let .multipleOptions(title, isExpanded, options, onTap):
      return UIStackView(
        arrangedSubviews: [Button.makeMultipleOptionsButton(text: title, onTap: onTap)],
        axis: .vertical,
        spacing: Spacing.p1,
        alignment: .fill,
        distribution: .fill
      ).then {
        if isExpanded {
          $0.addArrangedSubview(PickerView().then { $0.configure(with: options) })
        }
      }
    case let .date(title, type, onChoosingDate):
      return UIStackView(
        arrangedSubviews: [
          Label(font: FontStyles.footnote, color: .gray).then { $0.text(title) },
          UIDatePicker().then { picker in
            if #available(iOS 14, *) {
              picker.preferredDatePickerStyle = .inline
            } else if #available(iOS 13.4, *) {
              picker.preferredDatePickerStyle = .compact
            }
            picker.datePickerMode = type
            picker.setControlEvent(.valueChanged) {
              onChoosingDate(picker.date)
            }
          }
        ],
        axis: .vertical,
        spacing: Spacing.p05,
        alignment: .fill,
        distribution: .fill
      )
    case let .field(title, value, onType):
      return UIStackView(
        arrangedSubviews: [
          Label(font: FontStyles.footnote, color: .gray).then { $0.text(title) },
          BasicTextField().then {
            $0.text = value
            $0.onInput = { text in onType(text ?? .empty) }
          }
        ],
        axis: .vertical,
        spacing: Spacing.p05,
        alignment: .fill,
        distribution: .fill
      )
    case let .button(type, onTap):
      return Button(type: .system).then {
        $0.type = type
        $0.setControlEvent(.touchUpInside) { onTap() }
      }
    case let .picker(uiModel):
      return PickerView().then { $0.configure(with: uiModel) }
    case let .stepper(title, value, onValueChanging):
      let textField = BasicTextField().then {
        $0.text = MoneyTransformer.format(amount: value)
        $0.keyboardType = .decimalPad
      }
      
      let stepper = UIStepper().then { stepper in
        stepper.value = value
        stepper.setContentHuggingPriorityCustom(.both(.must))
        stepper.setContentResistancePriorityCustom(.both(.must))
        stepper.minimumValue = 0.0
        stepper.stepValue = 0.05
        stepper.setControlEvent(.touchUpInside) {
          textField.text = MoneyTransformer.format(amount: stepper.value)
          onValueChanging(stepper.value)
        }
      }
      
      let currencyLabel = Label(font: FontStyles.caption1, color: R.color.primaryDefault()!).then {
        $0.setContentHuggingPriorityCustom(.horizontal(.required))
        $0.setContentResistancePriorityCustom(.horizontal(.lessThanStandard))
        $0.text = UserSettingsService.shared.currency.value
      }
      
      let titleLabel = Label(font: FontStyles.footnote, color: .gray).then {
        $0.text(title)
        $0.setContentHuggingPriorityCustom(.horizontal(.must))
        $0.setContentResistancePriorityCustom(.horizontal(.must))
        $0.text = title
      }
      
      textField.onInput = {
        stepper.value = ($0 ?? "0.0").double() ?? 0.0
      }
      
      return UIStackView(
        arrangedSubviews: [
          titleLabel,
          stepper,
          textField,
          currencyLabel
        ],
        axis: .horizontal,
        spacing: Spacing.p1,
        alignment: .fill,
        distribution: .fillProportionally
      )
    case let .switch(title, isOn, contents, onSwitching):
      let mainHStack = UIStackView(
        arrangedSubviews: [
          Label(font: FontStyles.footnote, color: .gray).then {
            $0.text(title)
            $0.setContentResistancePriorityCustom(.both(.must))
            $0.setContentHuggingPriorityCustom(.both(.must))
          },
          .spacingView(),
          UISwitch().then { switchView in
            switchView.isOn = isOn
            switchView.setControlEvent(.touchUpInside) {
              onSwitching(!isOn)
            }
          }
        ],
        axis: .horizontal,
        spacing: Spacing.p1,
        alignment: .fill,
        distribution: .fill
      )
      if isOn {
        return UIStackView(arrangedSubviews: [mainHStack] + contents.map { generateView(from: $0) }, axis: .vertical, spacing: Spacing.p1)
      } else {
        return mainHStack
      }
    }
  }
}

extension Button {
  static func makeMultipleOptionsButton(text: String, onTap: @escaping VoidCallback) -> Button {
    return Button(type: .system).then {
      $0.type = .textWithTrailingIcon(text, icon: .init(), style: SettingsButtonStyle())
      $0.setControlEvent(.touchUpInside) { onTap() }
    }
  }
}
