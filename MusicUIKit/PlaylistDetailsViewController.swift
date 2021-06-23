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
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        print("Deleted1")
//        if let  a = playlist?.supportsEdition {
//            print("Deleted2")
//            if a {
//                if editingStyle == .delete {
//
//                    if let musicDelete = playlist?.musics[indexPath.row], let playlist = playlist {
//                        musicService?.removeMusic(musicDelete, from: playlist)
//                    }
//                    self.playlistTableView.deleteRows(at: [indexPath], with: .automatic)
//                }
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        print(playlist ?? [])
        print(playlist?.musics.count ?? 0)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            if let musicDelete = self.playlist?.musics[indexPath.row], let playlist = self.playlist {
                self.musicService?.removeMusic(musicDelete, from: playlist)
            }
            self.playlistTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        action.title = "Delete"
        action.backgroundColor = .red
        playlistTableView.reloadData()
        return action
    }
    
}
