//
//  RBLabelViewController.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/15.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit

class RBLabelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UILabel"
        self.view.backgroundColor = .white

        let label = RBLabel(CGRect(x: 20, y: 200, width: 30, height: 44), paddingSpace: 3)
        label.text = "标签信息"
        label.layer.cornerRadius = 5
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 1
        label.backgroundColor = .green
        self.view.addSubview(label)
        let label1 = RBLabel(CGRect(x: 20, y: 250, width: 30, height: 44), paddingSpace: 3)
        label1.text = "标签信息信息信息"
        label1.textColor = .red
        label1.layer.cornerRadius = 5
        label1.layer.borderColor = UIColor.red.cgColor
        label1.layer.borderWidth = 1
        label1.backgroundColor = .green
        self.view.addSubview(label1)
        
        let label2 = RBLabel(CGRect(x: 20, y: 300, width: 30, height: 20), paddingSpace: 7)
        label2.text = "1"
        label2.layer.cornerRadius = 10
        label2.layer.borderColor = UIColor.red.cgColor
        label2.layer.borderWidth = 1
        label2.backgroundColor = .green
        self.view.addSubview(label2)
        
    }

}
