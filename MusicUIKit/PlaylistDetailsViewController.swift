//
//  PlaylistDetailsViewController.swift
//  MusicUIKit
//
//  Created by Santiago del Castillo Gonzaga on 21/06/21.
//

import UIKit

class PlaylistDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var numberOfSongsLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    let musicService = try? MusicService()
    @IBOutlet weak var playlistTableView: UITableView!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    
    var playlist: MusicCollection?
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbumInfo"{
            let destination = segue.destination as? UINavigationController
            let modalInfoAlbum = destination?.viewControllers.first as? ModalInfoAlbum
            modalInfoAlbum?.playlist = playlist
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.dataSource = self
        playlistTableView.delegate = self
//        playlistTableView.isHidden = true
        playlistTableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: "SongCell")
        
        let date = playlist?.referenceDate
        let format = DateFormatter()
        format.dateFormat = "MMM ddd, yyyy"
        let formattedDate = format.string(from: date!)
        
        titleLabel.text = playlist?.title
        artistLabel.text = playlist?.mainPerson
        numberOfSongsLabel.text = String(playlist?.musics.count ?? 0) + " Songs"
        imageCover.image = musicService?.getCoverImage(forItemIded: playlist?.id ?? "")
        releasedLabel.text = "Released " + formattedDate
        if let  a = playlist?.supportsEdition {
            if a {
                infoButton.image = nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.musics.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = playlistTableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? PlaylistDetailTableViewCell else {
            fatalError("Não foi possivel converter a celula para SongCell")
        }
        let music  = playlist?.musics[indexPath.row]
        cell.artistMusicLabel.text = music?.artist
        cell.titleMusicLabel.text = music?.title
        cell.imageCoverMusic.image = musicService?.getCoverImage(forItemIded: music?.id ?? "")
        cell.music = music
        cell.musicService = musicService 
        
        return cell
    }
}
