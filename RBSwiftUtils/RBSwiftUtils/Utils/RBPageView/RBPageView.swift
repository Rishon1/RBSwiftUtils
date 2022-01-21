//
//  RBPageView.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/20.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit

class RBPageView: UIView {
    typealias indexChangeBlock = (_ newIndex:Int, _ oldIndex:Int)->Void
    fileprivate var separatorW = 6.0
    
    var index: Int = 0
    
    var indexChange: indexChangeBlock?
    fileprivate var contentView: UICollectionView?
    fileprivate var panGestureShouldBegin: Bool = false
    fileprivate var panGestureDragDistance: CGFloat = 0.0
    public private(set) var pages: [UIView]?
    
    init(frame: CGRect, pages: [UIView]) {
        super.init(frame: frame)
        self.initPages(pages)
    }
    
    func initPages(_ pages: [UIView]) {
        
        self.pages = pages
        index = 0
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "kContentCellID")
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        self.addSubview(view)
        self.layer.masksToBounds = true
        self.contentView = view
        
        if !pages.isEmpty {
            self.contentView?.reloadData()
        }
    }
    
    func updateIndex(newIndex: Int) {
        var newId = newIndex
        
        if newId<1 {
            newId=1
        }
        if newId>self.pages!.count {
            newId=self.pages!.count
        }
        
        if (self.indexChange != nil) {
            self.indexChange!(newId, index)
        }
        
        self.index = newId
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: [.curveEaseIn, .allowUserInteraction]) { [self] in
            
            self.contentView?.contentOffset = CGPoint(x: self.bounds.width * CGFloat(newId - 1), y: 0.0)
            
        } completion: { finished in
            
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RBPageView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pages!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 0.01, height: 0.01)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 0.01, height: 0.01)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if self.index != indexPath.row + 1 {
            var newId = indexPath.row + 1
            if newId<1 {
                newId=1
            }
            if newId > self.pages!.count {
                newId = self.pages!.count
            }
            
            if (self.indexChange != nil) {
                self.indexChange!(newId, index)
            }
            
            self.index = newId
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kContentCellID", for: indexPath)
        
        let view = self.pages![indexPath.row]
        cell.contentView.addSubview(view)
        view.frame = cell.contentView.frame
        return cell
    }
}

