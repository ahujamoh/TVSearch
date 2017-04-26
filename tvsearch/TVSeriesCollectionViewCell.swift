//
//  TVSeriesCollectionViewCell.swift
//  tvsearch
//
//  Created by Mohit on 24/04/17.
//  Copyright © 2017 ahujamoh. All rights reserved.
//

import UIKit

class TVSeriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvSeriesName: UILabel!
    @IBOutlet weak var tvSeriesImage: UIImageView!
    
    override func awakeFromNib() {
//        tvSeriesName.sizeToFit()
////        tvSeriesName.lineBreakMode = NSLineBreakMode.byWordWrapping;
//        tvSeriesName.numberOfLines = 0;
    }
}
