
//  FaxianController.swift
//  NetEase Music
//
//  Created by phoenix Dai on 2020/2/7.
//  Copyright © 2020 phoenix Dai. All rights reserved.


import UIKit
import SnapKit

class AcountController: UIViewController, UITextFieldDelegate {
    static var newAccount = ""
    static var newPassword = ""
    static var question = ""
    static var answer = ""
    var Music: UIImageView = UIImageView(frame: CGRect(x: 60, y: 50, width: 300, height: 160))
    var MusicLabel = UILabel(frame: CGRect(x: 140, y: 250, width: 300, height: 100))
    let account = UITextField(frame: CGRect(x: 100, y: 350, width: 250, height: 40))
    let password = UITextField(frame: CGRect(x: 100, y: 400, width: 250, height: 40))
    let password2 = UITextField(frame: CGRect(x: 100, y: 450, width: 250, height: 40))
    let question = UITextField(frame: CGRect(x: 100, y: 500, width: 250, height: 40))
    let answer = UITextField(frame: CGRect(x: 100, y: 550, width: 250, height: 40))
    var signBtn = UIButton(frame: CGRect(x: 150, y: 700, width: 100, height: 50))
    
    var account_Label = UILabel(frame: CGRect(x: 15, y: 350, width: 100, height: 40))
    var password_Label = UILabel(frame: CGRect(x: 15, y: 400, width: 100, height: 40))
    var password2_Label = UILabel(frame: CGRect(x: 15, y: 450, width: 100, height: 40))
    var question_Label = UILabel(frame: CGRect(x: 15, y: 500, width: 100, height: 40))
    var answer_Label = UILabel(frame: CGRect(x: 15, y: 550, width: 100, height: 40))
    
     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.955, alpha: 1)
        Music.image = #imageLiteral(resourceName: "Music")
    
        navigationBar()
        
        Mlabel()
        
        aTextField()

        pTextfield()
        
        pTextfield2()
        
        qTextfield()
        
        answerTextfield()
        
        Sbtn()
        
        Labels()
        
        view.addSubview(Music)

    }
    
    
//    MARK:- 导航栏隐藏
    func navigationBar()  {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
//    MARK:-注册按钮
    func Sbtn() {
        signBtn.layer.cornerRadius = 5
        signBtn.setTitle("SIGN", for: .normal)
        signBtn.titleLabel?.font = UIFont(name: "Chalkduster", size: 20)
        signBtn.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.5, alpha: 1)
        signBtn.setTitleColor(.white, for: .normal)
        signBtn.setTitleColor(.cyan, for: .highlighted)
        signBtn.addTarget(self, action: #selector(signBtnAction), for: .touchUpInside)
        view.addSubview(signBtn)
    }
    
    
//    MARK:- 注册Label
    func Mlabel()  {
        MusicLabel.font = UIFont(name: "Zapfino", size: 30)
        MusicLabel.text = "register"
        MusicLabel.shadowColor = UIColor.gray
        MusicLabel.shadowOffset = CGSize(width:1.5, height:1.5)
        view.addSubview(MusicLabel)
    }
    
    
//    MARK:- 用户名
    func aTextField() {
        account.borderStyle = UITextField.BorderStyle.roundedRect
        account.layer.masksToBounds = true
        account.layer.cornerRadius = 12
        account.layer.borderWidth = 2
        account.layer.borderColor = UIColor.blue.cgColor
        account.placeholder = "请输入用户名"
        account.adjustsFontSizeToFitWidth = true
        account.minimumFontSize = 10
        account.textAlignment = .center
        account.contentVerticalAlignment = .center
        account.clearButtonMode = .whileEditing
        account.keyboardType = .default
        account.returnKeyType = UIReturnKeyType.done
        account.delegate = self
        view.addSubview(account)
        

    }
    
    
//    MARK:- 密码
    func pTextfield() {
        password.borderStyle = UITextField.BorderStyle.roundedRect
        password.layer.masksToBounds = true
        password.layer.cornerRadius = 12
        password.layer.borderWidth = 2
        password.layer.borderColor = UIColor.blue.cgColor
        password.placeholder = "请输入密码"
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
    
    
    
//    MARK:-二次密码
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
    
    
//    MARK:- 找回问题
    func qTextfield() {
           question.borderStyle = UITextField.BorderStyle.roundedRect
           question.layer.masksToBounds = true
           question.layer.cornerRadius = 12
           question.layer.borderWidth = 2
           question.layer.borderColor = UIColor.blue.cgColor
           question.placeholder = "请输入密保问题"
           question.adjustsFontSizeToFitWidth = true
           question.minimumFontSize = 10
           question.textAlignment = .center
           question.isSecureTextEntry = false
           question.contentVerticalAlignment = .center
           question.clearButtonMode = .whileEditing
           question.keyboardType = .default
           question.returnKeyType = UIReturnKeyType.done
           question.delegate = self
           view.addSubview(question)
       }
    
    
//    MARK:-找回答案
    func answerTextfield() {
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
    
    
//    MARK:- textfield代理
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
    
//    MARK:- 按下按钮
    @objc func signBtnAction() {
        if password2.text! != password.text! {
            let alertController = UIAlertController(title: "提示!", message: "密码不一致，请重试", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "了解", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else {
        AcountController.newAccount = account.text ?? "none"
        AcountController.newPassword = password.text ?? "none"
        AcountController.answer = answer.text ?? "none"
        AcountController.question = question.text ?? "none"
        navigationController?.pushViewController(LoginController(), animated: true)
        }
    }
    
//    MARK:- labels
    func Labels() {
        account_Label.text = "用户名："
        password_Label.text = "密码："
        password2_Label.text = "再次输入："
        question_Label.text = "密保问题："
        answer_Label.text = "密保答案："
        
        
        view.addSubview(account_Label)
        view.addSubview(password2_Label)
        view.addSubview(password_Label)
        view.addSubview(question_Label)
        view.addSubview(answer_Label)
    }
}
