//
//  RBAlertView.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/12.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit

class RBAlertView: UIView {
    
    typealias RBAlertViewBlock = ()->Void
    var cancelBlock:RBAlertViewBlock!
    
    var confirmBlock:RBAlertViewBlock!
    
    
    init(_ title: String,
         _ message: String,
         cancelTitle: String?,
         confirmTitle: String?) {
        super.init(frame: UIScreen.main.bounds)
        createContentView()
        //标题
        let titleHeight = createTitleLabel(title: title)
        //信息
        let messageHeight = createMessageLabel(message: message, titlePart: titleHeight)
        
        let btnViewHeight = createBtnView(messageHeight:messageHeight, cancelTitle: cancelTitle, confirmTitle: confirmTitle)
        
        self.contentView.frame = CGRect(x: alertViewX, y: (ScreenHeight() - btnViewHeight) / 2.0 , width: alertWidth, height: btnViewHeight)
        
    }
    
    init(_ title: String,
         _ message: String,
         cancelTitle: String?,
         confirmTitle: String?,
         confirmBlock: RBAlertViewBlock?,
         cancelBlock: RBAlertViewBlock?) {
        super.init(frame: UIScreen.main.bounds)
        createContentView()
        
        //标题
        let titleHeight = createTitleLabel(title: title)
        //信息
        let messageHeight = createMessageLabel(message: message, titlePart: titleHeight)
        
        let btnViewHeight = createBtnView(messageHeight:messageHeight, cancelTitle: cancelTitle, confirmTitle: confirmTitle)
        
        self.contentView.frame = CGRect(x: alertViewX, y: (ScreenHeight() - btnViewHeight) / 2.0 , width: alertWidth, height: btnViewHeight)
        
        self.confirmBlock = confirmBlock
        self.cancelBlock = cancelBlock
        
    }
    
    init(_ attrTitle: NSAttributedString,
         _ message: String,
         cancelTitle: String?,
         confirmTitle: String?,
         confirmBlock: RBAlertViewBlock?,
         cancelBlock: RBAlertViewBlock?) {
        super.init(frame: UIScreen.main.bounds)
        createContentView()
        
        //标题
        let titleHeight = createAttrTitleLabel(attrTitle: attrTitle)
        //信息
        let messageHeight = createMessageLabel(message: message, titlePart: titleHeight)
        
        let btnViewHeight = createBtnView(messageHeight:messageHeight, cancelTitle: cancelTitle, confirmTitle: confirmTitle)
        
        self.contentView.frame = CGRect(x: alertViewX, y: (ScreenHeight() - btnViewHeight) / 2.0 , width: alertWidth, height: btnViewHeight)
        
        self.confirmBlock = confirmBlock
        self.cancelBlock = cancelBlock
        
    }
    
    init(_ attrTitle: NSAttributedString,
         _ attrMessage: NSAttributedString,
         cancelTitle: String?,
         confirmTitle: String?,
         confirmBlock: RBAlertViewBlock?,
         cancelBlock: RBAlertViewBlock?) {
        super.init(frame: UIScreen.main.bounds)
        createContentView()
        
        //标题
        let titleHeight = createAttrTitleLabel(attrTitle: attrTitle)
        //信息
        let messageHeight = createAttrMessageLabel(attrMessage: attrMessage, titlePart: titleHeight)
        
        let btnViewHeight = createBtnView(messageHeight:messageHeight, cancelTitle: cancelTitle, confirmTitle: confirmTitle)
        
        self.contentView.frame = CGRect(x: alertViewX, y: (ScreenHeight() - btnViewHeight) / 2.0 , width: alertWidth, height: btnViewHeight)
        
        self.confirmBlock = confirmBlock
        self.cancelBlock = cancelBlock
        
    }
    
