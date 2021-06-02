//
//  PickerView.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 05/04/2021.
//

import UIKit

public protocol PickerUIDataModelProtocol {
  var rows: [PickerRowDataModelProtocol] { get set }
  var selectedRow: String { get set }
  var onSelect: Callback<PickerRowDataModelProtocol> { get set }
}

public protocol PickerRowDataModelProtocol {
  var id: String { get set }
  var title: String { get set }
}

public struct PickerUIDataModel: PickerUIDataModelProtocol {
  public var rows: [PickerRowDataModelProtocol]
  public var selectedRow: String
  public var onSelect: Callback<PickerRowDataModelProtocol>
}

public struct PickerRowDataModel: PickerRowDataModelProtocol {
  public var id: String
  public var title: String
}

public final class PickerView: UIPickerView, Configurable {
  var uiModel: PickerUIDataModelProtocol!
  
  public func configure(with viewModel: PickerUIDataModelProtocol) {
    self.uiModel = viewModel
    self.delegate = self
    self.dataSource = self
    self.reloadAllComponents()
    guard let selectedRowIndex = viewModel.rows.firstIndex(where: { $0.id == viewModel.selectedRow }) else { return }
    self.selectRow(selectedRowIndex, inComponent: 0, animated: false)
  }
}

extension PickerView: UIPickerViewDataSource, UIPickerViewDelegate {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    uiModel.rows.count
  }
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    uiModel.rows[row].title
  }
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    uiModel.onSelect(uiModel.rows[row])
  }
}
