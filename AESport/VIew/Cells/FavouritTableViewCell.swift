//
//  FavouritTableViewCell.swift
//  AESport
//
//  Created by Abdallah Ehab on 02/03/2022.
//

import UIKit

class FavouritTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLegue: UIImageView!
    @IBOutlet weak var legueNameLabel: UILabel!
 
    
    @IBAction func youtubeButtonPressed(_ sender: Any) {
        
        
        
        guard let url :String = self.legueNameLabel.text else{
            return
        }
        let formattedString = url.replacingOccurrences(of:" ", with: "")
        let youtubeUrl = "https://www.youtube.com/results?search_query=" + formattedString
        UIApplication.shared.openURL(NSURL(string: youtubeUrl)! as URL)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
}

