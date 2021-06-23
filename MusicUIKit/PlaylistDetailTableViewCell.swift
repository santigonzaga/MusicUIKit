//
//  PlaylistDetailTableViewCell.swift
//  MusicUIKit
//
//  Created by Santiago del Castillo Gonzaga on 21/06/21.
//

import UIKit

class PlaylistDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCoverMusic: UIImageView!
    @IBOutlet weak var titleMusicLabel: UILabel!
    @IBOutlet weak var artistMusicLabel: UILabel!
    @IBOutlet weak var favorite: UIButton!
    var music: Music?
    var musicService: MusicService?
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        guard let music = music, let musicService = musicService else {
            return
        }
        var isFavorite = musicService.favoriteMusics.contains(music)
        musicService.toggleFavorite(music: music, isFavorite: isFavorite)
        isFavorite = !isFavorite
        
        favorite.tintColor = isFavorite ? .systemRed : .black
        favorite.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        guard let music = music, let musicService = musicService else {
            return
        }
        let isFavorite = musicService.favoriteMusics.contains(music)

        favorite.tintColor = isFavorite ? .systemRed : .black
        favorite.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }
}
