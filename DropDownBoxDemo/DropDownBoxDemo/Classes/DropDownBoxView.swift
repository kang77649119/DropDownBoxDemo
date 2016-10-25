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

protocol DropDownBoxViewDelegate : class {
    
    func dropDownBoxClicked(info:String,finished:()->())
    
}

class DropDownBoxView: UIView {
    
    var datas:[String]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
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
    
    var delegate : DropDownBoxViewDelegate?

    override init(frame: CGRect) {
        
        let viewFrame = CGRect(x: frame.origin.x, y: frame.maxY, width: frame.width, height: DropDownBoxViewH)
        super.init(frame: viewFrame)
        
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
        delegate?.dropDownBoxClicked(info: info, finished: { 
            self.isHidden = true
        })
    }

}
