//
//  UIColorEx.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/12.
//

import UIKit



extension UIColor {
    
    /**
        6 位颜色值
            let color: UIColor = .hex(0xFFAABB)
        8 位带透明度，设置透明度是 0xDD
            let color: UIColor = .hex(0xFFAABBDD)
        3 位颜色值
            let color: UIColor = .hex(0xFAB)
        4 位带透明度，设置透明度是 0xDD
            let color: UIColor = .hex(0xFABD)
     */
    static func hex(_ val: UInt) -> UIColor {
        var r: UInt = 0, g: UInt = 0, b: UInt = 0;
        var a: UInt = 0xFF
        var rgb = val

        if (val & 0xFFFF0000) == 0 {
            a = 0xF

            if val & 0xF000 > 0 {
                a = val & 0xF
                rgb = val >> 4
            }

            r = (rgb & 0xF00) >> 8
            r = (r << 4) | r

            g = (rgb & 0xF0) >> 4
            g = (g << 4) | g

            b = rgb & 0xF
            b = (b << 4) | b

            a = (a << 4) | a

        } else {
            if val & 0xFF000000 > 0 {
                a = val & 0xFF
                rgb = val >> 8
            }

            r = (rgb & 0xFF0000) >> 16
            g = (rgb & 0xFF00) >> 8
            b = rgb & 0xFF
        }

        return UIColor(red: CGFloat(r) / 255.0,
                       green: CGFloat(g) / 255.0,
                       blue: CGFloat(b) / 255.0,
                       alpha: CGFloat(a) / 255.0)
    }
}
