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
        if holder.subviews.count == 7 {
            configure()
        }
        
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
    
    @IBAction func changedSlider(_ sender: UISlider) {
        print(sender.value)
    }
    
    
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
