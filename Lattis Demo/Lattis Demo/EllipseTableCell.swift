//
//  EllipseTableCell.swift
//  Lattis SDK Demo
//
//  Created by Ravil Khusainov on 8/14/18.
//  Copyright © 2018 Lattis Inc. All rights reserved.
//

import UIKit
import LattisSDK

class EllipseTableCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var connectedLabel: UILabel!
    
    var ellipse: Ellipse! {
        didSet {
            titleLabel.text = ellipse.name
            connectedLabel.isHidden = ellipse.isPaired == false
        }
    }
}
