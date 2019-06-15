import UIKit
import Alamofire

extension ApiManager {
    
    func signUp(email: String, name: String, password: String, completed: @escaping (_ valid:Bool, _ msg:String)->()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/users/signup"
        let parameters: Parameters = [
            "userEmail" : email,
            "userName" : name,
            "userPassword" : password,
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                
                if data["error"] != nil {
                    completed(false, "User validation failed")
                    return
                }else if data["message"] != nil {
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: data["user"]!) {
                        guard let loggedInClient = try? JSONDecoder().decode(Client.self, from: theJSONData) else {
                            print("Error: Couldn't decode data into Client")
                            return
                        }
                        HelperData.sharedInstance.loggedInClient = loggedInClient
                        HelperData.sharedInstance.loggedInClient.login()
                        completed(true,"User registred sucessfully")
                        return
                    }
                
                    completed(true, "user signed up successfully")
                    return
                }
                else {
                    completed(false, "Unexpected Error Please Try Again In A While ")
                    return
                }
             
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
    }
    
    
    
    func signIn(email: String, password: String, completed: @escaping (_ valid:Bool, _ msg:String)->()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/users/signin"
        let parameters: Parameters = [
            "userEmail" : email,
            "userPassword" : password,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in

            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                
                if data["error"] != nil {
                    completed(false, "User authentication failed")
                    return
                }else if data["message"] != nil {
                    if let userData = data["user"] as? [[String:Any]] {
                       
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: userData[0]) {
                            guard let loggedInClient = try? JSONDecoder().decode(Client.self, from: theJSONData) else {
                                print("Error: Couldn't decode data into Client")
                                completed(false,"Couldn't decode data into Client")
                                return
                            }
                            HelperData.sharedInstance.loggedInClient = loggedInClient
                            HelperData.sharedInstance.loggedInClient.login()
                            completed(true,"User registred sucessfully")
                            return
                        }
                        
                    }
                    completed(true, "user signed in successfully")
                    return
                }
                else {
                    completed(false, "Unexpected Error Please Try Again In A While ")
                    return
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
    }
    
    
    
    
    func forgotPassword(email: String, completed: @escaping(_ valid: Bool,_ msg: String)->()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/users/forgetPassword"
        let parameters: Parameters = [
            "email" : email,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
        
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                if data["error"] != nil {
                    completed(false, "Authentication failed")
                    return
                }else if data["message"] != nil {
                    
                    completed(true, "Email sent to you successfully to reset your password")
                }else{
                     completed(false, "Unexpected Error Please Try Again In A While ")
                }
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
        
    }
    
    
    
}
