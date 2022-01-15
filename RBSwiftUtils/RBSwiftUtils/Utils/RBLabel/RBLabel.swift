//
//  RBLabel.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/15.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit

class RBLabel: UIView {
    
    @IBInspectable var text: String {
        get {
            return self.titleLabel.text ?? ""
        }
        set(newText) {
            self.titleLabel.text = newText
            
            let size = (newText as NSString).boundingRect(with: CGSize(width: 0, height: self.bounds.height), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : self.font], context: nil)
            
            var frame = self.frame
            frame.size.width = size.width + 2 * self.paddingSpace
            self.frame = frame
            self.titleLabel.frame = CGRect(x: paddingSpace, y: 0, width: size.width, height: frame.height)
        }
    }
    
    @IBInspectable var textColor: UIColor {
        get {
            return self.titleLabel.textColor
        }
        set(newColor) {
            self.titleLabel.textColor = newColor
        }
    }
    
    @IBInspectable var font: UIFont {
        get {
            return self.titleLabel.font
        }
        set(newFont) {
            self.titleLabel.font = newFont
        }
    }
    
    
    
    

    fileprivate var paddingSpace = 0.0
    
    init(_ frame: CGRect, paddingSpace: CGFloat) {
        super.init(frame: frame)
        
        self.paddingSpace = paddingSpace
        
        self.addSubview(self.titleLabel)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .black
        return titleLabel
    }()

}
