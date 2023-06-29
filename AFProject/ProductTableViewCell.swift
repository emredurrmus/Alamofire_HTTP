//
//  ProductTableViewCell.swift
//  AFProject
//
//  Created by Emre Durmuş on 27.06.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var imgNameLbl: UIImageView!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
