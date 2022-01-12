//
//  RBViewTestController.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/12.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit

class RBViewTestController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "View设置相关测试"
        
        let leftView = UIView(frame: CGRect(x: 10, y: (self.navigationController?.navigationBar.frame.maxY)! + 10, width: 100, height: 50))
        leftView.backgroundColor = .gray
        leftView.updateLayBorders([.layerLeftBorder,], borderColor: .red, borderWidth: 2)
        view.addSubview(leftView)
        
        let leftView1 = UIView(frame: CGRect(x: 10, y: leftView.frame.maxY + 5, width: 100, height: 50))
        leftView1.backgroundColor = .gray
        leftView1.updateLayBorders([.layerTopBorder], borderColor: .red, borderWidth: 2)
        view.addSubview(leftView1)
        
        let leftView2 = UIView(frame: CGRect(x: 10, y: leftView1.frame.maxY + 5, width: 100, height: 50))
        leftView2.backgroundColor = .gray
        leftView2.updateLayBorders([.layerRightBorder], borderColor: .red, borderWidth: 2)
        view.addSubview(leftView2)
        
        let leftView3 = UIView(frame: CGRect(x: 10, y: leftView2.frame.maxY + 5, width: 100, height: 50))
        leftView3.backgroundColor = .gray
        leftView3.updateLayBorders([.layerBottomBorder], borderColor: .red, borderWidth: 2)
        view.addSubview(leftView3)
        
        let leftView4 = UIView(frame: CGRect(x: 10, y: leftView3.frame.maxY + 5, width: 100, height: 50))
        leftView4.backgroundColor = .gray
        leftView4.updateLayBorders([.layerLeftBorder, .layerTopBorder], borderColor: .red, borderWidth: 2)
        view.addSubview(leftView4)
        
        let leftView5 = UIView(frame: CGRect(x: 10, y: leftView4.frame.maxY + 5, width: 100, height: 50))
        leftView5.backgroundColor = .gray
        leftView5.updateLayBorders([.layerAllBorder], borderColor: .red, borderWidth: 2)
        view.addSubview(leftView5)
        
    }

}
