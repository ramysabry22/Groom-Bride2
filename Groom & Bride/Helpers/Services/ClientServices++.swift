
import UIKit
import Alamofire


extension ApiManager {
    
  class func listFavoriteHalls(limit: Int, offset: Int, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool, _ halls:[FavoriteHall])-> ()){
        let url = HelperData.sharedInstance.serverBasePath + EndPoints.listFavoriteHalls.rawValue
        let parameters: Parameters = [
            "limit": limit,
            "offset": offset
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "authorization": "Barear \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    let dataa = data["data"] as! [[String: Any]]
                    do {
                       if let theJSONData = try? JSONSerialization.data(withJSONObject: dataa) {
                          let halls = try JSONDecoder().decode([FavoriteHall].self, from: theJSONData)
                           completed(true, "Favorite halls loaded successfully",false, halls)
                           return
                        }
                    }catch let error {
                       print("Cant decodeeeeeee")
                       print(error)
                       completed(false, "\(error)",false, [])
                       return
                    }
                }
                else{
                    if data["refreshToken"] != nil {
                        HelperData.sharedInstance.loggedInClient.token = data["token"] as! String
                        HelperData.sharedInstance.loggedInClient.login()
                        completed(false, "Refresh token",true, [])
                        return
                    }
                    else if let errorMessage = data["message"] as? String {
                        completed(false, errorMessage, false, [])
                        return
                    }
                    else {
                        completed(false, "Unexpected Error Please Try Again In A While",false, [])
                        return
                    }
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While",false, [])
                return
            }
        }
    }
    

    
  class func addHallToFavorite(hallID: String, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool)-> ()){
        let url = HelperData.sharedInstance.serverBasePath + EndPoints.addHallToFavorite.rawValue
        let parameters: Parameters = [
            "hallId": hallID
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "authorization": "Barear \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
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
    
    
    
   class func deleteHallFromFavorite(hallID: String, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool)-> ()){
        let url = HelperData.sharedInstance.serverBasePath + EndPoints.deleteHallFromFavorite.rawValue
        let parameters: Parameters = [
            "hallId": hallID
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "authorization": "Barear \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
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
    
    
    
    
    class func rateHall(hallID: String, rating: Int, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool)-> ()){
        let url = HelperData.sharedInstance.serverBasePath + EndPoints.rateHall.rawValue
        let parameters: Parameters = [
            "hallId": hallID,
            "rating": rating
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "authorization": "Barear \(HelperData.sharedInstance.loggedInClient.token)"
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
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
