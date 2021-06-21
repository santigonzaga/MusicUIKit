//
//  PlaylistDetailsViewController.swift
//  MusicUIKit
//
//  Created by Santiago del Castillo Gonzaga on 21/06/21.
//

import UIKit

class PlaylistDetailsViewController: UIViewController {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var numberOfSongsLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    let musicService = try? MusicService()
    
    
    var playlist: MusicCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = playlist?.referenceDate
        let format = DateFormatter()
        format.dateFormat = "MM dd, yyyy"
        let formattedDate = format.string(from: date!)
        
        titleLabel.text = playlist?.title
        artistLabel.text = playlist?.mainPerson
        numberOfSongsLabel.text = String(playlist?.musics.count ?? 0) + " Songs"
        imageCover.image = musicService?.getCoverImage(forItemIded: playlist?.id ?? "")
        releasedLabel.text = "Released " + formattedDate
    }

}
