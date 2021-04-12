//
//  MainViewControllerTableViewCell.swift
//  Favorite Countries
//
//  Created by AJ Batja on 4/10/21.
//

import UIKit

class MainViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ country: Country){
        name.text = country.name
        detail.text = country.favoriteDetails
    }

}
