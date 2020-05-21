//
//  ViewController.swift
//  MusicP
//
//  Created by Terry on 2020/05/19.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView?
    
    var songs = [song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        config()
    }
    
    func config(){
        
        songs.append(song(name: "songName1", elbumImage: "cover1", artistName: "artistName1",trackName: "song1"))
        songs.append(song(name: "songName2", elbumImage: "cover1", artistName: "artistName2",trackName: "song2"))
        songs.append(song(name: "songName3", elbumImage: "cover1", artistName: "artistName3",trackName: "song3"))
        songs.append(song(name: "songName4", elbumImage: "cover1", artistName: "artistName4",trackName: "song4"))
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artistName
        
        cell.textLabel?.font = UIFont(name: "Helvetica-bold", size: 18 )
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 15)
        cell.imageView?.image = UIImage(named: song.elbumImage)
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "second") as? SecondViewController else { return }
        
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
//        (vc, sender: nil)
    }
}

    struct song {
        var name: String
        var elbumImage: String
        var artistName: String
        var trackName: String
    }

