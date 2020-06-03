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
    
    
    private let albumImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.numberOfLines = 0
        return Label
    }()
    
    private let artistNameLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.numberOfLines = 0
        return Label
    }()
    
    let playPauseButton = UIButton()
    
    @IBOutlet weak var holder: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let song = songs[position]
        
        
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
            
            //음악 볼륨 50% 설정
            player.volume = 0.5
            
            
            //뷰가 생성되었을때 음악 재생
            player.play()
            
            //앨범 이미지 위치 지정
            albumImage.frame = CGRect(x: 10, y: 10, width: holder.frame.size.width-20, height: holder.frame.size.width-20)
            //앨범 이미지 설정
            albumImage.image = UIImage(named: song.elbumImage)
            
            //앨범이미지 뷰에 추가
            holder.addSubview(albumImage)
            
            //노래이름 위치 지정
            songNameLabel.frame = CGRect(x: 10, y: albumImage.frame.size.height + 10, width: holder.frame.size.width-20, height: 70)
            //노래 이름 설정
            songNameLabel.text = song.name
            
            //가수명 위치 지정
            artistNameLabel.frame = CGRect(x: 10, y: albumImage.frame.size.height + 10 + 70, width: holder.frame.size.width-20, height: 70)
            artistNameLabel.text = song.artistName
            
            //노래이름 라벨 뷰에 추가
            holder.addSubview(songNameLabel)
            //가수명 라벨 뷰에 추가
            holder.addSubview(artistNameLabel)
            
            //음악 컨트롤러
            let nextButton = UIButton()
            let backButton = UIButton()
            
            //image
            playPauseButton.setBackgroundImage(UIImage(named: "play_circle_filled-24px.fill"), for: .normal)
            nextButton.setBackgroundImage(UIImage(named: "fast_forward-24px.fill"), for: .normal)
            backButton.setBackgroundImage(UIImage(named: "fast_rewind-24px.fill"), for: .normal)
            
            //frme
            let yPosision = artistNameLabel.frame.origin.y + 70 + 20
            let size: CGFloat = 50
            
            playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0, y: yPosision, width: size, height: size)

            nextButton.frame = CGRect(x: holder.frame.size.width - size - 20 , y: yPosision, width: size, height: size)

            backButton.frame = CGRect(x: 20, y: yPosision, width: size, height: size)

            
            
            //add action
            playPauseButton.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
            nextButton.addTarget(self, action: #selector(nextPlayMusic), for: .touchUpInside)
            backButton.addTarget(self, action: #selector(backPlayMusic), for: .touchUpInside)
            
            playPauseButton.tintColor = .black
            nextButton.tintColor = .black
            backButton.tintColor = .black
            
            
            holder.addSubview(playPauseButton)
            holder.addSubview(nextButton)
            holder.addSubview(backButton)
            
            //슬라이더 추가
            let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height - 60, width: holder.frame.size.width-40, height: 50 ))
            
            slider.value = 0.5
            slider.addTarget(self, action: #selector(didslideSlider(_:)), for: .valueChanged)
            holder.addSubview(slider)
            
        }catch {
            print("error")
        }
        
    }

    @objc func didslideSlider(_ slider: UISlider) {
         let value = slider.value
         player?.volume = value
     }
    
    @objc func playMusic() {
        if player?.isPlaying == true {
            player?.pause()
            
            playPauseButton.setBackgroundImage(UIImage(named: "pause_circle_filled-24px.fill"), for: .normal)
        }else{
            player?.play()
            
            playPauseButton.setBackgroundImage(UIImage(named: "play_circle_filled-24px.fill"), for: .normal)
        }
    }
    
    @objc func backPlayMusic() {
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func nextPlayMusic() {
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
    
    //MARK:- TODO: 슬라이더 값 가져오기랑 다음 음악과 이전 음악으로 넘어가는 코드 작성하기
    
    @IBAction func changedSlider(_ sender: UISlider) {
        print(sender.value)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
            
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
