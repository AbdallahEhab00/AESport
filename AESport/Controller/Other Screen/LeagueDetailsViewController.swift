//
//  LeagueDetailsViewController.swift
//  AESport
//
//  Created by Abdallah Ehab on 24/02/2022.
//

import UIKit
import CoreData
import SDWebImage
class LeagueDetailsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var favoritButton: UIButton!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestCollectionView: UICollectionView!
    @IBOutlet weak var temsCollectionView: UICollectionView!
    
    var isFavourit = false
    var legueName = ""
    var leguBage = ""
    var legueYoutube = ""
    var idLegues = ""
    var UpcomingDetail = [UpcomingEventData]()
    var latestEvents = [LatestEventsData]()
    var teams = [TeamsData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // print(legueName)
        
        APICaller.shared.fetchUpcomingEvent(legueName: legueName) { result in
            switch result {
            case .success(let upcomingDetail):
                self.updateUpcomingEvent(upcomnigDetail: upcomingDetail)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.fetchLatestResult(idlegue: idLegues) { result in
            switch result {
            case .success(let latestResult):
                self.updateLatestEvent(latestEvent: latestResult)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.fetchTeamsData(legueName: legueName) { result in
            switch result{
            case .success(let teamsResult):
                self.updateTeams(team: teamsResult)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
    }
    
    func updateUpcomingEvent(upcomnigDetail:[UpcomingEventData]){
        DispatchQueue.main.async {
            self.UpcomingDetail = upcomnigDetail
            self.upcomingCollectionView.reloadData()
            
        }
    }
    func updateLatestEvent(latestEvent:[LatestEventsData]){
        DispatchQueue.main.async {
            self.latestEvents = latestEvent
            self.latestCollectionView.reloadData()
        }
    }
    func updateTeams(team:[TeamsData]){
        DispatchQueue.main.async {
            self.teams = team
            self.temsCollectionView.reloadData()
        }
    }
    
    @IBAction func addFavourutButtonPressed(_ sender: UIButton) {
        saveLegue()
        DispatchQueue.main.async {
            self.updateHeartFavorit()
        }
    }
    
    func saveLegue(){
       
        let favourit = FavouritLegue(context: context)
        favourit.legueNames = legueName.replacingOccurrences(of: "%20", with: " ")
        favourit.leguebages = leguBage
        favourit.youtube = legueYoutube
        try?context.save()
    }
    func updateHeartFavorit(){
        
        if isFavourit == true{
            favoritButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favoritButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    
    @IBAction func backToLegueButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LeagueDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingCollectionView:
            return UpcomingDetail.count
        case latestCollectionView:
            return latestEvents.count
        default:
            return teams.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

                switch collectionView {
                case upcomingCollectionView:
                    let upComingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpcomingEventCollectionViewCell
                    upComingCell.upcomingDateLabel.text = "start \(UpcomingDetail[indexPath.row].dateEvent)"
                    upComingCell.upcomingImage.sd_setImage(with: URL(string: UpcomingDetail[indexPath.row].strThumb), placeholderImage: UIImage(systemName: "photo"))
                    upComingCell.layer.cornerRadius = 12
                    upComingCell.layer.borderColor = UIColor.label.cgColor
                    upComingCell.layer.borderWidth =  0.5
                       return upComingCell
                    
                case latestCollectionView:
                    let resultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "latest", for: indexPath) as! LatestResultCollectionViewCell
                    
                    resultCell.imageEvent.sd_setImage(with: URL(string: latestEvents[indexPath.row].strThumb), placeholderImage: UIImage(systemName: "photo"))
                    resultCell.latestResultLabel.text = "\(latestEvents[indexPath.row].intHomeScore) : \(latestEvents[indexPath.row].intAwayScore)"
                    resultCell.layer.cornerRadius = 10
                    resultCell.layer.borderColor = UIColor.label.cgColor
                    resultCell.layer.borderWidth =  0.5
                    
                    return resultCell
                    
                default:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tems", for: indexPath) as! TeamsCollectionViewCell
                    cell.lmageTeamLogo.sd_setImage(with: URL(string: teams[indexPath.row].strTeamLogo), placeholderImage: UIImage(systemName: "photo"))
                    cell.layer.cornerRadius = 12
                    cell.layer.borderColor = UIColor.label.cgColor
                    cell.layer.borderWidth = 0.5
                    return cell
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == temsCollectionView{
            let TeamDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            
            TeamDetailsViewController.imageLogo = teams[indexPath.row].strTeamLogo
            TeamDetailsViewController.imageStaduim = teams[indexPath.row].strStadiumThumb
            TeamDetailsViewController.imageBanner = teams[indexPath.row].strTeamBanner
            TeamDetailsViewController.teamName = teams[indexPath.row].strTeam
            TeamDetailsViewController.sportTybe = teams[indexPath.row].strSport
            TeamDetailsViewController.modalPresentationStyle = .fullScreen
            present(TeamDetailsViewController, animated:true)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // return CGSize(width: view.frame.width, height: view.frame.height/3)
        return CGSize(width: 100, height: 100)
    }
    
    
}
