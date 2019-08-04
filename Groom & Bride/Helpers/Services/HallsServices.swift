
import Foundation
import Alamofire

extension ApiManager{
    
   class func listHalls(limit: Int, offset: Int,completed: @escaping (_ valid: Bool, _ msg: String, _ halls:[Hall])->())  {
        let url = "\(HelperData.sharedInstance.serverBasePath)/halls/listHalls"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let parameters: Parameters = [
            "limit": limit,
            "offset": offset
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            if let jsonResponse = response.result.value{
            let data = jsonResponse as! [String : Any]
            let result = data["result"] as! Bool
            if result == true {
               let hallsDic = data["data"] as! [[String : Any]]
                var halls = [Hall]()
                for record in hallsDic {
                    let newHall = Hall(hallDict: record)
                    halls.append(newHall)
                }
              completed(true, "Halls loaded successfully", halls)
              return
            }
            else{
                if let errorMessage = data["message"] as? String {
                    completed(false, errorMessage, [])
                    return
                }
                else {
                    completed(false, "Unexpected Error Please Try Again In A While", [])
                    return
                }
            }
                
         }else{
            completed(false, "Unexpected Error Please Try Again In A While ", [])
            return
        }
      }
    }

    
    
    
  class func searchHallByName(limit: Int, offset: Int, hallName: String ,completed: @escaping (_ valid: Bool, _ msg: String, _ halls:[Hall])->())  {
        let url = "\(HelperData.sharedInstance.serverBasePath)/halls/searchByName"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let parameters: Parameters = [
            "hallName": hallName,
            "limit": limit,
            "offset": offset
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    let hallsDic = data["data"] as! [[String : Any]]
                    var halls = [Hall]()
                    for record in hallsDic {
                        let newHall = Hall(hallDict: record)
                        halls.append(newHall)
                    }
                    completed(true, "Halls loaded successfully", halls)
                    return
                }
                else{
                    if let errorMessage = data["message"] as? String {
                        completed(false, errorMessage, [])
                        return
                    }
                    else {
                        completed(false, "Unexpected Error Please Try Again In A While", [])
                        return
                    }
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ", [])
                return
            }
        }
    }
    
    
    
    
    
   class func listhallsCategories(limit: Int, offset: Int,completed: @escaping (_ valid: Bool, _ msg: String,
        _ halls:[HallCategory])->())  {
        let url = "\(HelperData.sharedInstance.serverBasePath)/category/listCategories"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let parameters: Parameters = [
            "limit": limit,
            "offset": offset
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    let categoriesDic = data["data"] as! [[String : Any]]
                    var hallCategories = [HallCategory]()
                    for record in categoriesDic {
                        let newCategory = HallCategory(hallDict: record)
                        hallCategories.append(newCategory)
                    }
                    completed(true, "Hall categories loaded successfully",hallCategories)
                    return
                }
                else{
                    if let errorMessage = data["message"] as? String {
                        completed(false, errorMessage,[])
                        return
                    }
                    else {
                        completed(false, "Unexpected Error Please Try Again In A While",[])
                        return
                    }
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ", [])
                return
            }
        }
    }
    
    
    
    
    
  class func listHallsByCategory(limit: Int, offset: Int, categoryID: String ,completed: @escaping (_ valid: Bool, _ msg: String, _ halls:[Hall])->())  {
        let url = "\(HelperData.sharedInstance.serverBasePath)/halls/searchByCategory"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let parameters: Parameters = [
            "hallCategory": categoryID,
            "limit": limit,
            "offset": offset
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    let hallsDic = data["data"] as! [[String : Any]]
                    var halls = [Hall]()
                    for record in hallsDic {
                        let newHall = Hall(hallDict: record)
                        halls.append(newHall)
                    }
                    completed(true, "Halls loaded successfully", halls)
                    return
                }
                else{
                    if let errorMessage = data["message"] as? String {
                        completed(false, errorMessage, [])
                        return
                    }
                    else {
                        completed(false, "Unexpected Error Please Try Again In A While", [])
                        return
                    }
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ", [])
                return
            }
        }
    }
    
    
    
    
}

