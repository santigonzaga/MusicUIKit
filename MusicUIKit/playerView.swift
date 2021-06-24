//
//  playerView.swift
//  MusicUIKit
//
//  Created by Heitor Feijó Kunrath on 24/06/21.
//

import UIKit

class playerView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var labelTest: UILabel!
    
    
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
    
    
    
}
