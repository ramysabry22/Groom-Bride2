
import UIKit


class HallCategory: Decodable {
    var _id: String = ""
    var name: String = ""
    
    init(hallDict: [String:Any]) {
        self._id = hallDict["_id"] as! String
        self.name = hallDict["name"] as! String
    }
}
