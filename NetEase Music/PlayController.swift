//
//  NetMusicTab.swift
//  NetEase Music
//
//  Created by phoenix Dai on 2020/2/8.
//  Copyright © 2020 phoenix Dai. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

//MARK:- 获取反色
extension UIColor {
    func invertColor() -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: nil)
        return UIColor(red:1.0-r, green: 1.0-g, blue: 1.0-b, alpha: 1)
    }
}

class PlayController: UIViewController {
    
    static var Line: Int = 0
    var Cover: UIImageView = UIImageView(frame: CGRect(x: 7, y: 100, width: 400, height: 400))
    let playbtn = UIButton(frame: CGRect(x: 150, y: 700, width: 100, height: 100))
    let prebtn = UIButton(frame: CGRect(x: 60, y: 710, width: 80, height: 80))
    let nextbtn = UIButton(frame: CGRect(x: 260, y: 710, width: 80, height: 80))
    let upbtn = UIButton(frame: CGRect(x: 140, y: 800, width: 20, height: 20))
    let downbtn = UIButton(frame: CGRect(x: 240, y: 800, width: 20, height: 20))
    
    
    
    var Clicktimes: Int = 0
    var playbackSlider: UISlider!
    var playTime: UILabel!

    
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Top_backgroundimage = UIImage.init(named: "TopBack")
        view.layer.contents = Top_backgroundimage?.cgImage
        navigationItem.title = LocalController.LocalMusicArray[PlayController.Line][0]
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 35),
             NSAttributedString.Key.foregroundColor: UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1)]
        
        
        let path = Bundle.main.path(forResource: LocalController.LocalMusicArray[PlayController.Line][0], ofType: "mp3")
        let pathURL=NSURL(fileURLWithPath: path!)
       
        Cover.image = #imageLiteral(resourceName: "tempImage")
        
        playerItem = AVPlayerItem(url: pathURL as URL)
        player = AVPlayer(playerItem: playerItem!)
        
    
        playbackSlider = UISlider(frame: CGRect(x: 50, y: 650, width: 300, height: 50))
        playbackSlider.minimumTrackTintColor = UIColor.orange
        playbackSlider.maximumTrackTintColor = UIColor.white
        playTime = UILabel(frame: CGRect(x: 175, y: 600, width: 50, height: 30))
        let duration: CMTime = playerItem!.asset.duration
        let seconds: Float64 = CMTimeGetSeconds(duration)
        playbackSlider!.minimumValue = 0
        playbackSlider!.maximumValue = Float(seconds)
        playbackSlider!.isContinuous = false
        playbackSlider.addTarget(self, action:#selector(sliderDidchange), for: UIControl.Event.valueChanged)
        
        
        sliderAction()
        
        
        playbtn.layer.cornerRadius = 50
        playbtn.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.6, alpha: 1)
        playbtn.setTitle("play", for: .normal)
        playbtn.setTitleColor(playbtn.backgroundColor?.invertColor(),for: .normal)
        playbtn.addTarget(self, action: #selector(play), for: .touchUpInside)
        
        prebtn.layer.cornerRadius = 40
        prebtn.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.7, alpha: 1)
        prebtn.setBackgroundImage(UIImage(named: "prev"), for: .normal)
        prebtn.layer.masksToBounds = true
        prebtn.setTitleColor(prebtn.backgroundColor?.invertColor(),for: .normal)
        prebtn.addTarget(self, action: #selector(prevAction), for: .touchUpInside)
    
        nextbtn.layer.cornerRadius = 40
        nextbtn.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.7, alpha: 1)
        nextbtn.setBackgroundImage(UIImage(named: "next"), for: .normal)
        nextbtn.layer.masksToBounds = true
        nextbtn.setTitleColor(prebtn.backgroundColor?.invertColor(),for: .normal)
        nextbtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        upbtn.layer.cornerRadius = 5
        upbtn.backgroundColor = .white
        upbtn.setTitle("+", for: .normal)
        upbtn.titleLabel?.font = UIFont(name: "boldSystemFont", size: 10)
        upbtn.setTitleColor(.black, for: .normal)
        upbtn.addTarget(self, action: #selector(upbtnAction), for: .touchUpInside)
        
        downbtn.layer.cornerRadius = 5
        downbtn.backgroundColor = .white
        downbtn.setTitle("-", for: .normal)
        downbtn.titleLabel?.font = UIFont(name: "boldSystemFont", size: 10)
        downbtn.setTitleColor(.black, for: .normal)
        downbtn.addTarget(self, action: #selector(downbtnAction), for: .touchUpInside)
        
        self.view.addSubview(prebtn)
        self.view.addSubview(nextbtn)
        self.view.addSubview(playbtn)
        self.view.addSubview(playTime)
        self.view.addSubview(playbackSlider)
        self.view.addSubview(Cover)
        self.view.addSubview(upbtn)
        self.view.addSubview(downbtn)
       
    }
    

//    MARK:- 播放函数
    @objc func play(){
        if player?.rate == 0 {
                  player?.play()
                  playbtn.setTitle("pause", for: .normal)
              } else {
                  player?.pause()
                  playbtn.setTitle("play", for: .normal)
              }
        setInfoCenterCredentials(playbackState: 0)
    }
    
    
//    MARK:- 滑块随时间变化
    func sliderAction() {
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1),queue: DispatchQueue.main) { (CMTime) -> Void in
                    if self.player!.currentItem?.status == .readyToPlay && self.player?.rate != 0 {
        //更新进度条进度值
                        let currentTime = CMTimeGetSeconds(self.player!.currentTime())
                        self.playbackSlider?.value = Float(currentTime)
                     
        //一个小算法，来实现00：00这种格式的播放时间
                        let all:Int=Int(currentTime)
                        let m:Int=all % 60
                        let f:Int=Int(all/60)
                        var time:String=""
                        if f<10{
                            time="0\(f):"
                        }else {
                            time="\(f)"
                        }
                        if m<10{
                            time+="0\(m)"
                        }else {
                            time+="\(m)"
                        }
        //更新播放时间
                        self.playTime.text=time
                        self.setInfoCenterCredentials(playbackState: 1)
                    }
                }
    }
    
