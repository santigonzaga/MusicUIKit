//
//  ViewController.swift
//  MusicUIKit
//
//  Created by Santiago del Castillo Gonzaga on 18/06/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableOfLibrary: UITableView!
    let musicService = try? MusicService()
    var playlist: [MusicCollection] = []
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOfLibrary.dataSource = self
        tableOfLibrary.delegate = self
        playlist = musicService?.loadLibrary() ?? []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableOfLibrary.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as? LibraryTableViewCell else {
            fatalError("Não foi possivel converter a celula para libraryCell")
        }
        
        let music = playlist[indexPath.row]
        cell.libraryImageView.image = musicService?.getCoverImage(forItemIded: music.id)
        cell.libraryTitleLabel.text = music.title
        cell.librarySubtitleLabel.text = music.type.rawValue.capitalized + " - " + music.mainPerson
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPlaylistDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaylistDetails", let indexPath = sender as? IndexPath {
            let destination = segue.destination as? PlaylistDetailsViewController
            destination?.playlist = playlist[indexPath.row]
        }
    }

}

