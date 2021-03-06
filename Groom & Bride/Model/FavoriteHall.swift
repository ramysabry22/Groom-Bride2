

import Foundation


struct FavoriteHall: Decodable {
    var _id: String
    var userId: String
    var hallId: HallID
}

struct HallID: Decodable {
    var hallsAverageRating: Double? = 0.0
    var hallsRatingCounter: Double? = 0.0
    var _id: String?
    var hallName: String? = "Empty Name"
    var hallCategory: HallCategory?
    var hallAdress: String? = "Empty Address"
    var hallDescription: String? = "No description for this wedding hall"
    var hallPrice: Double? = 0.0
    var hallLocationLong: String?
    var hallLocationLat: String?
    var hallSpecialOffers: String? = "No special offers for this wedding hall"
    var hallPhoneNumber: String?
    let hallImage: [String]
}
