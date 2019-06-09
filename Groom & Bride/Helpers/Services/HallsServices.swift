
import Foundation
import Alamofire

extension ApiManager{
    func getAllHalls(completed: @escaping (_ valid:Bool, _ msg:String, _ halls:[Hall])->())  {
        let url = "\(HelperData.sharedInstance.serverBasePath)/halls"
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .get, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [[String : Any]]
                print(jsonResponse)
                var halls = [Hall]()
                for record in data {
                    let newHall = Hall(hallDict: record)
                    halls.append(newHall)
                }
               
                completed(true,"Halls loaded successfully",halls)
            }else{
                completed(false, "Unexpected Error Please Try Again In A While ",[])
            }
        }
    }
    //.session.finishTasksAndInvalidate()
    
    
    
    
}

