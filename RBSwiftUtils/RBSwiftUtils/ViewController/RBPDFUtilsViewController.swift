//
//  RBPDFUtilsViewController.swift
//  RBSwiftUtils
//
//  Created by bo.rong on 2022/1/19.
//  Copyright © 2022 RB. All rights reserved.
//
    

import UIKit
import WebKit

class RBPDFUtilsViewController: UIViewController {

    var webView : WKWebView!
    var documentsFileName : String!
    var shareTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PDFUtils"
        self.view.backgroundColor = .white
        
        let offSetY = self.navigationController?.navigationBar.frame.maxY
        
        let webConfig = WKWebViewConfiguration()
        let frame = CGRect.init(x: 0, y: offSetY! + 50, width: view.frame.width, height: view.frame.height - offSetY! - 50)
        webView = WKWebView(frame: frame, configuration: webConfig)
        view.addSubview(webView)
        
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 30, y: offSetY!, width: 100, height: 34)
        btn.setTitle("獲取數據", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(getBtnDidClick), for: .touchUpInside)
        view.addSubview(btn)
        
        let shareBtn = UIButton.init(type: .custom)
        shareBtn.frame = CGRect.init(x: 200, y: offSetY!, width: 100, height: 34)
        shareBtn.setTitle("分享文件", for: .normal)
        shareBtn.setTitleColor(.black, for: .normal)
        shareBtn.layer.borderColor = UIColor.black.cgColor
        shareBtn.layer.borderWidth = 1
        shareBtn.addTarget(self, action: #selector(shareBtnDidClick), for: .touchUpInside)
        view.addSubview(shareBtn)
        
    }

    @objc func shareBtnDidClick() {
        if documentsFileName == nil {
            return
        }
    
        //只要放 文件路径名称，不要放图片，不然 Airdrop 发送失败
        let shareItems:[Any] = [URL.init(fileURLWithPath: documentsFileName) as Any]
        let activityVC: UIActivityViewController = UIActivityViewController.init(activityItems: shareItems, applicationActivities:nil)
        //排除分享途径
        activityVC.excludedActivityTypes = [.postToFacebook, .mail]
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    @objc func getBtnDidClick() {
        
        let pageSize = RBPDFPageSize.A4
        let pageMargin = 15.0
        
        let pdf = RBPDFUtils(pageSize: pageSize, pageMargin: pageMargin)
        
        pdf.addText("绘制圆角")
        pdf.addVerticalSpace(5)
        pdf.beginHorizontalArrangement()
        
        pdf.addRishonTorusScale(size: CGSize(width: 120, height: 120), backColor: .gray, finishColor: .green, torusWidth: 20, scale: 0.25, scaleFont: 22, scaleColor: .red, tipsText: "达成率", tipsFont: 16, tipsColor: .lightGray)
        
        pdf.addRishonTorusScale(size: CGSize(width: 120, height: 120), backColor: .gray, finishColor: .green, torusWidth: 20, scale: 0.25, scaleFont: 22, scaleColor: .red, tipsText: "")
        
        pdf.endHorizontalArrangement()
        
        pdf.addRishonTorusScale(size: CGSize(width: 120, height: 120), backColor: .gray, finishColor: .green, torusWidth: 20, scale: 0.85, scaleFont: 22, scaleColor: .red, tipsText: "达成率", tipsFont: 16, tipsColor: .lightGray)
        
        pdf.addRishonTorusScale(size: CGSize(width: 120, height: 120), backColor: .gray, finishColor: .green, torusWidth: 20, scale: 0.75, scaleFont: 22, scaleColor: .red, tipsText: "")
        
        pdf.addVerticalSpace(5)
        
        addRishonPDFConsumeRecordTableItem(pdf: pdf)
        
        pdf.addRishonLineSeparator(size: CGSize(width: pageSize.width - pageMargin * 2.0, height: 1))
        
        pdf.addText("绘制进度百分比")
        
        
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            shareTitle = "绘制圆角"
            
            documentsFileName = documentDirectories + "/" + shareTitle + ".pdf"
            
            let pdfData = pdf.generatePDFdata()
            do{
                try pdfData.write(to: URL(fileURLWithPath: documentsFileName), options: .atomic)
                print("\nThe generated pdf can be found at:")
                print("\n\t\(String(describing: documentsFileName))\n")
                
                
                webView.load(pdfData, mimeType: "application/pdf", characterEncodingName: "GBK", baseURL:NSURL.init(fileURLWithPath: "") as URL)
            }catch{
                print(error)
            }
        }
    }
    
    
    //table数据
    fileprivate func addRishonPDFConsumeRecordTableItem(pdf: RBPDFUtils) {
        
        var dataArray:[Any] = ["南京金吉鸟", "2022/01/12\n12:50:30", "一般消费", "杠铃", "¥185", "优惠抵扣 -¥5\n会员抵扣 -¥5\n折扣券 -¥5\n积分抵扣 -¥5", "¥175"]
        
        let text = "消费抵扣 -5\n获得积分+17"
        let attrStr = NSMutableAttributedString(string: "\(text)\n累计积分17")
        
        attrStr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10)], range: NSRange(location: 0, length: attrStr.length))
        attrStr.addAttributes([NSAttributedString.Key.foregroundColor :UIColor .red], range: NSRange(location: 0, length: attrStr.length))
        attrStr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 8)], range: NSRange(location: 0, length: text.count))
        attrStr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: NSRange(location: 0, length: text.count))
        
        dataArray.append(attrStr)
        
        // 格式聲明
        var alignments:[ContentAlignment] = []
        let columnWidths: [CGFloat] = [65, 90, 65, 65, 70, 70, 70, 70]
        var fonts:[UIFont] = []
        var textColors:[UIColor] = []
        var backColors:[UIColor] = []
        var rowLine:[Bool] = []
        var columnLine:[Bool] = []
        
        for i in 0..<columnWidths.count {
            rowLine.append(true)
            columnLine.append(false)
            if i == 0 {
                alignments.append(.left)
            }
            else {
                alignments.append(.center)
            }
            textColors.append(.black)
            
            if i == 5 {
                alignments[i] = .right
                fonts.append(.systemFont(ofSize: 8))
            }
            else {
                fonts.append(.systemFont(ofSize: 12))
            }
            
            backColors.append(.white)
        }
        let tableDefinition = TableDefinition(alignments: alignments, columnWidths: columnWidths, fonts: fonts, textColors: textColors, backColors)
        
        pdf.addRishonUITable(1, columnCount: columnWidths.count, rowHeight: 50, rowHeightRefer: 50, tableLineWidth: 1, tableLineColor: .gray, tableDefinition: tableDefinition, dataArray: [dataArray], columnLine:columnLine, rowLine: rowLine)
        
        pdf.addVerticalSpace(5)
    }
}
