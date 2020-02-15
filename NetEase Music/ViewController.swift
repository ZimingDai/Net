//
//  ViewController.swift
//  NetEase Music
//
//  Created by phoenix Dai on 2020/1/22.
//  Copyright © 2020 phoenix Dai. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

class ViewController: UIViewController {
    var LikeButton = UIButton()
    var BenButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()


        let Top_backgroundimage = UIImage.init(named: "TopBack3")
        view.layer.contents = Top_backgroundimage?.cgImage
        Navigation_bar()
        Like()
        Ben()
        Navigation_button()
    }
    
    
//    MARK:- 我喜欢按钮
    func Like() {
        LikeButton.setBackgroundImage(UIImage(named: "Like"), for: .normal)
        view.addSubview(LikeButton)
        LikeButton.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(115)
            make.height.equalTo(140)
            make.centerX.equalTo(80)
            make.centerY.equalTo(400)
           
        }
        LikeButton.layer.cornerRadius = 15
        LikeButton.layer.masksToBounds = true
        
    }
//    MARK:- 本地音乐按钮
    func Ben() {
        BenButton.setBackgroundImage(UIImage(named: "gedan1"), for: .normal)
        view.addSubview(BenButton)
        BenButton.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(115)
            make.height.equalTo(140)
            make.centerX.equalTo(210)
            make.centerY.equalTo(400)
           
        }
        BenButton.addTarget(self,action:#selector(jumpToPlay),for:.touchUpInside)
        BenButton.layer.cornerRadius = 15
        BenButton.layer.masksToBounds = true
        
    }
    
    
//    MARK:- 导航栏
    func Navigation_bar() {
        self.navigationItem.title = "我的"
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28),
             NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
//    MARK:- 用户按钮
    func Navigation_button() {
        let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        
        button1.setBackgroundImage(UIImage(named: "yonghu"), for: .normal)
        button1.layer.cornerRadius = 25
        button1.layer.masksToBounds = true
        let barButton1 = UIBarButtonItem(customView: button1)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -10
        button1.addTarget(self, action: #selector(jumpToAccount), for: .touchUpInside)
        self.navigationItem.rightBarButtonItems = [spacer,barButton1]
    }
    
    
    @objc func jumpToPlay(){
           navigationController?.pushViewController(LocalController(), animated: true)
       }
        
    @objc func jumpToAccount() {
        navigationController?.pushViewController(AccountView(), animated: true)
    }
}

