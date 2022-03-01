//
//  LeguesTableViewCell.swift
//  AESport
//
//  Created by Abdallah Ehab on 28/02/2022.
//

import UIKit

class LeguesTableViewCell: UITableViewCell {

    @IBOutlet weak var legueBage: UIImageView!
    @IBOutlet weak var legueName: UILabel!
  
    @IBAction func youtubeButtonPressed(_ sender: UIButton) {
        guard let url :String = self.legueName.text else{
            return
        }
                let formattedString = url.replacingOccurrences(of:" ", with: "")
                let youtubeUrl = "https://www.youtube.com/results?search_query=" + formattedString
                UIApplication.shared.openURL(NSURL(string: youtubeUrl)! as URL)
    }
    
}
