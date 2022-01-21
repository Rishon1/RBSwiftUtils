//
//  RBPageTestViewController.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/20.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit

class RBPageTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PageView"
        self.view.backgroundColor = .white
        var vcs:[UIViewController] = []
        
        for i in 0..<10 {
            let vc =  UIViewController()
            vc.title = "hahas1"
            let label = UILabel(frame: CGRect(x: 10, y: 200, width: 120, height: 44))
            label.text = "当前第\(i)个view"
            label.textColor = .black
            vc.view.addSubview(label)
            vc.view.backgroundColor = .white
            vcs.append(vc)
        }
        
        let pageVc = RBPageViewController()
        self.addChild(pageVc)
        
        pageVc.updateViewControllers(controllers: vcs)
        pageVc.view.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.maxY)!, width: self.view.bounds.width, height: self.view.bounds.height - (self.navigationController?.navigationBar.frame.maxY)!)
        self.view.addSubview(pageVc.view)
    }
}
