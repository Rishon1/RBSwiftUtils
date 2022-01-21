//
//  RBPageViewController.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/20.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit

protocol RBPageViewControllerDelegate: NSObjectProtocol {
    func pageViewController(_ viewController : RBPageViewController, didSelect selectedIndex : Int)
}

class RBPageViewController: UIViewController {

    var viewControllers:[UIViewController]?
    
    func updateViewControllers(controllers:[UIViewController]) {
        segments.removeAll()
        self.children.forEach { controller in
            controller.removeFromParent()
        }
        self.viewControllers = controllers
        
        controllers.forEach { vc in
            if vc.title!.count > 0 {
                segments.append(vc.tabBarItem)
            }
            self.addChild(vc)
        }
        loadChildView()
    }
    
    var segmentViewHeight:CGFloat = 44.0
    
    weak open var delegate: RBPageViewControllerDelegate?
    
    public var currentSelectedIndex: Int {
        get {
            return lastIndex == NSNotFound ? 0 : lastIndex!
        }
    }
    
    fileprivate var segments:[UITabBarItem] = [] //分段视图数据
    fileprivate var segmentView: RBSegmentView? //分段视图
    fileprivate var pageView: RBPageView?  //分页视图容器
    fileprivate var lastIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RBPageViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        let location = gestureRecognizer.location(in: self.view)
        let pan: UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
        
        if (location.x > 60 || pageView!.index != 1 || pan.velocity(in: self.view).x < 0) {
            return true
        }else{
            return false
        }
    }
}

extension RBPageViewController {
    
    func loadChildView() {
        //1.加载分段视图
        self.loadSegmentView()
        
        //2.加载内容视图
        self.loadContentView()
    }
    
    func loadSegmentView() {
        if self.segments.isEmpty {
            return
        }
        
        segmentView?.removeFromSuperview()
        
        segmentView = RBSegmentView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: segmentViewHeight), segments: segments)
        segmentView!.backgroundColor = .brown;
        
        segmentView?.btnDidClick = { [self] index in
            pageView?.updateIndex(newIndex: index+1)
        }
        self.view.addSubview(segmentView!)
        
    }
    
    func loadContentView() {
        pageView?.removeFromSuperview()
        
        var contentViewArr:[UIView] = []
        self.viewControllers!.forEach { vc in
            vc.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.bounds.size)
            contentViewArr.append(vc.view)
        }
        
        var viewY = 0.0
        if (segmentView != nil) {
            viewY = segmentView!.frame.maxY;
        }
        let viewH = self.view.bounds.size.height - viewY;
        pageView = RBPageView(frame: CGRect(x: 0, y: viewY, width: self.view.bounds.width, height: viewH), pages: contentViewArr)
        
        if segmentView != nil {
            self.view.insertSubview(pageView!, belowSubview: segmentView!)
        }
        else {
            self.view.addSubview(pageView!)
        }
        
        pageView!.indexChange = { [self] (newIndex, oldIndex) in
            
            NSLog("new:\(newIndex), old:\(oldIndex)")
            segmentView!.updateCurrentIndex(newIndex: newIndex - 1)
        }
    }
    
    func responsePageViewIndexChangedDelegate(index: Int) -> Void {
        if lastIndex == index {
            return
        }
        lastIndex = index
        
        if self.delegate != nil && self.delegate!.responds(to: Selector(("pageViewController:didSelect:"))) {
            self.delegate?.pageViewController(self, didSelect: index)
        }
    }
}



