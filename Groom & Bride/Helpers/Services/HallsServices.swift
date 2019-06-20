
import Foundation
import Alamofire

extension ApiManager{
    func getAllHalls(completed: @escaping (_ valid:Bool, _ msg:String, _ halls:[Hall])->())  {
        self.stopAllRequests()
        let url = "\(HelperData.sharedInstance.serverBasePath)/halls/listHalls"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let parameters: Parameters = [
            "limit": "2",
            "offset": "0"
        ]
        Alamofire.request(url, method: .post, parameters: nil, headers: headers).responseJSON { (response) in
            print("****************************************")
            print(response)
//            if let jsonResponse = response.result.value{
//                let data = jsonResponse as! [[String : Any]]
//                print(jsonResponse)
//                var halls = [Hall]()
//                for record in data {
//                    let newHall = Hall(hallDict: record)
//                    halls.append(newHall)
//                }
//
//                completed(true,"Halls loaded successfully",halls)
//            }else{
//                completed(false, "Unexpected Error Please Try Again In A While ",[])
//            }
        }
    }
    //.session.finishTasksAndInvalidate()
    
    
    
    
}

