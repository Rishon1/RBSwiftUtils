//
//  RBHomeCellModel.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/12.
//  Copyright © 2022 RB. All rights reserved.
//

import Foundation

enum RBHomeCellType {
    case noneType, alertType, viewType, labelType
}

class RBHomeCellModel: NSObject {
    var floorType:RBHomeCellType?
    
    var title: String = ""
    
    override init() {
        super.init()
    }
    
    init(_ floorType: RBHomeCellType = .noneType , title: String = "") {
        self.floorType = floorType
        self.title = title
    }
}
