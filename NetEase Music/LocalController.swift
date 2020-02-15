//
//  LocalController.swift
//  NetEase Music
//
//  Created by phoenix Dai on 2020/2/9.
//  Copyright © 2020 phoenix Dai. All rights reserved.
//

import UIKit

class LocalController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    
    static var LocalMusicArray:[[String]] = [["万古生香", "三无"], ["夜行少女", "花近"], ["疑心病", "任然"], ["心生七面", "三无"], ["忘与忘川", "叶里"], ["一话一世界", "群星"]]
    var tableview = UITableView()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Top_backgroundimage = UIImage.init(named: "TopBack")
        view.layer.contents = Top_backgroundimage?.cgImage
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height+100)
        view.addSubview(scrollView)
        
        navigationItem.title = "本地音乐"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 28),
             NSAttributedString.Key.foregroundColor: UIColor(red: 0.1, green: 0.4, blue: 0.5, alpha: 1)]
        self.navigationController?.navigationBar.barTintColor = .green
        navigationItem.prompt = "共\(LocalController.LocalMusicArray.count)首歌"
        
        Tableview()
        
        let longPress =  UILongPressGestureRecognizer(target:self,
                         action:#selector(tableviewCellLongPressed(gestureRecognizer:)))
        longPress.delegate = self
        longPress.minimumPressDuration = 1.0
        self.tableview.addGestureRecognizer(longPress)
    }
    
    
//    MARK:- 表格
    func Tableview(){
        tableview.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height+100)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 60
        tableview.rowHeight = UITableView.automaticDimension
         self.tableview.register(MyTableViewCell.self, forCellReuseIdentifier: "cell")
        scrollView.addSubview(tableview)
    }
    
//    MARK:- 分区
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalController.LocalMusicArray.count
    }
    
    
//    MARK:- 代理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.text = LocalController.LocalMusicArray[indexPath.row][0]
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        cell.detailTextLabel?.text = LocalController.LocalMusicArray[indexPath.row][1]
        cell.detailTextLabel?.textColor = UIColor(red: 0.1, green: 0.4, blue: 0.5, alpha: 0.7)
        cell.detailTextLabel?.font = .italicSystemFont(ofSize: 15)
        
        return cell
    }
    
//    MARK:- 选择
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(PlayController(), animated: true)
        PlayController.Line = indexPath.row
    }
    
    
    @objc func tableviewCellLongPressed(gestureRecognizer:UILongPressGestureRecognizer)
    {
        if (gestureRecognizer.state == UIGestureRecognizer.State.ended) {
            print("UIGestureRecognizerStateEnded")
            //在正常状态和编辑状态之间切换
            if(self.tableview.isEditing == false){
                self.tableview.setEditing(true, animated:true)
            }
            else{
                self.tableview.setEditing(false, animated:true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath != destinationIndexPath {
            let itemValue:[String] = LocalController.LocalMusicArray[sourceIndexPath.row]
            LocalController.LocalMusicArray.remove(at: sourceIndexPath.row)
            if destinationIndexPath.row > LocalController.LocalMusicArray.count {
                LocalController.LocalMusicArray.append(itemValue)
            }
            else {
                LocalController.LocalMusicArray.insert(itemValue, at: destinationIndexPath.row)
            }
        }
        tableView.reloadData()
    }
}


//    MARK:- 负颜色
class MyTableViewCell: UITableViewCell {
    override var frame: CGRect{
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 15
            frame.size.width -= 2 * 17
            super.frame = frame
        }
    }
}
