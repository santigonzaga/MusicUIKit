//
//  ModalInfoAlbum.swift
//  MusicUIKit
//
//  Created by Heitor Feijó Kunrath on 21/06/21.
//

import UIKit

class ModalInfoAlbum: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var numberOfSongs: UILabel!
    @IBOutlet weak var band: UILabel!
    @IBOutlet weak var album: UILabel!
    @IBOutlet weak var releasedIn: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
