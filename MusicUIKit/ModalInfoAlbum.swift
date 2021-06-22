//
//  ModalInfoAlbum.swift
//  MusicUIKit
//
//  Created by Heitor Feijó Kunrath on 21/06/21.
//

import UIKit

class ModalInfoAlbum: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var albumInfoTableVIew: UITableView!
    
    
    @IBOutlet weak var dismissScreen: UIBarButtonItem!
    var playlist: MusicCollection?
    let musicService = try? MusicService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumInfoTableVIew.dataSource = self

    }
    @IBAction func dismissScreen(_ sender: Any) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row != 0 {
            guard let cell = albumInfoTableVIew.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as? InfoArtistTableViewCell else {
                fatalError("Não foi possivel converter a celula para ArtistCell")
            }
            
            cell.artistNameLabel.text = playlist?.mainPerson
            cell.textInfoLabel2.text = playlist?.albumArtistDescription
            
            return cell
        } else {
            guard let cell = albumInfoTableVIew.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? InfoAlbumTableViewCell else {
                fatalError("Não foi possivel converter a celula para AlbumCell")
            }

            let date = playlist?.referenceDate
            let format = DateFormatter()
            format.dateFormat = "MMM ddd, yyyy"
            let formattedDate = format.string(from: date!)
            
            cell.coverImage.image = musicService?.getCoverImage(forItemIded: playlist?.id ?? "")
            cell.artistLabel.text = playlist?.mainPerson
            cell.nameAlbumLabel.text = playlist?.title
            cell.numberOfSongsLabel.text = String(playlist?.musics.count ?? 0) + " Songs"
            cell.releasedLabel.text = "Released " + formattedDate
            cell.textInfoLabel.text = playlist?.albumDescription
            
            return cell
        }
    }

}
