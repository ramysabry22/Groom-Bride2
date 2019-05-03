import UIKit

class Client: Decodable {
    var _id: String = ""
    var userName: String = ""
    var userEmail: String = ""
   // var token: String = ""
    
    fileprivate func constructDict() -> [String:Any]{
        return ["userName":self.userName,
                "userEmail":self.userEmail,
                "_id":self._id]
    }
    func login() {
        let dict = self.constructDict()
        defaults.set(dict, forKey: "loggedInClient")
    }
}
