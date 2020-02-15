//
//  FindController.swift
//  NetEase Music
//
//  Created by phoenix Dai on 2020/2/11.
//  Copyright © 2020 phoenix Dai. All rights reserved.
//

import UIKit

class FindController: UIViewController, UITextFieldDelegate {
    var findBackBtn:UIButton = UIButton(frame: CGRect(x: 150, y: 600, width: 100, height: 50))
    var textLabel: UILabel = UILabel(frame: CGRect(x: 50, y: 200, width: 300, height: 80))
    var answer: UITextField = UITextField(frame: CGRect(x: 50, y: 300, width: 300, height: 40))
    var password: UITextField = UITextField(frame: CGRect(x: 50, y: 400, width: 300, height: 40))
    var password2: UITextField = UITextField(frame: CGRect(x: 50, y: 500, width: 300, height: 40))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        TextLabel()
        Answer()
        pTextfield()
        pTextfield2()
        FindBackBtn()
    }
    
    
//    MARK:- 文本框
    func TextLabel()  {
        textLabel.text = AcountController.question
        textLabel.font = UIFont.boldSystemFont(ofSize: 30)
        textLabel.shadowColor = UIColor.gray
        textLabel.shadowOffset = CGSize(width:1.5, height:1.5)
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.numberOfLines = 2
        view.addSubview(textLabel)
    }
    
    
//    MARK:- 答案
    func Answer() {
        answer.borderStyle = UITextField.BorderStyle.roundedRect
        answer.layer.masksToBounds = true
        answer.layer.cornerRadius = 12
        answer.layer.borderWidth = 2
        answer.layer.borderColor = UIColor.blue.cgColor
        answer.placeholder = "请输入密保答案"
        answer.adjustsFontSizeToFitWidth = true
        answer.minimumFontSize = 10
        answer.textAlignment = .center
        answer.isSecureTextEntry = false
        answer.contentVerticalAlignment = .center
        answer.clearButtonMode = .whileEditing
        answer.keyboardType = .default
        answer.returnKeyType = UIReturnKeyType.done
        answer.delegate = self
        view.addSubview(answer)
    }
    
//    MARK:- 新密码
    func pTextfield() {
        password.borderStyle = UITextField.BorderStyle.roundedRect
        password.layer.masksToBounds = true
        password.layer.cornerRadius = 12
        password.layer.borderWidth = 2
        password.layer.borderColor = UIColor.blue.cgColor
        password.placeholder = "请输入新密码"
        password.adjustsFontSizeToFitWidth = true
        password.minimumFontSize = 10
        password.textAlignment = .center
        password.isSecureTextEntry = true
        password.contentVerticalAlignment = .center
        password.clearButtonMode = .whileEditing
        password.keyboardType = .default
        password.returnKeyType = UIReturnKeyType.done
        password.delegate = self
        view.addSubview(password)
    }
    
    
//    MARK:- 新密码二次
    func pTextfield2() {
        password2.borderStyle = UITextField.BorderStyle.roundedRect
        password2.layer.masksToBounds = true
        password2.layer.cornerRadius = 12
        password2.layer.borderWidth = 2
        password2.layer.borderColor = UIColor.blue.cgColor
        password2.placeholder = "请再次输入密码"
        password2.adjustsFontSizeToFitWidth = true
        password2.minimumFontSize = 10
        password2.textAlignment = .center
        password2.isSecureTextEntry = true
        password2.contentVerticalAlignment = .center
        password2.clearButtonMode = .whileEditing
        password2.keyboardType = .default
        password2.returnKeyType = UIReturnKeyType.done
        password2.delegate = self
        view.addSubview(password2)
    }
    
    
//    MARK:- 文本代理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == password2 {
            if textField.text! != password.text! {
                let alertController = UIAlertController(title: "提示!", message: "密码不一致，请重试", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "了解", style: .default,handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        return true
    }
    
    
//    MARK:- 按钮
    func FindBackBtn() {
        findBackBtn.setTitle("更改密码", for: .normal)
        findBackBtn.layer.cornerRadius = 10
        findBackBtn.backgroundColor = .orange
        findBackBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        findBackBtn.addTarget(self, action: #selector(FindBackBtnAction), for: .touchUpInside)
        view.addSubview(findBackBtn)
    }
    
    
//    MARK:- 按钮动作
    @objc func FindBackBtnAction() {
        if answer.text! == AcountController.answer {
            if password.text == AcountController.newPassword {
                let alertController = UIAlertController(title: "提示!", message: "新密码与旧密码一致", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "确定", style: .default,handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                AcountController.newPassword = password.text!
                navigationController?.pushViewController(LoginController(), animated: true)
            }
        }
        else {
            let alertController = UIAlertController(title: "提示!", message: "答案错误！！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
