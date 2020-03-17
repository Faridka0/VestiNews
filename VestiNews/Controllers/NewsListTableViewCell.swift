//
//  NewsListTableViewCell.swift
//  VestiNews
//
//  Created by Фарид Гулиев on 17.03.2020.
//  Copyright © 2020 Фарид Гулиев. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsPubDate: UILabel!
    @IBOutlet weak var newsCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
