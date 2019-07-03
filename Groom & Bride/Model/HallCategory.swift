
import UIKit


struct HallCategory: Decodable {
    var _id: String?
    var name: String?
    var image: String?
}


extension HallCategory {
    
     init(hallDict: [String: Any]) {
        self._id = hallDict["_id"] as? String
        self.name = hallDict["name"] as? String
    }
    
}
