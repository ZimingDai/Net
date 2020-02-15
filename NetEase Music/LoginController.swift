//
//  LoginController.swift
//  NetEase Music
//
//  Created by phoenix Dai on 2020/2/11.
//  Copyright © 2020 phoenix Dai. All rights reserved.
//
import UIKit
import SnapKit

class LoginController: UIViewController, UITextFieldDelegate {
   
    var Music: UIImageView = UIImageView(frame: CGRect(x: 60, y: 50, width: 300, height: 160))
    var MusicLabel = UILabel(frame: CGRect(x: 130, y: 250, width: 300, height: 100))
    let account = UITextField(frame: CGRect(x: 75, y: 450, width: 250, height: 40))
    let password = UITextField(frame: CGRect(x: 75, y: 550, width: 250, height: 40))
    var loginBtn = UIButton(frame: CGRect(x: 150, y: 700, width: 100, height: 50))
    var findbtn = UIButton(frame: CGRect(x: 100, y: 600, width: 90, height: 20))
    
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.955, alpha: 1)
        Music.image = #imageLiteral(resourceName: "Music")
    
        navigationBar()
        
        Mlabel()
        
        aTextField()

        pTextfield()
        
        Lbtn()
        
        findbtnAction()
        
        view.addSubview(Music)

    }
    
    
//    MARK:- 导航栏隐藏
    func navigationBar()  {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
//    MARK:-找回按钮
    func findbtnAction() {
        findbtn.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.955, alpha: 1)
        findbtn.setTitle("忘记密码？", for: .normal)
        findbtn.setTitleColor(.blue, for: .normal)
        findbtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        findbtn.addTarget(self, action: #selector(findBtnAction), for: .touchUpInside)
        view.addSubview(findbtn)
    }
    
    
//    MARK:-登录按钮
    func Lbtn() {
        loginBtn.layer.cornerRadius = 5
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.titleLabel?.font = UIFont(name: "Snell Roundhand-Black", size: 20)
        loginBtn.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.5, alpha: 1)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.setTitleColor(.cyan, for: .highlighted)
        loginBtn.addTarget(self, action: #selector(signBtnAction), for: .touchUpInside)
        view.addSubview(loginBtn)
    }
    
    
//    MARK:- 注册Label
    func Mlabel()  {
        MusicLabel.font = UIFont(name: "Zapfino", size: 30)
        MusicLabel.text = "Login in"
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
    
    
//    MARK:- textfield代理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        }
    
//    MARK:- 按下按钮
    @objc func signBtnAction() {
        if password.text! == AcountController.newPassword && account.text == AcountController.newAccount {
            navigationController?.pushViewController(ViewController(), animated: true)
        }
        else {
            let alertController = UIAlertController(title: "提示!", message: "用户名或密码错误", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    @objc func findBtnAction() {
        navigationController?.pushViewController(FindController(), animated: true)
    }
}
