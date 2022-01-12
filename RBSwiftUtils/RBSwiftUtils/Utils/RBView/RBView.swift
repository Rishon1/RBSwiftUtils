//
//  RBView.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/12.
//  Copyright © 2022 RB. All rights reserved.
//

import UIKit

public struct CABorderMask : OptionSet {
    public var rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static var layerAllBorder = CABorderMask(rawValue: 1)

    public static var layerLeftBorder = CABorderMask(rawValue: 2)

    public static var layerRightBorder = CABorderMask(rawValue: 3)

    public static var layerTopBorder = CABorderMask(rawValue: 4)

    public static var layerBottomBorder = CABorderMask(rawValue: 5)
    
}

extension UIView {
    
    
    func updateLayBorders(_ layerBorders: [CABorderMask], borderColor: UIColor, borderWidth: CGFloat) {
        if layerBorders.contains(.layerAllBorder) {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
        else {
            
            if layerBorders.contains(.layerLeftBorder) {
                self.layer.addSublayer(self.addLineOriginPoint(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: self.frame.size.height), color: borderColor, borderWidth: borderWidth))
            }
            
            if layerBorders.contains(.layerTopBorder) {
                self.layer.addSublayer(self.addLineOriginPoint(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: self.frame.size.width, y: 0), color: borderColor, borderWidth: borderWidth))
            }
            
            if layerBorders.contains(.layerRightBorder) {
                self.layer.addSublayer(self.addLineOriginPoint(startPoint: CGPoint(x: self.frame.size.width, y: 0), endPoint: CGPoint(x: self.frame.size.width, y: self.frame.size.height), color: borderColor, borderWidth: borderWidth))
            }
            if layerBorders.contains(.layerBottomBorder) {
                self.layer.addSublayer(self.addLineOriginPoint(startPoint: CGPoint(x: 0, y: self.frame.size.height), endPoint: CGPoint(x: self.frame.size.width, y: self.frame.size.height), color: borderColor, borderWidth: borderWidth))
            }
        }
    }
    
    func addLineOriginPoint(startPoint: CGPoint, endPoint: CGPoint, color: UIColor, borderWidth: CGFloat) -> CAShapeLayer{
        let bezierPath = UIBezierPath()
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        //添加路径
        shapeLayer.path = bezierPath.cgPath
        //添加线宽
        shapeLayer.lineWidth = borderWidth
        
        return shapeLayer
    }
    
}
