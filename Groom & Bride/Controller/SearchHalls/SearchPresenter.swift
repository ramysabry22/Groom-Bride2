import UIKit
import Alamofire

protocol SearchDelegetes {
    func searchResult(halls: [Hall], valid: Bool)
    func paginateResult(halls: [Hall], valid: Bool)
}


class SearchPresenter: NSObject {
    var pagesNumber: Int = 0
    var delegete: SearchDelegetes?
    
    
    func search(searchText: String){
        ApiManager.searchHallByName(limit: 7, offset: 0, hallName: searchText) { (valid, msg, halls) in
            if valid {
                if halls.count > 0 {
                    self.delegete?.searchResult(halls: halls, valid: true)
                }
            }else {
                self.delegete?.searchResult(halls: [], valid: false)
            }
        }
    }
    
    
    
    func paginate(searchText: String){
        ApiManager.searchHallByName(limit: 7, offset: pagesNumber, hallName: searchText) { (valid, msg, halls) in
            if valid {
                if halls.count > 0 {
                   self.delegete?.paginateResult(halls: halls, valid: true)
                }
            }
        }
    }
    
}
