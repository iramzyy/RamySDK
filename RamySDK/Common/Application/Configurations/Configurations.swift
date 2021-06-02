//
//  Configurations.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public typealias Spacing = Configurations.UI.Spacing
public typealias Pin = Configurations.UI.Pin
public typealias Profile = Configurations.UI.Profile
public typealias FontStyles = Configurations.UI.FontStyles
public typealias DoubleRepresentation = Configurations.Business.DoubleRepresentation
public typealias OTPTimer = Configurations.Business.OTPTimer
public typealias BiometricTimer = Configurations.Business.BiometricTimer
public typealias Fields = Configurations.UI.Fields

public enum Configurations {
  
  public enum Business {
    public enum DoubleRepresentation {
      public static var minimumFractionDigits = 2
    }
    
    public enum OTPTimer {
      public static var interval: Double = 8
    }
    
    public enum BiometricTimer {
      public static var interval: Double = 60 * 5
    }
  }
  
  public enum UI {
    public enum Spacing {
      /// 4
      public static var p05: CGFloat = 4
      /// 8
      public static var p1: CGFloat = 8
      /// 16
      public static var p2: CGFloat = 16
      /// 24
      public static var p3: CGFloat = 24
      
      public static var scrollViewBottomPadding: CGFloat = 65
      
      public enum Specific {
        public static var homeSpacingBetweenHeaderAndContent: CGFloat = 75
      }
    }
    
    public enum Pin {
      public static var length: Int = 6
      public static var interSpace: CGFloat = 5
      public static var borderThickness: CGFloat = 1
      public static var activeBorderThickness: CGFloat = 3
      public static var activeCornerRadius: CGFloat = 8
      public static var cornerRadius: CGFloat = 8
      public static var placeholder: String = "••••••"
      //      public static var font: Font = FontFactory.getLocalizedFont(.bold, 15)
    }
    
    public enum QuickLinks {
      public static var height: CGFloat = 80
      public static var iconSize: CGSize = .init(width: 25, height: 25)
    }
    
    public enum TransactionHistories {
      public static var height: CGFloat = 50
    }
    
    public enum Profile {
      public static var pictureSize: CGSize = CGSize(width: 150, height: 150)
    }
    
    public enum RequestFromCard {
      public static var cornerRadius: CGFloat = 16
    }
    
    public enum FontStyles {
      public static var largeTitle: Font = FontManager.shared.getSuitableFont(category: .display, scale: .huge, weight: .regular)
      public static var title1: Font = FontManager.shared.getSuitableFont(category: .display, scale: .large, weight: .regular)
      public static var title2: Font = FontManager.shared.getSuitableFont(category: .display, scale: .medium, weight: .regular)
      public static var title3: Font = FontManager.shared.getSuitableFont(category: .display, scale: .small, weight: .regular)
      public static var headline: Font = FontManager.shared.getSuitableFont(category: .text, scale: .large, weight: .regular)
      public static var subheadline: Font = FontManager.shared.getSuitableFont(category: .text, scale: .medium, weight: .regular)
      public static var body: Font = FontManager.shared.getSuitableFont(category: .text, scale: .small, weight: .regular)
      public static var callout: Font = FontManager.shared.getSuitableFont(category: .text, scale: .xsmall, weight: .regular)
      public static var footnote: Font = FontManager.shared.getSuitableFont(category: .link, scale: .large, weight: .bold)
      public static var caption1: Font = FontManager.shared.getSuitableFont(category: .link, scale: .medium, weight: .bold)
      public static var caption2: Font = FontManager.shared.getSuitableFont(category: .link, scale: .small, weight: .bold)
      public static var caption3: Font = FontManager.shared.getSuitableFont(category: .link, scale: .xsmall, weight: .bold)
    }
    
    public enum Fields {
      public static let cornerRadius: CGFloat = 8
      public static let borderWidth: CGFloat = 1
    }
  }
}
