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
    
    // 控件1 文本框
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
    
    // 控件2 Label
    lazy var secTextFiled : UITextField = {
        
        let frame = CGRect(x: 5, y: 70, width: screenW - 10, height: 30)
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

    var dropDownBoxView : DropDownBoxView?
    var secDropDownBoxView : DropDownBoxView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

extension ViewController {

    // 初始化UI
    func setupUI() {
        
        self.view.addSubview(textFiled)
        self.view.addSubview(secTextFiled)
        
        // 创建控件1的下拉框
        let dropDownBoxView = DropDownBoxView(referenceView: textFiled)
        self.view.addSubview(dropDownBoxView)
        self.dropDownBoxView = dropDownBoxView
        
        // 创建控件2的下拉框
        let secDropDownBoxView = DropDownBoxView(referenceView: secTextFiled)
        self.view.addSubview(secDropDownBoxView)
        self.secDropDownBoxView = secDropDownBoxView
        
        // 设置数据
        dropDownBoxView.datas = ["111","222","333","444","555","666"]
        secDropDownBoxView.datas = ["AAA","BBB","CCC","DDD","EEE","FFF"]
    
    }

    // 显示下拉框
    @objc func showDropDownBox() {
        UIView.animate(withDuration: 0.35) {
            self.dropDownBoxView?.isHidden = !self.dropDownBoxView!.isHidden
        }
    }
    
}

