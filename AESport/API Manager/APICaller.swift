//
//  APICaller.swift
//  AESport
//
//  Created by Abdallah Ehab on 24/02/2022.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    private init(){}
    
    enum apiErorr:Error {
        case faildTogetSportsData
        case specificSportError
    }
    struct Constant {
        static let basUrl = "https://www.thesportsdb.com/api/v1/json/2/"
    }
    
    public func getAllSports(completion:@escaping(Result<[SportsData],Error>)->Void){
        createRequest(url:URL(string: Constant.basUrl+"all_sports.php")) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , erorr in
                
                guard let data = data , erorr == nil else{
                    completion(.failure(apiErorr.faildTogetSportsData))
                    return
                }
                do
                {
//      let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    let result = try JSONDecoder().decode(SportsModel.self, from: data)
                  //print(result)
                    completion(.success(result.sports))
                }catch{
                    completion(.failure(apiErorr.faildTogetSportsData))
                }
               
            }
            task.resume()
        }
    }
    
    func fetchSpecificSport(sportName:String,completion:@escaping(Result<[SpecificSportData],Error>)->Void){
        //  https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=Soccer

        createRequest(url:URL(string: Constant.basUrl+"search_all_leagues.php?s=\(sportName)") ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data , error == nil else {
                    completion(.failure(apiErorr.specificSportError))
                    return
                }
                do{

   // let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
 //print(result)
                    let result = try JSONDecoder().decode(SpecificSportModel.self, from: data)
                    completion(.success(result.countrys))
        
                }catch{
                    completion(.failure(apiErorr.faildTogetSportsData))
                    
                }
                
            
            }
            task.resume()
        }
        
    }
    
    private func createRequest(url:URL?,completion:(URLRequest)->Void){
        guard let apiUrl = url else{
            return
        }
        let request = URLRequest(url: apiUrl)
        completion(request)
    }
    
}
