//
//  CollectionCell.swift
//  ShopifyApplicationHarrison
//
//  Created by Harrison U-Ebili  on 2019-01-19.
//  Copyright © 2019 com.Harrisonhcue. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {

    @IBOutlet var txtProdName:UILabel!
    @IBOutlet var txtProdInventory:UILabel!
    @IBOutlet var txtCollectionTitle:UILabel!
    @IBOutlet var collectionImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
