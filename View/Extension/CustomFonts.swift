//
//  CustomFonts.swift
//  cnotethegr8
//
//  Created by Corey Werner on 3/16/18.
//  Copyright © 2018 cnotethegr8. All rights reserved.
//

import UIKit

extension UIFontTextStyle {
    static let largeTitle = UIFontTextStyle("UICTFontTextStyleTitle0")
}

extension UIFont {
    enum CustomFontName: String {
        case dinCondensedBold = "DINCondensed-Bold"
        
        case futura       = "Futura"
        case futuraMedium = "Futura-Medium"
        case futuraBold   = "Futura-Bold"
        
        case hindLight    = "Hind-Light"
        case hind         = "Hind-Regular"
        case hindMedium   = "Hind-Medium"
        case hindSemibold = "Hind-SemiBold"
        case hindBold     = "Hind-Bold"
        
        case quicksandLight  = "Quicksand-Light"
        case quicksand       = "Quicksand-Regular"
        case quicksandMedium = "Quicksand-Medium"
        case quicksandBold   = "Quicksand-Bold"
        
        var symbolicTraits: UIFontDescriptorSymbolicTraits {
            switch self {
            case .dinCondensedBold:
                return [.traitBold, .traitCondensed]
                
            case .futuraMedium, .futuraBold,
                 .hindMedium, .hindSemibold, .hindBold,
                 .quicksandMedium, .quicksandBold:
                return [.traitBold]
                
            default:
                return []
            }
        }
        
        var weight: UIFont.Weight {
            switch self {
            case .hindLight,
                 .quicksandLight:
                return UIFont.Weight.light
                
            case .futura,
                 .hind,
                 .quicksand:
                return UIFont.Weight.regular
                
            case .futuraMedium,
                 .hindMedium,
                 .quicksandMedium:
                return UIFont.Weight.medium
                
            case .hindSemibold:
                return UIFont.Weight.semibold
                
            case .dinCondensedBold,
                 .futuraBold,
                 .hindBold,
                 .quicksandBold:
                return UIFont.Weight.bold
            }
        }
    }
    
    var customFontName: CustomFontName? {
        return CustomFontName(rawValue: fontName)
    }
    
    static private let sizeMap: [UIFontTextStyle: CGFloat] = [
        .largeTitle:  38, // Does not adjust for content size category!
        .title1:      34,
        .title2:      28,
        .title3:      22,
        .headline:    20,
        .subheadline: 18,
        .body:        17,
        .callout:     16,
        .footnote:    13,
        .caption1:    12,
        .caption2:    11
    ]
    
    convenience init?(customName: CustomFontName, size: CGFloat) {
        self.init(name: customName.rawValue, size: size)
    }
    
    static func preferredFont(forTextStyle textStyle: UIFontTextStyle, symbolicTraits: UIFontDescriptorSymbolicTraits) -> UIFont {
        var textStyle = textStyle
        
        if #available(iOS 11.0, *) {} else {
            if textStyle == .largeTitle {
                textStyle = .title1
            }
        }
        
        var font = UIFont.preferredFont(forTextStyle: textStyle)
        
        if let descriptor = font.fontDescriptor.withSymbolicTraits(symbolicTraits) {
            font = UIFont(descriptor: descriptor, size: 0)
        }
        
        return font
    }
    
    static func customFont(_ name: CustomFontName, textStyle: UIFontTextStyle, staticSize: Bool = false) -> UIFont {
        if let size = sizeMap[textStyle], let font = UIFont(customName: name, size: size) {
            if staticSize {
                return font
            }
            else if #available(iOS 11.0, *) {
                return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
            }
        }
        
        return .preferredFont(forTextStyle: textStyle, symbolicTraits: name.symbolicTraits)
    }
    
    static func customFont(_ name: CustomFontName, size: CGFloat) -> UIFont {
        return UIFont(customName: name, size: size) ?? UIFont.systemFont(ofSize: size, weight: name.weight)
    }
}
