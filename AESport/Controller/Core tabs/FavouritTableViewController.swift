//
//  FavouritTableViewController.swift
//  AESport
//
//  Created by Abdallah Ehab on 02/03/2022.
//

import UIKit
import CoreData
import SDWebImage
class FavouritTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favLegues =  [FavouritLegue]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       fetchFavouritLegue()
        
        
    }
    
//    func retriveData(with request:NSFetchRequest<FavouritLegue> = FavouritLegue.fetchRequest() , predicate:NSPredicate? = nil ){
//       let favPredicate = NSPredicate(format: "FavouritLegue.legueNames MATCHES %@", "BTCC")
//
//        if let validPredicte = predicate {
//            let mixPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [favPredicate,validPredicte])
//            request.predicate = mixPredicate
//        }else{
//            request.predicate = favPredicate
//        }
//
//        do{
//            favLegues = try context.fetch(request)
//        }catch{
//            print("error in load item in context Cor Data\(error)")
//        }
//        tableView.reloadData()
//    }
    
    
    func fetchFavouritLegue(){
        do{
           favLegues = try context.fetch(FavouritLegue.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }catch{
            print(error.localizedDescription)
        }
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favLegues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritTableViewController", for: indexPath) as! FavouritTableViewCell
        cell.imageLegue.sd_setImage(with: URL(string: favLegues[indexPath.row].leguebages ?? ""), placeholderImage: UIImage(systemName: "photo"))
        cell.legueNameLabel.text = favLegues[indexPath.row].legueNames
       // cell.textLabel?.text = favLegues[indexPath.row].legueNames
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.shadowColor = UIColor.secondarySystemBackground.cgColor
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

   

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(favLegues[indexPath.row])
            favLegues.remove(at: indexPath.row)
            save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
          
        }    
    }
    
    func save(){
        do{
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
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
