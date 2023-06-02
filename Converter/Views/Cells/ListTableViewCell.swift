//
//  ListTableViewCell.swift
//  Converter
//
//  Created by mozeX on 02.06.2023.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var curNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
