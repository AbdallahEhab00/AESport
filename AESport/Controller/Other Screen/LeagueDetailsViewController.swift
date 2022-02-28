//
//  LeagueDetailsViewController.swift
//  AESport
//
//  Created by Abdallah Ehab on 24/02/2022.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewTwo: UICollectionView!
    @IBOutlet weak var collectionViewThree: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
extension LeagueDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
}
