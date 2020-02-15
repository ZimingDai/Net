//
//  AccountView.swift
//  NetEase Music
//
//  Created by phoenix Dai on 2020/2/13.
//  Copyright © 2020 phoenix Dai. All rights reserved.
//

import UIKit

class AccountView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var AccountImage = UIImageView(frame: CGRect(x: 130, y: 180, width: 150, height: 150))
    var colorSwitch = UISwitch(frame: CGRect(x: 350, y: 100, width: 50, height: 50))
    let viewcontroller = ViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.contents = UIImage(named: "account")?.cgImage
        AccountImage.layer.borderWidth = 0.5
        AccountImage.layer.borderColor = UIColor.black.cgColor
        AccountImage.layer.cornerRadius = 75
        AccountImage.layer.masksToBounds = true
        AccountImage.image = UIImage(named: "moren")
        AccountImage.clipsToBounds = true
        AccountImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(tapGesture:)))
        AccountImage.addGestureRecognizer(tapGesture)
        
        
        colorSwitch.addTarget(self, action: #selector(SwitchOn), for: .valueChanged)
        view.addSubview(AccountImage)
        view.addSubview(colorSwitch)
    }
    
    
//    MARK:- 提示
    @objc func tapAction(tapGesture: UITapGestureRecognizer) {
           let alertController = UIAlertController(title: "更改头像", message: nil,
                                                   preferredStyle: .actionSheet)
           let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
           let photoAction = UIAlertAction(title: "相册选取", style: .default) { (_) in
               self.getPhoto()
           }
           let cameraAction = UIAlertAction(title: "拍照", style: .default) { (_) in
               self.takePic()
           }
           alertController.addAction(cancelAction)
           alertController.addAction(photoAction)
           alertController.addAction(cameraAction)
           self.present(alertController, animated: true, completion: nil)
       }

    
//    MARK:- 获取照片
    func getPhoto() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("相册不可用")
            return
        }
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
      }
    
    
//    MARK:- 相机
 func takePic() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alertController = UIAlertController(title: "⚠️", message: "相机不可用", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确定", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let takePic = UIImagePickerController()
        takePic.allowsEditing = true
        takePic.sourceType = .camera
        takePic.delegate = self
        present(takePic, animated: true, completion: nil)
    }
    
    
//    MARK:- 代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        AccountImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        AccountImage.contentMode = .scaleAspectFill
        AccountImage.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    @objc func SwitchOn() {
        if colorSwitch.isOn == false {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.backgroundColor = UIColor.white
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = .black
                self.viewcontroller.view.layer.contents = UIImage(named: "TopBack2")?.cgImage
            })
        }
    }
}
