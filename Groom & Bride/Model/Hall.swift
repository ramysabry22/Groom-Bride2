

import Foundation


class Hall: Decodable {
    var _id: String = ""
    var hallName: String = ""
    var hallAdress: String = ""
    var hallCategory: HallCategory?
    var hallDescription: String = ""
    var hallPrice: Float?
    var hallLocationLong: String?
    var hallLocationLat: String?
    var hallSpecialOffers: String?
    var hallImage: [String] = []
    
    init(hallDict: [String:Any]) {
        self._id = hallDict["_id"] as! String
        self.hallName = hallDict["hallName"] as! String
        self.hallAdress = hallDict["hallAdress"] as! String
        self.hallCategory = hallDict["hallCategory"] as? HallCategory
        self.hallDescription = hallDict["hallDescription"] as! String
        self.hallPrice = hallDict["hallPrice"] as? Float
        self.hallLocationLong = hallDict["hallLocationLong"] as? String
        self.hallLocationLat = hallDict["hallLocationLat"] as? String
        self.hallSpecialOffers = hallDict["hallSpecialOffers"] as? String
        self.hallImage = hallDict["hallImage"] as! [String]
    }
}
