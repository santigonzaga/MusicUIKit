//
//  playerView.swift
//  MusicUIKit
//
//  Created by Heitor Feijó Kunrath on 24/06/21.
//

import UIKit

class playerView: UIView {
    
    var play: Bool = true
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let nib = UINib(nibName: "player", bundle: .main)
        let contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView// carregando outlets
        addSubview(contentView)
        
        self.contentView = contentView// !
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    
    @IBAction func playButton(_ sender: UIButton) {
        play.toggle()
        
        playButton.setImage(play ? UIImage(systemName: "pause.circle.fill") : UIImage(systemName: "play.circle.fill"), for: .normal)
    }
}
