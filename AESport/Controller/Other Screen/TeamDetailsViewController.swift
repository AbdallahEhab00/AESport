//
//  TeamDetailsViewController.swift
//  AESport
//
//  Created by Abdallah Ehab on 24/02/2022.
//

import UIKit
import SDWebImage
class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var stadiumImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var teamNamelabel: UILabel!
    @IBOutlet weak var sportTybeLabel: UILabel!
    
    var teamName:String = ""
    var sportTybe:String = ""
    
    var imageStaduim:String = ""
    var imageLogo:String = ""
    var imageBanner:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stadiumImage.sd_setImage(with: URL(string: imageStaduim), placeholderImage: UIImage(systemName: "photo"))
        logoImage.sd_setImage(with: URL(string: imageLogo), placeholderImage: UIImage(systemName: "photo"))
        bannerImage.sd_setImage(with: URL(string: imageBanner), placeholderImage: UIImage(systemName: "photo"))

        teamNamelabel.text = teamName
        sportTybeLabel.text = sportTybe

    }
    
    @IBAction func backToDetailsButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
