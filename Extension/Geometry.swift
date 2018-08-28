//
//  Geometry.swift
//  cnotethegr8
//
//  Created by Corey Werner on 10/22/17.
//  Copyright © 2017 cnotethegr8. All rights reserved.
//

import UIKit

extension CGFloat {
    private static func x(is320w: CGFloat, is375w: CGFloat, isGreater: CGFloat) -> CGFloat {
        if UIDevice.current.is320w {
            return is320w
        }
        else if UIDevice.current.is375w {
            return is375w
        }
        else {
            return isGreater
        }
    }
    
    private static func y(is480h: CGFloat, is568h: CGFloat, is667h: CGFloat, isGreater: CGFloat) -> CGFloat {
        if UIDevice.current.is480h {
            return is480h
        }
        else if UIDevice.current.is568h {
            return is568h
        }
        else if UIDevice.current.is667h {
            return is667h
        }
        else {
            return isGreater
        }
    }
    
    private static func space(_ baseSpace: CGFloat) -> CGFloat {
        return y(is480h: baseSpace, is568h: baseSpace * 1.2, is667h: baseSpace * 1.4, isGreater: baseSpace * 1.6)
    }
    
    static let containerPaddingX = x(is320w: 20, is375w: 28, isGreater: 32)
    static let containerPaddingY = y(is480h: 20, is568h: 24, is667h: 28, isGreater: 32)
    
    static let marginX = x(is320w: 10, is375w: 16, isGreater: 22)
    static let marginY = y(is480h: 10, is568h: 12, is667h: 16, isGreater: 22)
    
    static let space1 = space(10)
    static let space2 = space(15)
    static let space3 = space(20)
    static let space4 = space(25)
    static let space5 = space(30)
    
    static let halfPoint: CGFloat = UIScreen.main.scale > 1 ? 0.5 : 1
    
    static let defaultCornerRadius: CGFloat = 6
    static let defaultViewHeight: CGFloat = 44
}

extension CGSize {
    func aspectFitRectInSize(_ size: CGSize) -> CGRect {
        let scale = min(size.width / width, size.height / height)
        let scaledSize = CGSize(width: width * scale, height: height * scale)
        
        var rect: CGRect = .zero
        rect.origin.x = round((size.width - scaledSize.width) * 0.5)
        rect.origin.y = round((size.height - scaledSize.height) * 0.5)
        rect.size.width = round(scaledSize.width)
        rect.size.height = round(scaledSize.height)
        return rect
    }
}
