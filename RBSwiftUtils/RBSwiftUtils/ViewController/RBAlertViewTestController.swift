//
//  RBAlertViewTestController.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/12.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit

class RBAlertViewTestController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RBAlertViewTest"
        self.view.backgroundColor = .white
        
        let leftSpace = (self.view.frame.width - 150) / 2.0
        
        
        let firstBtn = UIButton(type: .custom)
        firstBtn.setTitle("无按弹框", for: .normal)
        firstBtn.backgroundColor = .gray
        firstBtn.tag = 100
        firstBtn.frame = CGRect(x: leftSpace, y: self.navigationController?.navigationBar.frame.maxY ?? 64, width: 150, height: 44)
        firstBtn.addTarget(self, action: #selector(systemAlertBtnDidClick(button:)), for: .touchUpInside)
        view.addSubview(firstBtn)
        
        let secBtn = UIButton(type: .custom)
        secBtn.setTitle("按钮弹框", for: .normal)
        secBtn.backgroundColor = .purple
        secBtn.tag = 101
        secBtn.frame = CGRect(x: leftSpace, y: firstBtn.frame.maxY, width: 150, height: 44)
        secBtn.addTarget(self, action: #selector(systemAlertBtnDidClick(button:)), for: .touchUpInside)
        view.addSubview(secBtn)
        
        let secBtn1 = UIButton(type: .custom)
        secBtn1.setTitle("富文本弹框", for: .normal)
        secBtn1.backgroundColor = .red
        secBtn1.tag = 102
        secBtn1.frame = CGRect(x: leftSpace, y: secBtn.frame.maxY, width: 150, height: 44)
        secBtn1.addTarget(self, action: #selector(systemAlertBtnDidClick(button:)), for: .touchUpInside)
        view.addSubview(secBtn1)
        
        let secBtn2 = UIButton(type: .custom)
        secBtn2.setTitle("视图弹框", for: .normal)
        secBtn2.backgroundColor = .blue
        secBtn2.tag = 103
        secBtn2.frame = CGRect(x: leftSpace, y: secBtn1.frame.maxY, width: 150, height: 44)
        secBtn2.addTarget(self, action: #selector(systemAlertBtnDidClick(button:)), for: .touchUpInside)
        view.addSubview(secBtn2)
        
    }
    

    

}

extension RBAlertViewTestController {
    
    @objc func systemAlertBtnDidClick(button: UIButton) {
        
        switch button.tag - 100 {
        case 0:
            alertView()
        case 1:
            alertView2()
        case 2:
            alertAttrView()
        default:
            alertContentView()
        }
    }
    
    
    fileprivate func alertView() {
        
        let aview = RBAlertView("1231231", "22222222", cancelTitle: nil, confirmTitle: nil) {
            NSLog("confirm")
        } cancelBlock: {
            NSLog("cancel")
        }
        
        aview.show()
    }
    
    fileprivate func alertView2() {
        
        let aview = RBAlertView("1231231", "22222222", cancelTitle: "取消", confirmTitle: "确定") {
            NSLog("confirm")
        } cancelBlock: {
            NSLog("cancel")
        }
        
        aview.show()
    }
    
    fileprivate func alertAttrView() {
        
        let str = "12311111"
        let attr = NSMutableAttributedString(string: str)
        
        attr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)], range: NSRange(location: 0, length: str.count))
        attr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.red], range: NSRange(location: 0, length: 3))
        
        let msg = "2222222"
        let attrMsg = NSMutableAttributedString(string: msg)
        
        attrMsg.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)], range: NSRange(location: 0, length: msg.count))
        attrMsg.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.red], range: NSRange(location: 0, length: 3))
        
        let aview = RBAlertView(attr, attrMsg, cancelTitle: "取消", confirmTitle: "確認") {
            NSLog("confirm")
        } cancelBlock: {
            NSLog("cancel")
        }
        
        
        aview.show()
    }
    
    fileprivate func alertContentView() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 250, height: 400)
        view.backgroundColor = .green
        let aview = RBAlertView(contextView: view, cancelTitle: nil, confirmTitle: "確定") {
            NSLog("confirm")
        } cancelBlock: {
            NSLog("cancel")
        }
        
        aview.show()

    }
}
