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
    
    // MARK: π₯π₯π₯π₯π₯π₯θηζ¨ε±€ζΈζπ§π§π§π§π§π§π§
    fileprivate func dealWithDataSource() {
        
        self.dataSource = [RBHomeCellModel(.alertType, title: "AlertView"),
                           RBHomeCellModel(.viewType, title: "UIView"),
                           RBHomeCellModel(.labelType, title: "UILabel"),
                           RBHomeCellModel(.pdfType, title: "PDFUtils"),
                           RBHomeCellModel(.pageViewType, title: "PageView")]
        
        self.tableView.reloadData()
    }

    
    
    // MARK: π₯π₯π₯π₯π₯π₯lazyπ§π§π§π§π§π§π§
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
        // 1.εε»ΊcellοΌ
        let CellID = "UITableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellID)
        
        let cellModel:RBHomeCellModel = self.dataSource[indexPath.row]
        
        
        if cell == nil {
            // ε¨swiftδΈ­δ½Ώη¨ζδΈΎ: 1> ζδΈΎη±»ε.ε·δ½ηη±»ε 2> .ε·δ½ηη±»ε
            cell = UITableViewCell(style: .default, reuseIdentifier: CellID)
        }
        
        cell?.textLabel!.text = cellModel.title
        
        // 3.θΏεcell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel:RBHomeCellModel = self.dataSource[indexPath.row]
        
        if cellModel.floorType == .alertType {
            self.navigationController?.pushViewController(RBAlertViewTestController(), animated: true)
        }
        else if cellModel.floorType == .viewType {
            self.navigationController?.pushViewController(RBViewTestController(), animated: true)
        }
        else if cellModel.floorType == .labelType {
            self.navigationController?.pushViewController(RBLabelViewController(), animated: true)
        }
        else if cellModel.floorType == .pdfType {
            self.navigationController?.pushViewController(RBPDFUtilsViewController(), animated: true)
        }
        else if cellModel.floorType == .pageViewType {
            self.navigationController?.pushViewController(RBPageTestViewController(), animated: true)
        }
    }
}


extension ViewController {
    func initChildView() {
        self.title = "ε·₯ε·η±»ε½η±»"
        self.view.addSubview(self.tableView)
        
        self.tableView.frame = self.view.frame
    }
}
