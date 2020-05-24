//
//  SecondViewController.swift
//  MusicP
//
//  Created by Terry on 2020/05/19.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    public var position:Int = 0
    public var songs : [song] = []
    
    var player: AVAudioPlayer?
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var slier: UISlider!
    @IBOutlet weak var rewind: UIButton!
    @IBOutlet weak var playbtn: UIButton!
    @IBOutlet weak var nextbtn: UIButton!
    
    
    @IBOutlet weak var holder: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let song = songs[position]
        
        self.albumImage.image = UIImage(named: song.elbumImage)
        self.songName.text = song.name
        self.artistName.text = song.artistName
        
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(holder.subviews.count)
//        if holder.subviews.count == 7 {
            configure()
//        }
        
    }
    
    func configure(){
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                print("urlString is nil")
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                print("player is nil")
                return }
            
              self.albumImage.image = UIImage(named: song.elbumImage)
            self.albumImage.image = UIImage(named: song.elbumImage)
                  self.songName.text = song.name
                  self.artistName.text = song.artistName
            holder.addSubview(albumImage)
            holder.addSubview(self.songName)
            holder.addSubview(self.artistName)
            holder.addSubview(nextbtn)
            
            player.play()
            
        }catch {
            print("error")
        }
        
        
    }
    @IBAction func playMusic(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected{
            if let player = player{
                player.stop()
            }
        }else{
            if let player = player {
                player.play()
            }
        }
    }
    
    @IBAction func backPlayMusic() {
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @IBAction func nextPlayMusic(_ sender: Any) {
        print("positino : \(position), songs.count: \(songs.count), holder.subview.count: \(holder.subviews.count)")
        if position < (songs.count - 1 ) {
                  position = position + 1
                  player?.stop()
                  for subview in holder.subviews{
                      subview.removeFromSuperview()
                  }
                  configure()
              }
    }
    
    @IBAction func changedSlider(_ sender: UISlider) {
        print(sender.value)
//        sender.addTarget(self, action: #selector(getter: player?.isPlaying), for: .valueChanged)
        if sender.isTracking { return }
        self.player?.currentTime = TimeInterval(sender.value)
        
    }
    //MARK:- TODO: 슬라이더 값 가져오기랑 다음 음악과 이전 음악으로 넘어가는 코드 작성하기
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.play()
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
