
import Foundation


enum EndPoints: String {
    case listHalls = "/halls/listHalls"
    case searchHallByName = "/halls/searchByName"
    case listhallsCategories = "/category/listCategories"
    case listHallsByCategory = "/halls/searchByCategory"
    
    case signUp = "/users/signup"
    case signIn = "/users/signin"
    case forgotPassword = "/users/forgetPassword"
    case updateName = "/users/updateBasicInfo"
    case changePassword = "/users/updatePassword"
    
    case listFavoriteHalls = "/favorites/listFavorites"
    case addHallToFavorite = "/favorites/addToFavorites"
    case deleteHallFromFavorite = "/favorites/deleteFromFavorites"
    case rateHall = "/rating/rateHalls"
    
    case sendFeedBack = "/feedback/addFeedback"
    case showPrivacyAndTerms = "/policyAndPrivacy/getPolicyAndPrivacy"    
}
