import UIKit


class HelperData {
    static let sharedInstance = HelperData()
    final let serverBasePath = "https://hidden-ocean-87285.herokuapp.com"
    var loggedInClient: Client = Client()
    final var registrationToken = ""
    
    private init(){}
    
}
