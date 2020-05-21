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
    
    @IBOutlet weak var holder: UIView!
    /*
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
     */
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
        if holder.subviews.count == 0 {
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
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else { return }
            print("music play!")
            player.play()
            
        }catch {
            print("error")
        }
        /*
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.width - 20,
                                      height: holder.frame.width - 20)
        albumImageView.image = UIImage(named: song.elbumImage)
        holder.addSubview(albumImageView)
        
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 10,
                                     width: holder.frame.width - 20,
                                     height: 70)
       
        
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height+10+70,
                                       width: holder.frame.width-20,
                                       height: 70)
        songNameLabel.text = song.name
        artistNameLabel.text = song.artistName
        
        holder.addSubview(songNameLabel)
    
        holder.addSubview(artistNameLabel)
 */
        
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
