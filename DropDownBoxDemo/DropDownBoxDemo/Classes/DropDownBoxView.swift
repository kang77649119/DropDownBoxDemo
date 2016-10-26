//
//  DropDownBoxView.swift
//  DropDownBoxDemo
//
//  Created by 也许、 on 16/10/25.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let DropDownBoxCellId = "DropDownBoxCellId"
private let DropDownBoxViewH:CGFloat = 200

@objc protocol DropDownBoxViewDelegate : class {
    
    @objc optional func dropDownBoxClicked(referenceView:UIView, info:String, finished:()->())
    
}

class DropDownBoxView: UIView {
    
    var datas:[String]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var referenceView : UIView?
    
    var delegate : DropDownBoxViewDelegate?
    
    lazy var tableView : UITableView =  {
        
        let w = self.frame.width
        let frame = CGRect(x: 0, y: 0, width: w, height: DropDownBoxViewH)
        let tableView:UITableView = UITableView(frame: frame)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DropDownBoxCellId)
        return tableView
    
    }()

    override init(frame: CGRect) {
        
        let viewFrame = CGRect(x: frame.origin.x, y: frame.maxY, width: frame.width, height: DropDownBoxViewH)
        super.init(frame: viewFrame)
        
        // 初始化UI
        setupUI()
    }
    
    init(referenceView : UIView) {
        
        self.referenceView = referenceView
        
        let viewF = referenceView.frame
        let viewFrame = CGRect(x: viewF.origin.x, y: viewF.maxY, width: viewF.width, height: DropDownBoxViewH)
        super.init(frame: viewFrame)
        
        if referenceView.classForCoder == UITextField.classForCoder() {
            (referenceView as! UITextField).delegate = self
        }
        
        // 初始化UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DropDownBoxView {

    func setupUI() {
        self.isHidden = true
        self.addSubview(tableView)
    }

}

extension DropDownBoxView : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownBoxCellId)
        cell!.textLabel!.text = self.datas![indexPath.row]
        cell?.contentView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        return cell!
        
    }

}

extension DropDownBoxView : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let info = self.datas![indexPath.row]
        
        guard let refView = self.referenceView else {
            return
        }
        
        // 文本框
        if refView.classForCoder == UITextField.classForCoder() {
            (refView as! UITextField).text = info
            self.isHidden = true
        } else {
            
            // 非文本框
            delegate?.dropDownBoxClicked!(referenceView: refView, info: info, finished: { 
                self.isHidden = true
            })
            
        }
        
    }

}

extension DropDownBoxView : UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.isHidden = !self.isHidden
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
        
        return false
        
    }

}
