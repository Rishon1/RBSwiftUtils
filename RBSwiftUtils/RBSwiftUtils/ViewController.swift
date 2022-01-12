//
//  ViewController.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initChildView()
        
        dealWithDataSource()
        
    }
    
    // MARK: 🔥🔥🔥🔥🔥🔥處理樓層數據💧💧💧💧💧💧💧
    fileprivate func dealWithDataSource() {
        
        self.dataSource = [RBHomeCellModel(.alertType, title: "AlertView"), RBHomeCellModel(.viewType, title: "UIView")]
        
        self.tableView.reloadData()
    }

    
    
    // MARK: 🔥🔥🔥🔥🔥🔥lazy💧💧💧💧💧💧💧
    fileprivate lazy var dataSource: [RBHomeCellModel] = {
        let dataSource:[RBHomeCellModel] = []
        return dataSource
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        return tableView
    }()

}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.创建cell：
        let CellID = "UITableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellID)
        
        let cellModel:RBHomeCellModel = self.dataSource[indexPath.row]
        
        
        if cell == nil {
            // 在swift中使用枚举: 1> 枚举类型.具体的类型 2> .具体的类型
            cell = UITableViewCell(style: .default, reuseIdentifier: CellID)
        }
        
        cell?.textLabel!.text = cellModel.title
        
        // 3.返回cell
        return cell!
    }
}


extension ViewController {
    func initChildView() {
        self.title = "工具类归类"
        self.view.addSubview(self.tableView)
        
        self.tableView.frame = self.view.frame
    }
}
