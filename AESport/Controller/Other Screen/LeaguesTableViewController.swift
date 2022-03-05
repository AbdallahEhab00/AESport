//
//  LeaguesTableViewController.swift
//  AESport
//
//  Created by Abdallah Ehab on 24/02/2022.
//

import UIKit
import SDWebImage
class LeaguesTableViewController: UITableViewController {
    
    var sportsName:String = ""
    var sportLegues = [SpecificSportData]()
    var eventLegues = [UpcomingEventData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sportsName)
        
        APICaller.shared.fetchSpecificSport(sportName: sportsName) { result in
            switch result{
            case .success(let legues):
                self.updatUI(sportLegues: legues)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        print(sportLegues.count)
    }
    
    func updatUI(sportLegues:[SpecificSportData]){
        DispatchQueue.main.async {
            self.sportLegues = sportLegues
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sportLegues.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "legueCell", for: indexPath)as!LeguesTableViewCell
        cell.legueYoutubeName = sportLegues[indexPath.row].strYoutube
        cell.legueName.text = sportLegues[indexPath.row].strLeague
        cell.legueBage.image = UIImage(systemName: "photo") // sportLegues[indexPath.row]
        cell.legueBage.sd_setImage(with: URL(string: sportLegues[indexPath.row].strBadge), placeholderImage: UIImage(systemName: "photo"))
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.shadowColor = UIColor.secondarySystemBackground.cgColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVc = self.storyboard?.instantiateViewController(withIdentifier: "detailsVc")as! LeagueDetailsViewController
        let urlAppend = sportLegues[indexPath.row].strLeague.replacingOccurrences(of: " ", with: "%20")
        detailsVc.legueName = urlAppend
        detailsVc.idLegues = sportLegues[indexPath.row].idLeague
        detailsVc.leguBage = sportLegues[indexPath.row].strBadge
        detailsVc.legueYoutube = sportLegues[indexPath.row].strBadge

        
      //navigationController?.pushViewController(detailsVc, animated: true)
        detailsVc.modalPresentationStyle = .fullScreen
        present(detailsVc, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
