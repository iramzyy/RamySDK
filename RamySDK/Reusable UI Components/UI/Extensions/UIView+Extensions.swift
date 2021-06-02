//
//  UIView+Extensions.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
  func roundCornersWithMask(_ corners: CACornerMask, radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.maskedCorners = corners
  }
  
  var safeArea: ConstraintBasicAttributesDSL {
      
      #if swift(>=3.2)
          if #available(iOS 11.0, *) {
              return self.safeAreaLayoutGuide.snp
          }
          return self.snp
      #else
          return self.snp
      #endif
  }
  
  class func spacingView(height: CGFloat? = nil) -> UIView {
    let view = UIView()
    view.isUserInteractionEnabled = false
    view.setContentHuggingPriority(.rawValue(249), for: .horizontal)
    view.setContentHuggingPriority(.rawValue(249), for: .vertical)
    view.backgroundColor = .clear

    if let height = height { view.snp.makeConstraints { $0.height.equalTo(height) } }
    
    return view
  }
  
  class func separatorView() -> UIView {
    let view = UIView()
    view.isUserInteractionEnabled = false
    view.backgroundColor = .red
    view.cornerRadius = Dimensions.Separator.cornerRadius
    view.snp.makeConstraints { $0.height.equalTo(Dimensions.Separator.height) }
    
    return view
  }
  
  func fillSuperview() {
    snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func asImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    return renderer.image { rendererContext in
      layer.render(in: rendererContext.cgContext)
    }
  }
  
  /// Closest thing to Sketch's Shadow
  public func addSketchShadow(ofColor color: UIColor = UIColor(hexString: "637381") ?? .red, radius: CGFloat = 10, offset: CGSize = .init(width: 0, height: 4), opacity: Float = 0.1, spread: CGFloat = 0) {
    layer.applySketchShadow(color: color, alpha: opacity, x: offset.width, y: offset.height, blur: radius, spread: spread)
  }
  
  public func embedInShadowView() -> UIView {
    return UIView().then {
      $0.addSubview(self)
      self.fillSuperview()
      $0.addSketchShadow()
    }
  }
  
  @discardableResult
  public func addBlur(style: UIBlurEffect.Style = .extraLight) -> UIVisualEffectView {
      let blurEffect = UIBlurEffect(style: style)
      let blurBackground = UIVisualEffectView(effect: blurEffect)
      addSubview(blurBackground)
      blurBackground.translatesAutoresizingMaskIntoConstraints = false
      blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
      blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
      blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
      return blurBackground
  }
}

extension CACornerMask {
    public static var topLeading: CACornerMask { return .layerMinXMinYCorner }

    public static var topTrailing: CACornerMask { return .layerMaxXMinYCorner }

    public static var bottomLeading: CACornerMask { return .layerMinXMaxYCorner }

    public static var bottomTrailing: CACornerMask { return .layerMaxXMaxYCorner }
}

public extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
// MARK: - Property Storing

extension UIView: PropertyStoring {
  private struct StoredProperties {
    static var leftBorder: UIView?
    static var rightBorder: UIView?
    static var topBorder: UIView?
    static var bottomBorder: UIView?
  }
}

// MARK: - Borders

public extension UIView {
  enum ViewSide {
    case left
    case right
    case top
    case bottom

    init(name: String) {
      switch name {
      case "top-dashed-line": self = .top
      case "bottom-dashed-line": self = .bottom
      default:
        assertionFailure("Unhandled Edge Name: \(name)")
        self = .top
      }
    }
  }

