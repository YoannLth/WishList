//
//  ItemCell.swift
//  WishList
//
//  Created by yoann lathuiliere on 29/11/2016.
//  Copyright © 2016 ylth. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

  @IBOutlet weak var thumbmailimage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  func configureCell(item: Item) {
    titleLabel.text = item.title
    priceLabel.text = "\(item.price)€"
    descriptionLabel.text = item.details
    thumbmailimage.image = item.toImage?.image as? UIImage
  }
}
