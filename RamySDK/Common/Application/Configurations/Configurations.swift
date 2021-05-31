//
//  Configurations.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/16/20\.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

typealias Spacing = Configurations.UI.Spacing
typealias Pin = Configurations.UI.Pin
typealias QuickLinks = Configurations.UI.QuickLinks
typealias TransactionHistories = Configurations.UI.TransactionHistories
typealias Profile = Configurations.UI.Profile
typealias FontSize = Configurations.UI.FontSize
typealias Font = Configurations.UI.Font
typealias DoubleRepresentation = Configurations.Business.DoubleRepresentation
typealias OTPTimer = Configurations.Business.OTPTimer
typealias BiometricTimer = Configurations.Business.BiometricTimer
typealias Fields = Configurations.UI.Fields

enum Configurations {
  
  enum Business {
    enum DoubleRepresentation {
      public static var minimumFractionDigits = 2
    }
    
    enum OTPTimer {
      public static var interval: Double = 8
    }
    
    enum BiometricTimer {
      public static var interval: Double = 60 * 5
    }
  }
  
  enum UI {
    enum Spacing {
      /// 4
      public static var p05: CGFloat = 4
      /// 8
      public static var p1: CGFloat = 8
      /// 16
      public static var p2: CGFloat = 16
      /// 24
      public static var p3: CGFloat = 24
      
      public static var scrollViewBottomPadding: CGFloat = 65
      
      enum Specific {
        public static var homeSpacingBetweenHeaderAndContent: CGFloat = 75
      }
    }
    
    enum Pin {
      public static var length: Int = 6
      public static var interSpace: CGFloat = 5
      public static var borderThickness: CGFloat = 1
      public static var activeBorderThickness: CGFloat = 3
      public static var activeCornerRadius: CGFloat = 8
      public static var cornerRadius: CGFloat = 8
      public static var placeholder: String = "••••••"
      public static var font: UIFont = FontFactory.getLocalizedFont(.bold, 15)
    }
    
    enum QuickLinks {
      public static var height: CGFloat = 80
      public static var iconSize: CGSize = .init(width: 25, height: 25)
    }
    
    enum TransactionHistories {
      public static var height: CGFloat = 50
    }
    
    enum Profile {
      public static var pictureSize: CGSize = CGSize(width: 150, height: 150)
    }
    
    enum RequestFromCard {
      public static var cornerRadius: CGFloat = 16
    }
    
    enum FontSize {
      /// 34
      public static var largeTitle: CGFloat = 34
      /// 28
      public static var title1: CGFloat = 28
      /// 22
      public static var title2: CGFloat = 22
      /// 20
      public static var title3: CGFloat = 20
      /// 17
      public static var headline: CGFloat = 17
      /// 15
      public static var subheadline: CGFloat = 15
      /// 17
      public static var body: CGFloat = 17
      /// 16
      public static var callout: CGFloat = 16
      /// 13
      public static var footnote: CGFloat = 13
      /// 12
      public static var caption1: CGFloat = 12
      /// 11
      public static var caption2: CGFloat = 11
    }
    
    enum Font {
      /// (.regular, 34)
      public static var largeTitle: UIFont = FontFactory.getLocalizedFont(.regular, 34)
      /// (.regular, 28)
      public static var title1: UIFont = FontFactory.getLocalizedFont(.regular, 28)
      /// (.regular, 22)
      public static var title2: UIFont = FontFactory.getLocalizedFont(.bold, 22)
      /// (.regular, 20)
      public static var title3: UIFont = FontFactory.getLocalizedFont(.regular, 20)
      /// (.semiBold, 17)
      public static var headline: UIFont = FontFactory.getLocalizedFont(.semiBold, 17)
      /// (.regular, 15)
      public static var subheadline: UIFont = FontFactory.getLocalizedFont(.regular, 15)
      /// (.regular, 17)
      public static var body: UIFont = FontFactory.getLocalizedFont(.regular, 17)
      /// (.regular, 16)
      public static var callout: UIFont = FontFactory.getLocalizedFont(.regular, 16)
      /// (.regular, 13)
      public static var footnote: UIFont = FontFactory.getLocalizedFont(.regular, 13)
      /// (.regular, 12)
      public static var caption1: UIFont = FontFactory.getLocalizedFont(.regular, 12)
      /// (.regular, 11)
      public static var caption2: UIFont = FontFactory.getLocalizedFont(.regular, 11)
    }
    
    enum Fields {
      public static let cornerRadius: CGFloat = 8
      public static let borderWidth: CGFloat = 1
    }
  }
}
