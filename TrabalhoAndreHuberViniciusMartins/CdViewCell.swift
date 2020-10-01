//
//  CdViewCell.swift
//  TrabalhoAndreHuberViniciusMartins
//
//  Created by COTEMIG on 29/09/20.
//  Copyright © 2020 AndreHuberViniciusMartins. All rights reserved.
//

import UIKit

class CdViewCell: UITableViewCell {

    @IBOutlet weak var cdImage: UIImageView!
    @IBOutlet weak var cdName: UILabel!
    @IBOutlet weak var cdDescription: UILabel!
    @IBOutlet weak var cdPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
