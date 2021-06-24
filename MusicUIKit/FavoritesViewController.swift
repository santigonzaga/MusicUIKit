//
//  FavoritesViewController.swift
//  MusicUIKit
//
//  Created by Santiago del Castillo Gonzaga on 21/06/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var noFavoritesStack: UIStackView!
    var playlistFavorites: [Music] = []
    let musicService = try? MusicService()

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        searchBar.delegate = self
        favoritesTableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: "SongCell")
        playlistFavorites = musicService?.favoriteMusics ?? []
        
        if playlistFavorites.count == 0 {
            favoritesTableView.isHidden = true
            noFavoritesStack.isHidden = false
        } else {
            favoritesTableView.isHidden = false
            noFavoritesStack.isHidden = true
        }
    }
    
    func loadFavorites() {
        guard let ms = musicService else {return}
        playlistFavorites = ms.favoriteMusics
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavorites()
        self.favoritesTableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadFavorites()
        if !playlistFavorites.isEmpty {
            self.playlistFavorites = self.playlistFavorites.filter({ music in
                return music.title.lowercased().contains(searchText.lowercased()) ||  music.artist.lowercased().contains(searchText.lowercased())
            })
            
            if playlistFavorites.isEmpty && searchText == "" {
                loadFavorites()
            }
        }
        self.favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? PlaylistDetailTableViewCell else {
            fatalError("Não foi possivel converter a celula para SongCell")
        }
        let music  = playlistFavorites[indexPath.row]
        cell.artistMusicLabel.text = music.artist
        cell.titleMusicLabel.text = music.title
        cell.imageCoverMusic.image = musicService?.getCoverImage(forItemIded: music.id )
        cell.music = music
        cell.musicService = musicService
        
        return cell
    }
    
}
