import UIKit
import Alamofire

extension ApiManager {
    func updateFCM(token: String, completed: @escaping (_ valid:Bool, _ msg:String)->()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/updateUser"
        let parameters: Parameters = [
            "token" : token,
            ]
        let headers: HTTPHeaders = [
//            "token": HelperData.sharedInstance.loggedInClient.token,
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let valid = data["valid"] as! Bool
                if valid{
                    completed(true,data["message"] as! String)
                }
                completed(false,data["message"] as! String)
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ")
            }
        }
    }
    
    
    
    func registerNewClient(email: String, name: String, password: String, completed: @escaping (_ valid:Bool, _ msg:String)->()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/users/signup"
        let parameters: Parameters = [
            "userEmail" : email,
            "userName" : name,
            "userPassword" : password,
            "fcmToken": HelperData.sharedInstance.FCM_TOKEN,
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
    
    
    
    func loginClient(email: String, password: String, completed: @escaping (_ valid:Bool, _ msg:String)->()){
        let url = "\(HelperData.sharedInstance.serverBasePath)/users/signin"
        let parameters: Parameters = [
            "userEmail" : email,
            "userPassword" : password,
            "fcmToken": HelperData.sharedInstance.FCM_TOKEN,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in

            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                print(data)
                
                if data["error"] != nil {
                    completed(false, "User authentication failed")
                    return
                }else if data["message"] != nil {
                    if let userData = data["user"] as? [[String:Any]] {
                       
                        if let theJSONData = try? JSONSerialization.data(withJSONObject: userData[0]) {
                            guard let loggedInClient = try? JSONDecoder().decode(Client.self, from: theJSONData) else {
                                print("Error: Couldn't decode data into Client")
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
    
    
    
    
    
    
    
}


//                    do {
//                        let  jsonData = try JSONSerialization.data(withJSONObject: data["hall"]!)
//                        let jsonString = String(data: jsonData, encoding: .utf8)
//
//                        //here dataResponse received from a network request
//                        let decoder = JSONDecoder()
//                        let model = try decoder.decode(Client.self, from:
//                            jsonData) //Decode JSON Response Data
//                        print(model)
//                        return
//                    } catch let parsingError {
//                        print("Error", parsingError)
//                        return
//                    }
