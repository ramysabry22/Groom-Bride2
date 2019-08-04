import UIKit
import Alamofire

extension ApiManager {
    
   class func sendFeedBack(email: String, feedback: String,completed: @escaping(_ valid: Bool,_ msg: String)->()){
        let url = HelperData.sharedInstance.serverBasePath + EndPoints.sendFeedBack.rawValue
        let parameters: Parameters = [
            "email" : email,
            "text": feedback
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
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
    
    
    
   class func showPrivacy(completed: @escaping(_ valid: Bool,_ msg: String) -> ()){
        let url = HelperData.sharedInstance.serverBasePath + EndPoints.showPrivacyAndTerms.rawValue
        let parameters: Parameters = [
            "type" : "privacy"
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                    let privacyDic = data["data"] as! [String : Any]
                    let privacyData = privacyDic["text"] as! String
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
    

    
   class func showTerms(completed: @escaping(_ valid: Bool,_ msg: String) -> ()){
        let url = HelperData.sharedInstance.serverBasePath + EndPoints.showPrivacyAndTerms.rawValue
        let parameters: Parameters = [
            "type" : "service"
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        publicAlamofireManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let result = data["result"] as! Bool
                if result == true {
                     let termsyDic = data["data"] as! [String : Any]
                    let termsData = termsyDic["text"] as! String
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
