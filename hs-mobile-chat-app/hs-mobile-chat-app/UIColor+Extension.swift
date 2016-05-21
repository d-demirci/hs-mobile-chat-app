//
//  UIImage+Extension.swift
//  hs-mobile-chat-app
//
//  Created by Matheus Ruschel on 5/21/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    static func colorWith(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
    
    static func hsBlueColor() -> UIColor
    {
        return UIColor(netHex: 0x3bacde)
    }
    
    static func hsGreenColor() -> UIColor
    {
        return UIColor(netHex: 0x90c553)
    }
    
    static func hsBlackColor() -> UIColor
    {
        return UIColor(netHex: 0x333333)
    }
    static func hsWhiteColor() -> UIColor
    {
        return UIColor(netHex: 0xf3f3f3)
    }
    static func hsGrayColor() -> UIColor
    {
        return UIColor(netHex: 0xcccccc)
    }
    
    
    
    
    
    
    
}