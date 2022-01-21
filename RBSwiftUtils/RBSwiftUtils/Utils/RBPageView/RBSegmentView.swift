//
//  RBSegmentView.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/20.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit

class RBSegmentView: UIView {

    typealias buttonDidClickBlock = (Int)->Void
    var btnDidClick:buttonDidClickBlock!
    
    fileprivate var lastButton: UIButton?
    var segmentIndexColor: UIColor = .white
    var currentIndex: Int = 0
    
    init(frame: CGRect, segments: [UITabBarItem]) {
        super.init(frame: frame)
        self.addSubview(scrollView)
        self.addSubview(lineView)
        self.segments = segments
        
        updateChildViews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonH = 44.0
        let size = CGSize(width: 0, height: buttonH)
        
        var totalW = 0.0
        var buttonW = 0.0
        for (index, btn) in self.scrollView.subviews.enumerated() {
            let rect = ((btn as! UIButton).currentTitle! as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], context: nil)
            
            if index == 0 {
                buttonW = rect.width + 5.0 * 2
            }
            
            btn.frame = CGRect(x: totalW, y: 0, width: rect.size.width + 5.0 * 2, height: buttonH)
            totalW += (rect.size.width + 5.0 * 2)
        }
        
        if (totalW > UIScreen.main.bounds.width) {
            self.scrollView.contentSize = CGSize(width: totalW, height: buttonH);
        }

        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: buttonH)
        self.lineView.frame = CGRect(x: 0, y: buttonH - 4, width: buttonW, height: 4);
    }
    
    func updateSegmentIndexColor(newColor:UIColor) {
        self.segmentIndexColor = newColor
        self.lineView.backgroundColor = newColor
    }
    
    
    func updateCurrentIndex(newIndex: Int) {
        self.currentIndex = newIndex;
        let button:UIButton = self.scrollView.subviews[currentIndex] as! UIButton
        self.buttonChange(button: button)
    }
    
    fileprivate func updateChildViews() {
        self.scrollView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        for (index, item) in self.segments.enumerated() {
            createButton(title: item.title!, index: index)
        }
        
        lastButton = (self.scrollView.subviews.first as! UIButton)
        lastButton?.setTitleColor(.red, for: .normal)
    }
    
    fileprivate func createButton(title: String, index: Int) {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.tag = index
        button.addTarget(self, action: #selector(buttonDidClick(button:)), for: .touchUpInside)
        self.scrollView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: 🔥🔥🔥🔥🔥🔥action💧💧💧💧💧💧💧
    @objc func buttonDidClick(button: UIButton) {
        buttonChange(button: button)
        
        if self.btnDidClick != nil {
            self.btnDidClick(button.tag)
        }
    }
    
    fileprivate func buttonChange(button: UIButton) {
        lastButton?.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .normal)
        lastButton = button
        
        var rect = self.lineView.frame
        rect.origin.x = button.frame.origin.x
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.35) {
            weakSelf?.lineView.frame = rect
        }
        
    }
    
    // MARK: 🔥🔥🔥🔥🔥🔥lazy💧💧💧💧💧💧💧
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    fileprivate lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .red
        return lineView
    }()
    
    fileprivate lazy var segments: [UITabBarItem] = {
        let segments:[UITabBarItem] = []
        return segments
    }()
    
}
