//
//  ModalPlaying.swift
//  MusicUIKit
//
//  Created by Heitor Feijó Kunrath on 24/06/21.
//

import UIKit

class ModalPlaying: UIViewController {
    
    
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var falta: UILabel!
    @IBOutlet weak var atual: UILabel!
    var music : Music?
    var musicService: MusicService?
    @IBAction func likeDislike(_ sender: Any) {
        guard let music = music, let musicService = musicService else {
            return
        }
        var isFavorite = musicService.favoriteMusics.contains(music)
        musicService.toggleFavorite(music: music, isFavorite: isFavorite)
        isFavorite = !isFavorite
        
        favoriteButton.tintColor = isFavorite ? .systemRed : .black
        favoriteButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }
    @IBAction func dismissChevron(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        musicSlider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        musicSlider.setThumbImage(UIImage(systemName: "circle.fill"), for: .highlighted)
        guard let music = music , let musicService = musicService else{

            return
            
        }
        cover.image = musicService.getCoverImage(forItemIded: music.id)
        musicName.text =  music.title
        artistName.text = music.artist
        atual.text = "00:59"
        falta.text = String("\(Int(music.length/60)):\(Int(Int(music.length)%60))")
// 
        
        let isFavorite = musicService.favoriteMusics.contains(music)

        favoriteButton.tintColor = isFavorite ? .systemRed : .black
        favoriteButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        
    }
    
    
    
    
}
