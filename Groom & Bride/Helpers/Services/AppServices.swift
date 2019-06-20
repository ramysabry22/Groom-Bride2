import UIKit
import Alamofire

extension ApiManager {
    
    func sendFeedBack(email: String, feedback: String,completed: @escaping(_ valid: Bool,_ msg: String)->()){
        self.stopAllRequests()
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
                let result = data["result"] as! Bool
                if result == true {
                   completed(true, "Feedback sent successfully")
                   return
                }else{
                    if let errorMessage = data["error"] as? String {
                      completed(false, errorMessage)
                        return
                    }else {
                      completed(false, "Unexpected Error Please Try Again In A While")
                    }
                }                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
    }
    
    
    
    
    
    func showPrivacy(completed: @escaping(_ valid: Bool,_ msg: String) -> ()){
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/policyAndPrivacy/getPolicyAndPrivacy"
        let parameters: Parameters = [
            "type" : "privacy"
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            print("**************************************************")
            print(response)
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    let privacyData = data["text"] as! String
                    completed(true, privacyData)
                    return
                }
                else{
                    completed(false, "Error loading privacy policy, try again in a while")
                }
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
    }
    
    
    
    
    func showTerms(completed: @escaping(_ valid: Bool,_ msg: String) -> ()){
        self.stopAllRequests()
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
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    let termsData = data["text"] as! String
                    completed(true, termsData)
                    return
                }
                else{
                    completed(false, "Error loading terms of service, try again in a while")
                }
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
    }
    
    
    
    
    
   
}
