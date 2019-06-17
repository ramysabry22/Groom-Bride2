import UIKit
import Alamofire

extension ApiManager {
    func sendFeedBack(email: String, feedback: String,completed: @escaping(_ valid: Bool,_ msg: String)->()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/feedback/addFeedback"
        let parameters: Parameters = [
            "email" : email,
            "text": feedback
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            print("**************************************************")
            print(response)
            
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                if  data["error"] != nil {
                    let errorMessage = data["error"] as! String
                    completed(false, errorMessage)
                    return
                }else if data["text"] != nil {
                    
                    completed(true, "Feedback sent successfully")
                }
                else{
                    completed(false, "Unexpected Error Please Try Again In A While")
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
    }
    
    
    
    
    
    func showPrivacy(completed: @escaping(_ valid: Bool,_ msg: String) -> ()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/policyAndPrivacy/getPolicyAndPrivacy"
        let parameters: Parameters = [
            "type" : "policy"
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            print("**************************************************")
            print(response)
            
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                
//                if  data["error"] != nil {
//                    let errorMessage = data["error"] as! String
//                    completed(false, errorMessage)
//                    return
//                }else if data["text"] != nil {
//                    let data = data["text"] as! String
//                    completed(true, data)
//                }
//                else{
//                    completed(false, "Unexpected Error Please Try Again In A While")
//                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
    }
    
    
    
    
    
    
    func showTerms(completed: @escaping(_ valid: Bool,_ msg: String) -> ()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/policyAndPrivacy/getPolicyAndPrivacy"
        let parameters: Parameters = [
            "type" : "service"
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            print("**************************************************")
            print(response)
            
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! NSDictionary
                
//                if  data["error"][0] != nil {
//                    let errorMessage = data["error"] as! String
//                    completed(false, errorMessage)
//                    return
//                }else if data["text"] != nil {
//                    let data = data["text"] as! String
//                    completed(true, data)
//                }
//                else{
//                    completed(false, "Unexpected Error Please Try Again In A While")
//                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
    }
    
   
}