    init(_ title: String,
         _ attrMessage: NSAttributedString,
         cancelTitle: String?,
         confirmTitle: String?,
         confirmBlock: RBAlertViewBlock?,
         cancelBlock: RBAlertViewBlock?) {
        super.init(frame: UIScreen.main.bounds)
        createContentView()
        
        //标题
        let titleHeight = createTitleLabel(title: title)
        
        //信息
        let messageHeight = createAttrMessageLabel(attrMessage: attrMessage, titlePart: titleHeight)
        
        let btnViewHeight = createBtnView(messageHeight:messageHeight, cancelTitle: cancelTitle, confirmTitle: confirmTitle)
        
        self.contentView.frame = CGRect(x: alertViewX, y: (ScreenHeight() - btnViewHeight) / 2.0 , width: alertWidth, height: btnViewHeight)
        
        self.confirmBlock = confirmBlock
        self.cancelBlock = cancelBlock
        
    }
    
    init(contextView: UIView,
         cancelTitle: String?,
         confirmTitle: String?,
         confirmBlock: RBAlertViewBlock?,
         cancelBlock: RBAlertViewBlock?) {
        super.init(frame: UIScreen.main.bounds)
        createContentView()
        
        self.contentView.addSubview(contextView)
        contextView.frame = CGRect(origin: contextView.frame.origin, size: CGSize(width: alertWidth, height: contextView.frame.height))
        
        let btnViewHeight = createBtnView(messageHeight:contextView.frame.maxY, cancelTitle: cancelTitle, confirmTitle: confirmTitle)
        
        self.contentView.frame = CGRect(x: alertViewX, y: (ScreenHeight() - btnViewHeight) / 2.0 , width: alertWidth, height: btnViewHeight)
        
        self.confirmBlock = confirmBlock
        self.cancelBlock = cancelBlock
        
    }
    
    
    func show() {
        UIView.animate(withDuration: 0.3) {
            self.bgView.alpha = 0.5
        }
        self.addToSuperview()
        self.contentView.springingAnimation()
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.5) {
            //self.contentView.center = CGPoint(x: self.frame.midX, y: self.frame.midY + 40)
            self.bgView.alpha = 0.0
            self.contentView.alpha = 0.0
        } completion: { finished in
            self.removeFromSuperview()
        }
    }
    // MARK: 🔥🔥🔥🔥🔥🔥添加背景视图💧💧💧💧💧💧💧
    fileprivate func createContentView()
    {
        self.addSubview(self.bgView)
        self.addSubview(self.contentView)
    }
    
    /// 标题
    fileprivate func createTitleLabel(title: String) -> CGFloat {
        self.contentView.addSubview(titleLabel)
        
        let  titleWidth = alertWidth - 10
        
        let height = height(title as NSString, fontSize: titleLabel.font, width: titleWidth)
        
        titleLabel.frame = CGRect(x: 5, y: 10, width: titleWidth, height: height)
        
        titleLabel.text = title
        
        return titleLabel.frame.maxY
    }
    
    /// 富文本标题
    fileprivate func createAttrTitleLabel(attrTitle: NSAttributedString) -> CGFloat {
        self.contentView.addSubview(titleLabel)
        
        let  titleWidth = alertWidth - 10
        
        let height = height(attrTitle, width: titleWidth)
        
        titleLabel.frame = CGRect(x: 5, y: 10, width: titleWidth, height: height)
        
        titleLabel.attributedText = attrTitle
        
        return titleLabel.frame.maxY
    }
    
    /// 信息message
    fileprivate func createMessageLabel(message: String, titlePart: CGFloat) -> CGFloat {
        self.contentView.addSubview(messageLabel)
        
        let  titleWidth = alertWidth - 10
        let height = height(message as NSString, fontSize: messageLabel.font, width: titleWidth)
        
        messageLabel.frame = CGRect(x: 5, y: titlePart + 15, width: titleWidth, height: height)
        
        messageLabel.text = message
        
        return messageLabel.frame.maxY
    }
    
    fileprivate func createAttrMessageLabel(attrMessage: NSAttributedString, titlePart: CGFloat) -> CGFloat {
        self.contentView.addSubview(messageLabel)
        
        let  titleWidth = alertWidth - 10
        let height = height(attrMessage, width: titleWidth)
        
        messageLabel.frame = CGRect(x: 5, y: titlePart + 15, width: titleWidth, height: height)
        
        messageLabel.attributedText = attrMessage
        
        return messageLabel.frame.maxY
    }
    
    fileprivate func createBtnView(messageHeight: CGFloat,
                                   cancelTitle: String?,
                                   confirmTitle: String?) -> CGFloat
    {
        var btnArray:[UIButton] = []
        
        if cancelTitle != nil && cancelTitle!.count > 0 {
            self.contentView.addSubview(cancelBtn)
            cancelBtn.setTitle(cancelTitle, for: .normal)
            btnArray.append(cancelBtn)
        }
        if confirmTitle != nil && confirmTitle!.count > 0 {
            self.contentView.addSubview(confirmBtn)
            confirmBtn.setTitle(confirmTitle, for: .normal)
            btnArray.append(confirmBtn)
        }
        
        if btnArray.count > 0 {
            let btnWidth = alertWidth / CGFloat(btnArray.count)
            var i = 0
            btnArray.forEach { btn in
                btn.frame = CGRect(x: btnWidth * CGFloat(i), y: messageHeight + 10, width: btnWidth, height: 45.0)
                i += 1
            }
            
            return btnArray.first!.frame.maxY
        }
        else {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.dismiss()
            }
            
            return messageHeight + 15
        }
    }
    
    // MARK: 🔥🔥🔥🔥🔥🔥action💧💧💧💧💧💧💧
    @objc func cancelBtnDidClick() {
        dismiss()
        
        if self.cancelBlock != nil {
            self.cancelBlock()
        }
    }
    
    @objc func confirmBtnDidClick() {
        dismiss()
        
        if self.confirmBlock != nil {
            self.confirmBlock()
        }
    }
    
    
    // MARK: 🔥🔥🔥🔥🔥🔥lazy💧💧💧💧💧💧💧
    fileprivate lazy var bgView: UIView = {
        let bgView = UIView(frame: UIScreen.main.bounds)
        bgView.backgroundColor = .black
        bgView.alpha = 0.0
        return bgView
    }()
    
    fileprivate lazy var contentView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 9
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 17 + fontScale, weight: .medium)
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15 + fontScale, weight: .medium)
        return label
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(cancelBtnDidClick), for: .touchUpInside)
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 0.5
        
        return btn
    }()
    
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(confirmBtnDidClick), for: .touchUpInside)
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension UIView {
    
    func addToSuperview() {
        let window = UIApplication.shared.keyWindow
        (window?.subviews[0])!.addSubview(self)
    }
    
    func springingAnimation() {
        let popAnimation = CAKeyframeAnimation(keyPath: "transform")
        popAnimation.duration = 0.5
        popAnimation.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)),
            NSValue(caTransform3D: CATransform3DIdentity)
        ]
        popAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut),
                                        CAMediaTimingFunction(name: .easeInEaseOut),
                                        CAMediaTimingFunction(name: .easeInEaseOut)]
        self.layer.add(popAnimation, forKey: nil)
    }
}

// MARK: 🔥🔥🔥🔥🔥🔥计算字符串高度💧💧💧💧💧💧💧
extension RBAlertView {
    
    func height(_ string: NSString, fontSize: UIFont, width: CGFloat) -> CGFloat {
        
        return string.boundingRect(with: CGSize(width: width, height: 0), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: fontSize], context: nil).size.height
    }
    
    func height(_ attrString: NSAttributedString, width: CGFloat) -> CGFloat {
        
        return attrString.boundingRect(with: CGSize(width: width, height: 0), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin], context: nil).size.height
    }
}



let nativeScale = (ScreenWidth() / 320.0) * 2.0

let displayScale = nativeScale / 2.0

let alertWidth = 270 * displayScale

let alertGap = 10 * displayScale

let alertTitleWidth = alertWidth - 2 * alertGap

let alertViewX = (ScreenWidth() - alertWidth) / 2.0

let fontScale = (ceil(displayScale) - 1) * 2.0

func ScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

func ScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.size.height
}