//    MARK:- 滑块移动响应
    @objc func sliderDidchange(){
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        //播放器定位到对应的位置
        player!.seek(to: targetTime)
        //如果当前时暂停状态，则自动播放
        if player!.rate == 0
            {
                player?.play()
                playbtn.setTitle("pause", for: .normal)
        }
    }
    
    
//   MARK:- 页面打开时开始监听
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(finishedPlaying),
        name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        UIApplication.shared.beginReceivingRemoteControlEvents()
        self.becomeFirstResponder()
    }
    
    
//MARK:- 页面消失时取消歌曲播放结束通知监听
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        UIApplication.shared.endReceivingRemoteControlEvents()
        self.resignFirstResponder()
    }
    
    
//    MARK:- 播放结束后的响应
    @objc func finishedPlaying(myNotification:NSNotification) {
            print("播放完毕!")
            let stopedPlayerItem = myNotification.object as! AVPlayerItem
            stopedPlayerItem.seek(to: CMTime.zero, completionHandler: nil)
            playbtn.setTitle("play", for: .normal)
            nextAction()
       }
   
    
//   MARK:- 能否成为第一响应者
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
//    MARK:- 后台的数据
    func setInfoCenterCredentials(playbackState: Int) {
        let mpic = MPNowPlayingInfoCenter.default()
         
        //专辑封面
        let mySize = CGSize(width: 400, height: 400)
        let albumArt = MPMediaItemArtwork(boundsSize:mySize) { sz in
            return UIImage(named: "tempImage")!
        }
         
        //获取进度
        let postion = Double(self.playbackSlider!.value)
        let duration = Double(self.playbackSlider!.maximumValue)
         
        mpic.nowPlayingInfo = [MPMediaItemPropertyTitle: LocalController.LocalMusicArray[PlayController.Line][0],
                               MPMediaItemPropertyArtist: LocalController.LocalMusicArray[PlayController.Line][1],
                               MPMediaItemPropertyArtwork: albumArt,
                               MPNowPlayingInfoPropertyElapsedPlaybackTime: postion,
                               MPMediaItemPropertyPlaybackDuration: duration,
                               MPNowPlayingInfoPropertyPlaybackRate: playbackState]
    }
    
    
//    MARK:- 后台的动作响应
    override func remoteControlReceived(with event: UIEvent?) {
        guard let event = event else {
            print("no event\n")
            return
        }
         
        if event.type == UIEvent.EventType.remoteControl {
            switch event.subtype {
            case .remoteControlTogglePlayPause:
                print("暂停/播放")
            case .remoteControlPreviousTrack:
                print("上一首")
            case .remoteControlNextTrack:
                print("下一首")
            case .remoteControlPlay:
                print("播放")
                player!.play()
            case .remoteControlPause:
                print("暂停")
                player!.pause()
                //后台播放显示信息进度停止
                setInfoCenterCredentials(playbackState: 0)
            default:
                break
            }
        }
    }
    
    
//    MARK:- 声音减小
    @objc func downbtnAction() {
        if(player!.volume >= Float(0.0)) {
            player?.volume -= 0.1
        }
        else{}
    }
    
    
//    MARK:- 声音增大
    @objc func upbtnAction() {
        player?.volume += 0.1
    }

    
// MARK:- 前一首
    @objc func prevAction() {
        if PlayController.Line > 0 {
            player?.pause()
            PlayController.Line -= 1
            navigationItem.title = LocalController.LocalMusicArray[PlayController.Line][0]
            let path = Bundle.main.path(forResource: LocalController.LocalMusicArray[PlayController.Line][0], ofType: "mp3")
            let pathURL = NSURL(fileURLWithPath: path!)
            playerItem = AVPlayerItem(url: pathURL as URL)
            player = AVPlayer(playerItem: playerItem!)
            sliderAction()
            playbtn.setTitle("pause", for: .normal)
            player?.play()
        }
        else {}
    }
    
    
//    MARK:- 后一首
    @objc func nextAction() {
        if PlayController.Line < LocalController.LocalMusicArray.count {
            player?.pause()
            PlayController.Line += 1
            
            navigationItem.title = LocalController.LocalMusicArray[PlayController.Line][0]
            let path = Bundle.main.path(forResource: LocalController.LocalMusicArray[PlayController.Line][0], ofType: "mp3")
            let pathURL = NSURL(fileURLWithPath: path!)
            playerItem = AVPlayerItem(url: pathURL as URL)
            player = AVPlayer(playerItem: playerItem!)
            sliderAction()
            playbtn.setTitle("pause", for: .normal)
            player?.play()
           }
           else {}
       }
    
    
}
