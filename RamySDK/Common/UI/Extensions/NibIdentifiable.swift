//
//  NibIdentifiable.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/03/2021.
//

import UIKit

public protocol NibIdentifiable {
  static var nibIdentifier: String { get }
}

public extension NibIdentifiable {
  static var nib: UINib {
    return UINib(nibName: nibIdentifier, bundle: nil)
  }
}

extension UIView: NibIdentifiable {
  public static var nibIdentifier: String {
    return String(describing: self)
  }
}

extension UIViewController: NibIdentifiable {
  public static var nibIdentifier: String {
    return String(describing: self)
  }
}

public extension NibIdentifiable where Self: UIViewController {
  static func instantiateFromNib() -> Self {
    return Self(nibName: nibIdentifier, bundle: Bundle(for: self))
  }
}

public extension NibIdentifiable where Self: UIView {
  static func instantiateFromNib() -> Self {
    guard let view = UINib(nibName: nibIdentifier, bundle: Bundle(for: self))
      .instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("Couldn't find nib file for \(String(describing: Self.self))")
    }
    return view
  }
}

public extension UITableView {
  func registerCell<T: UITableViewCell>(type: T.Type) {
    register(type.nib, forCellReuseIdentifier: String(describing: T.self))
  }

  func registerHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) {
    register(type.nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
  }

  func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
      fatalError("Couldn't find nib file for \(String(describing: T.self))")
    }
    return cell
  }

  func dequeueReusableCell<T: UITableViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                         for: indexPath) as? T else {
      fatalError("Couldn't find nib file for \(String(describing: T.self))")
    }
    return cell
  }

  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) -> T {
    guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T
    else {
      fatalError("Couldn't find nib file for \(String(describing: T.self))")
    }
    return headerFooterView
  }
}

public extension UICollectionView {
  func registerCell<T: UICollectionViewCell>(type: T.Type) {
    register(type.nib, forCellWithReuseIdentifier: String(describing: T.self))
  }

  func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                         for: indexPath) as? T else {
      fatalError("Couldn't find nib file for \(String(describing: T.self))")
    }
    return cell
  }
}