  var leftBorder: UIView? {
    get {
      return getAssociatedObject(&StoredProperties.leftBorder, defaultValue: nil)
    }
    set {
      objc_setAssociatedObject(self, &StoredProperties.leftBorder, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  var rightBorder: UIView? {
    get {
      return getAssociatedObject(&StoredProperties.rightBorder, defaultValue: nil)
    }
    set {
      objc_setAssociatedObject(self, &StoredProperties.rightBorder, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  var topBorder: UIView? {
    get {
      return getAssociatedObject(&StoredProperties.topBorder, defaultValue: nil)
    }
    set {
      objc_setAssociatedObject(self, &StoredProperties.topBorder, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  var bottomBorder: UIView? {
    get {
      return getAssociatedObject(&StoredProperties.bottomBorder, defaultValue: nil)
    }
    set {
      objc_setAssociatedObject(self, &StoredProperties.bottomBorder, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  func removeBorder(_ sides: ViewSide...) {
    for side in sides {
      switch side {
      case .left:
        leftBorder?.removeFromSuperview()
      case .right:
        rightBorder?.removeFromSuperview()
      case .top:
        topBorder?.removeFromSuperview()
      case .bottom:
        bottomBorder?.removeFromSuperview()
      }
    }
  }

  func addBorder(_ sides: ViewSide..., color: UIColor, thickness: CGFloat, offset: UIEdgeInsets = .zero) {
    func addTopBorder() {
      removeBorder(.top)

      let border = UIView()
      border.backgroundColor = color
      topBorder = border
      addSubview(topBorder!)

      topBorder!.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(offset.top)
        make.leading.equalTo(offset.left)
        make.trailing.equalTo(-offset.right)
        make.height.equalTo(thickness)
      }
    }

    func addBottomBorder() {
      removeBorder(.bottom)

      let border = UIView()
      border.backgroundColor = color
      bottomBorder = border
      addSubview(bottomBorder!)

      bottomBorder!.snp.makeConstraints { make in
        make.leading.equalTo(offset.left)
        make.trailing.equalTo(-offset.right)
        make.height.equalTo(thickness)
        make.bottom.equalToSuperview().offset(-offset.bottom)
      }
    }

    func addLeftBorder() {
      removeBorder(.left)

      let border = UIView()
      border.backgroundColor = color
      leftBorder = border
      addSubview(leftBorder!)

      leftBorder!.snp.makeConstraints { make in
        make.leading.equalTo(offset.left)
        make.width.equalTo(thickness)
        make.top.equalToSuperview().offset(offset.top)
        make.bottom.equalToSuperview().offset(-offset.bottom)
      }
    }

    func addRightBorder() {
      removeBorder(.right)

      let border = UIView()
      border.backgroundColor = color
      rightBorder = border
      addSubview(rightBorder!)

      rightBorder!.snp.makeConstraints { make in
        make.trailing.equalTo(-offset.right)
        make.width.equalTo(thickness)
        make.top.equalToSuperview().offset(offset.top)
        make.bottom.equalToSuperview().offset(-offset.bottom)
      }
    }

    for side in sides {
      switch side {
      case .left:
        addLeftBorder()
      case .right:
        addRightBorder()
      case .top:
        addTopBorder()
      case .bottom:
        addBottomBorder()
      }
    }
  }
}

// MARK: - Subviews
extension UIView {
  func searchVisualEffectsSubview() -> UIVisualEffectView? {
    if let visualEffectView = self as? UIVisualEffectView {
      return visualEffectView
    } else {
      for subview in subviews {
        if let found = subview.searchVisualEffectsSubview() {
          return found
        }
      }
    }
    return nil
  }

  /// This is the function to get subViews of a view of a particular type
  /// https://stackoverflow.com/a/45297466/5321670
  func subViews<T: UIView>(type: T.Type) -> [T] {
    var all = [T]()
    for view in subviews {
      if let aView = view as? T {
        all.append(aView)
      }
    }
    return all
  }

  /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
  /// https://stackoverflow.com/a/45297466/5321670
  func allSubViewsOf<T: UIView>(type: T.Type) -> [T] {
    var all = [T]()
    func getSubview(view: UIView) {
      if let aView = view as? T {
        all.append(aView)
      }
      guard !view.subviews.isEmpty else { return }
      view.subviews.forEach { getSubview(view: $0) }
    }
    getSubview(view: self)
    return all
  }
}

// MARK: - Animations

public extension UIView {

  func removeFromSuperViewWithAnimation(with duration: TimeInterval, execute: @escaping (UIView) -> Void, completion: @escaping VoidCallback) {
    UIView.animate(withDuration: duration, animations: {
      execute(self)
    }) { _ in
      self.removeFromSuperview()
      completion()
    }
  }
}


// MARK: - Layout

public enum HuggingPriority: Float {
  case standard = 250
  case moreThanStandard = 251
  case lessThanStandard = 249
  case required = 999
  case must = 1000
}

public enum ResistancePriority: Float {
  case standard = 750
  case moreThanStandard = 751
  case lessThanStandard = 749
  case required = 999
  case must = 1000
}

public extension UIView {

  enum Hugging {
    case vertical(HuggingPriority)
    case horizontal(HuggingPriority)
    case both(HuggingPriority)
  }

  enum Resistance {
    case vertical(ResistancePriority)
    case horizontal(ResistancePriority)
    case both(ResistancePriority)
  }

  func setContentHuggingPriorityCustom(_ hugging: Hugging) {
    switch hugging {
    case .vertical(let value):
      setContentHuggingPriority(.rawValue(value.rawValue), for: .vertical)
    case .horizontal(let value):
      setContentHuggingPriority(.rawValue(value.rawValue), for: .horizontal)
    case .both(let value):
      setContentHuggingPriority(.rawValue(value.rawValue), for: .horizontal)
      setContentHuggingPriority(.rawValue(value.rawValue), for: .vertical)
    }
  }

  func setContentResistancePriorityCustom(_ resistance: Resistance) {
    switch resistance {
    case .vertical(let value):
      setContentCompressionResistancePriority(.rawValue(value.rawValue), for: .vertical)
    case .horizontal(let value):
      setContentCompressionResistancePriority(.rawValue(value.rawValue), for: .horizontal)
    case .both(let value):
      setContentCompressionResistancePriority(.rawValue(value.rawValue), for: .horizontal)
      setContentCompressionResistancePriority(.rawValue(value.rawValue), for: .vertical)
    }
  }
}

// MARK: - Animations
extension UIView {

  func fadeIn() {
    fadeTo(alpha: 1)
  }

  func fadeOut() {
    fadeTo(alpha: 0)
  }
  
  func fadeTo(duration: Double = 0, alpha: CGFloat) {
    UIView.animate(withDuration: duration) {
      self.alpha = alpha
    }
  }
  
}

// MARK:- Draw dashed line
extension UIView {
  func drawDashedLine(on viewSide: ViewSide, color: UIColor, dashLength: NSNumber = 7, gapLength: NSNumber = 7) {
    let shapeLayer = CAShapeLayer()
    shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = 5
    shapeLayer.lineDashPattern = [dashLength, gapLength]

    switch viewSide {
    case .top:
      let p0 = CGPoint(x: 0, y: self.bounds.minY)
      let p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.minY)
      let path = CGMutablePath()
      path.addLines(between: [p0, p1])
      shapeLayer.path = path
      shapeLayer.name = "top-dashed-line"
    case .bottom:
      let p0 = CGPoint(x: 0, y: self.bounds.maxY)
      let p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
      let path = CGMutablePath()
      path.addLines(between: [p0, p1])
      shapeLayer.path = path
      shapeLayer.name = "bottom-dashed-line"

    default: break
    }
    self.layer.addSublayer(shapeLayer)
  }
}
