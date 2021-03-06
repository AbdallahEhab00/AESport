//
//  SportsCollectionViewController.swift
//  AESport
//
//  Created by Abdallah Ehab on 24/02/2022.
//

import UIKit
import SDWebImage
private let reuseIdentifier = "item"

class SportsCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout{

    private var models = [SportsData]()
    private let indector = UIActivityIndicatorView()

    override func viewDidLoad() {
        title = "Sports"
        
        super.viewDidLoad()
        indector.style = .large
        indector.center = self.view.center
        indector.color = .systemGreen
        self.view.addSubview(indector)
        indector.startAnimating()
        collectionView.layer.cornerRadius = 5
        collectionView.layer.shadowColor = UIColor.label.cgColor
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.secondarySystemBackground.cgColor

        APICaller.shared.getAllSports { result in

            switch result {
            case .success(let model):
                
                self.updateUI(with: model)

            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
            
        }
        
    }
    
    func updateUI(with model : [SportsData]){
        DispatchQueue.main.async {
            self.models = model
            self.indector.stopAnimating()
            self.collectionView.reloadData()
        }
       
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print(models.count)

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return models.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportsCollectionViewCell
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.contentView.clipsToBounds = true
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.label.cgColor
        cell.sportName.text = models[indexPath.row].strSport
        cell.sportImage.sd_setImage(with: URL(string: models[indexPath.row].strSportIconGreen), placeholderImage: UIImage(systemName: "photo"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:120, height: 130)
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leguesVC = storyboard?.instantiateViewController(withIdentifier: "legVc")as!LeaguesTableViewController
        leguesVC.sportsName = models[indexPath.row].strSport
        navigationController?.pushViewController(leguesVC, animated: true)
    }
    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    

}
