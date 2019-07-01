

import Foundation


class Hall: Decodable {
    var _id: String? = ""
    var hallName: String? = " "
    var hallAdress: String? = ""
    var hallCategory: HallCategory?
    var hallDescription: String? = ""
    var hallRate: Double? = 0.0
    var hallRatesCounter: Double? = 0
    var hallPrice: Double? = 0
    var hallLocationLong: String?
    var hallLocationLat: String?
    var hallSpecialOffers: String?
    var hallPhoneNumber: String?
    var hallImage: [String] = []
   
    
    init(hallDict: [String:Any]) {
        self._id = hallDict["_id"] as? String ?? "0"
        self.hallName = hallDict["hallName"] as? String ?? "Empty Name"
        self.hallAdress = hallDict["hallAdress"] as? String ?? "Empty Address"
        self.hallCategory = hallDict["hallCategory"] as? HallCategory
        self.hallDescription = hallDict["hallDescription"] as? String ?? "No description for this wedding hall"
        self.hallRate = hallDict["hallsAverageRating"] as? Double ?? 0.0
        self.hallRatesCounter = hallDict["hallsRatingCounter"] as? Double ?? 0.0
        self.hallPrice = hallDict["hallPrice"] as? Double ?? 0.0
        self.hallLocationLong = hallDict["hallLocationLong"] as? String
        self.hallLocationLat = hallDict["hallLocationLat"] as? String
        self.hallSpecialOffers = hallDict["hallSpecialOffers"] as? String ?? "No special offers for this wedding hall"
        self.hallPhoneNumber = hallDict["hallPhoneNumber"] as? String
        self.hallImage = hallDict["hallImage"] as! [String]
    }
}
