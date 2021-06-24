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
    @IBOutlet weak var playlistTableView: UITableView!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    @IBOutlet weak var playingNow: playerView!
    
    var playlist: MusicCollection?
    let musicService = try? MusicService()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbumInfo"{
            let destination = segue.destination as? UINavigationController
            let modalInfoAlbum = destination?.viewControllers.first as? ModalInfoAlbum
            modalInfoAlbum?.playlist = playlist
        }
        else if segue.identifier == "toPlayingModalView" {
            guard let indexPath = sender as? IndexPath else {return}

                let destination = segue.destination as? UINavigationController
                let modalPlaying = destination?.viewControllers.first as? ModalPlaying
//            modalPlaying?.artistName.text = playlist[indexPath.row].mainPerson
          
            modalPlaying?.music = playlist?.musics[indexPath.row]
            modalPlaying?.musicService = musicService
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        self.playlistTableView.reloadData()
        if let playlist = playlist, let musicService = musicService {
            musicService.startPlaying(collection: playlist)
        }
        playingNow.coverImage.image = musicService?.getCoverImage(forItemIded: musicService?.queue.nowPlaying?.id ?? "")
        playingNow.artistName.text = musicService?.queue.nowPlaying?.artist
        playingNow.musicName.text = musicService?.queue.nowPlaying?.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.dataSource = self
        playlistTableView.delegate = self
        playlistTableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: "SongCell")
        
        let date = playlist?.referenceDate
        let format = DateFormatter()
        format.dateFormat = "MMM dd, yyyy"
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
        
        playingNow.coverImage.image = musicService?.getCoverImage(forItemIded: musicService?.queue.nowPlaying?.id ?? "")
        playingNow.artistName.text = musicService?.queue.nowPlaying?.artist
        playingNow.musicName.text = musicService?.queue.nowPlaying?.title
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let musicService = musicService, let music = playlist?.musics[indexPath.row] {
            musicService.startPlaying(music:  music)
        }
        playingNow.coverImage.image = musicService?.getCoverImage(forItemIded: musicService?.queue.nowPlaying?.id ?? "")
        playingNow.artistName.text = musicService?.queue.nowPlaying?.artist
        playingNow.musicName.text = musicService?.queue.nowPlaying?.title
        performSegue(withIdentifier: "toPlayingModalView", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return playlist?.type == .playlist
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            musicService!.removeMusic(playlist!.musics[indexPath.row] , from: playlist!)
            loadData()
            self.playlistTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func loadData(){
        guard let playlist = playlist else{return}
        let updatedPlaylist = musicService?.getCollection(id: playlist.id)
        self.playlist = updatedPlaylist
    }
}
