//
//  ViewController.swift
//  DropDownBoxDemo
//
//  Created by 也许、 on 16/10/25.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let screenW = UIScreen.main.bounds.width

class ViewController: UIViewController {
    
    // 文本框
    lazy var textFiled : UITextField = {
        
        let frame = CGRect(x: 5, y: 30, width: screenW - 10, height: 30)
        let textField = UITextField(frame: frame)
        textField.borderStyle = .line
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(ViewController.showDropDownBox), for: .touchUpInside)
        textField.rightView = btn
        textField.rightViewMode = .always
        
        return textField
        
    }()
    
    // 下拉框
//    lazy var dropDownBoxView : DropDownBoxView = {
//    
//        let dropDownBoxView:DropDownBoxView = DropDownBoxView(frame: self.textFiled.frame)
//        dropDownBoxView.delegate = self
//        dropDownBoxView.isHidden = true
//        return dropDownBoxView
//    
//    }()

    var dropDownBoxView : DropDownBoxView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

extension ViewController {

    // 初始化UI
    func setupUI() {
        
        self.view.addSubview(textFiled)
        
        // 创建下拉框控件
        let dropDownBoxView = DropDownBoxView(frame: self.textFiled.frame)
        dropDownBoxView.delegate = self
        self.view.addSubview(dropDownBoxView)
        self.dropDownBoxView = dropDownBoxView
        
        // 设置数据
        dropDownBoxView.datas = ["111","222","333","444","555","666"]
    
    }

    // 显示下拉框
    @objc func showDropDownBox() {
        UIView.animate(withDuration: 0.35) { 
            self.dropDownBoxView?.isHidden = false
        }
    }
    
}

extension ViewController : DropDownBoxViewDelegate {

    func dropDownBoxClicked(info : String, finished: () -> ()) {
        self.textFiled.text = info
        finished()
    }

}

