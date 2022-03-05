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
  
    var legueYoutubeName:String = ""
    
    @IBAction func youtubeButtonPressed(_ sender: UIButton) {
        
        let finalUrl = "https://\(legueYoutubeName)"
        if let url = URL(string: finalUrl){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)

        }

        
//        guard let url :String = self.legueName.text else{
//            return
//        }
//
//                let formattedString = url.replacingOccurrences(of:" ", with: "")
//                let youtubeUrl = "https://www.youtube.com/results?search_query=" + formattedString
//               // UIApplication.shared.openURL(NSURL(string: youtubeUrl)! as URL)
    }
    
  //  import sfsafari
//    guard let url = URL(string: urlString)else{
//        return
//    }
//    let vc = SFSafariViewController(url: url)
//    present(vc, animated: true)
//
}
