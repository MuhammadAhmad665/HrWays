//
//  MovieCVC.swift
//  Fenix
//
//  Created by Ahmed on 02/04/2022.
//

import UIKit

class MovieCVC: UICollectionViewCell {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!{
        didSet{
            imgPoster.layer.cornerRadius = 5
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
