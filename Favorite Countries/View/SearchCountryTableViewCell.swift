//
//  SearchCountryTableViewCell.swift
//  Favorite Countries
//
//  Created by AJ Batja on 4/6/21.
//

import UIKit

class SearchCountryTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ country: Country){
        name.text = country.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
