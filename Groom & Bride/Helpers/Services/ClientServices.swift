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
            print(response)
            print("**************************************************")
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                
                if data["error"] != nil {
                    let errorMessage = data["error"] as! String
                    completed(false, errorMessage)
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
            print("**************************************************")
            print(response)
            
            
            
            
//            if let jsonResponse = response.result.value{
//                let data = jsonResponse as! [String : Any]
//
//                if data["error"] != nil {
//                    let errorMessage = data["error"] as! String
//                    completed(false, errorMessage)
//                    return
//                }else if data["message"] != nil {
//                    if let userData = data["user"] as? [[String:Any]] {
//
//                        if let theJSONData = try? JSONSerialization.data(withJSONObject: userData[0]) {
//                            guard let loggedInClient = try? JSONDecoder().decode(Client.self, from: theJSONData) else {
//                                print("Error: Couldn't decode data into Client")
//                                completed(false,"Couldn't decode data into Client")
//                                return
//                            }
//                            HelperData.sharedInstance.loggedInClient = loggedInClient
//                            HelperData.sharedInstance.loggedInClient.login()
//                            completed(true,"User registred sucessfully")
//                            return
//                        }
//
//                    }
//                    completed(true, "user signed in successfully")
//                    return
//                }
//                else {
//                    completed(false, "Unexpected Error Please Try Again In A While ")
//                    return
//                }
//
//            }else{
//                completed(false, "Unexpected Error Please Try Again In A While ")
//                return
//            }
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
            print("**************************************************")
            print(response)
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                if data["error"] != nil {
                    let errorMessage = data["error"] as! String
                    completed(false, errorMessage)
                    return
                }else if data["message"] != nil {
                    
                    completed(true, "Reset link sent successfully, please check your email")
                }else{
                     completed(false, "Unexpected Error Please Try Again In A While ")
                }
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
                return
            }
        }
        
    }
    
    
    func updateName(name: String, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool)-> ()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/users/updateBasicInfo"
        let parameters: Parameters = [
            "userName" : name
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
                
                if data["error"] != nil {
                    let errorMessage = data["error"] as! String
                    completed(false, errorMessage, false)
                    return
                }else if data["message"] != nil {
                    
                    completed(true, "Changes saved successfully",false)
                }else if data["refreshToken"] != nil {
                    HelperData.sharedInstance.loggedInClient.token = data["token"] as! String
                    HelperData.sharedInstance.loggedInClient.login()
                    completed(false, "Refresh token",true)
                }
                else{
                    completed(false, "Unexpected Error Please Try Again In A While",false)
                }
  
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",false)
                return
            }
        }
    }
    
    
    
    
    func changePassword(oldPassword: String, newPassword: String, reNewPassword: String, completed: @escaping(_ valid: Bool,_ msg: String,_ reRequest: Bool)-> ()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/users/setPassword"
        let parameters: Parameters = [
            "password" : oldPassword,
            "newPassword": newPassword,
            "rePassword":reNewPassword
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
                
                if  data["error"] != nil {
                    let errorMessage = data["error"] as! String
                    completed(false, errorMessage, false)
                    return
                }else if data["message"] != nil {
                    
                    completed(true, "Password changed successfully",false)
                }else if data["refreshToken"] != nil {
                    HelperData.sharedInstance.loggedInClient.token = data["token"] as! String
                    HelperData.sharedInstance.loggedInClient.login()
                    completed(false, "Refresh token",true)
                }
                else{
                    completed(false, "Unexpected Error Please Try Again In A While",false)
                }
                
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",false)
                return
            }
        }
    }
    
    
    
}
