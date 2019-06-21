
import UIKit
import Alamofire


extension ApiManager {
    
    func listFavoriteHalls(limit: Int, offset: Int, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool, _ halls:[Hall])-> ()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/favorites/listFavorites"
        let parameters: Parameters = [
            "limit": limit,
            "offset": offset
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "authorization": "Barear \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print("**************************************************")
            print(response)
            var halls = [Hall]()
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    let hallsDic = data["data"] as! [[String : Any]]
                    for record in hallsDic {
                        let newHall = Hall(hallDict: record)
                        halls.append(newHall)
                    }
                    completed(true, "Favorite halls loaded successfully",false, halls)
                    return
                }
                else{
                    if data["refreshToken"] != nil {
                        HelperData.sharedInstance.loggedInClient.token = data["token"] as! String
                        HelperData.sharedInstance.loggedInClient.login()
                        completed(false, "Refresh token",true, halls)
                        return
                    }
                    else if let errorMessage = data["message"] as? String {
                        completed(false, errorMessage, false, halls)
                        return
                    }
                    else {
                        completed(false, "Unexpected Error Please Try Again In A While",false, halls)
                        return
                    }
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",false, halls)
                return
            }
        }
    }
    
    
    
    
    func addHallToFavorite(hallID: String, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool)-> ()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/favorites/addToFavorites"
        let parameters: Parameters = [
            "hallId": hallID
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "authorization": "Barear \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            print("**************************************************")
            print(response)
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    completed(true, "Hall added to favorite successfully",false)
                    return
                }
                else{
                    if data["refreshToken"] != nil {
                        HelperData.sharedInstance.loggedInClient.token = data["token"] as! String
                        HelperData.sharedInstance.loggedInClient.login()
                        completed(false, "Refresh token",true)
                        return
                    }
                    else if let errorMessage = data["message"] as? String {
                        completed(false, errorMessage, false)
                        return
                    }
                    else {
                        completed(false, "Unexpected Error Please Try Again In A While",false)
                        return
                    }
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",false)
                return
            }
        }
    }
    
    
    
    func deleteHallFromFavorite(hallID: String, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool)-> ()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/favorites/deleteFromFavorites"
        let parameters: Parameters = [
            "hallId": hallID
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "authorization": "Barear \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            print("**************************************************")
            print(response)
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    completed(true, "Hall removed from favorite successfully",false)
                    return
                }
                else{
                    if data["refreshToken"] != nil {
                        HelperData.sharedInstance.loggedInClient.token = data["token"] as! String
                        HelperData.sharedInstance.loggedInClient.login()
                        completed(false, "Refresh token",true)
                        return
                    }
                    else if let errorMessage = data["message"] as? String {
                        completed(false, errorMessage, false)
                        return
                    }
                    else {
                        completed(false, "Unexpected Error Please Try Again In A While",false)
                        return
                    }
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",false)
                return
            }
        }
    }
    
    
    
    
    func rateHall(hallID: String, rating: Int, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool)-> ()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/rating/rateHalls"
        let parameters: Parameters = [
            "hallId": hallID,
            "rating": rating
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "authorization": "Barear \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            print("**************************************************")
            print(response)
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    completed(true, "Hall rated successfully",false)
                    return
                }
                else{
                    if data["refreshToken"] != nil {
                        HelperData.sharedInstance.loggedInClient.token = data["token"] as! String
                        HelperData.sharedInstance.loggedInClient.login()
                        completed(false, "Refresh token",true)
                        return
                    }
                    else if let errorMessage = data["message"] as? String {
                        completed(false, errorMessage, false)
                        return
                    }
                    else {
                        completed(false, "Unexpected Error Please Try Again In A While",false)
                        return
                    }
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",false)
                return
            }
        }
    }
    
    
    
    
    
}
