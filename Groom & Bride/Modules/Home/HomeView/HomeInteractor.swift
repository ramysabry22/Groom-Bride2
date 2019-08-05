//
//  HomeInteractor.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 8/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol, HomeBassDataProtocol{
    
   weak var presenter: HomeInteractorOutputProtocol?
    
    func loadMoreHalls(limit: Int, offset: Int) {
        ApiManager.listHalls(limit: limit, offset: offset) { (valid, msg, halls) in
            if valid{
                if halls.count > 0 {
                    self.presenter?.hallsFetchedSuccessfully(halls: halls)
                }
            }else{
                
            }
        }
    }
    
    func dataRecived() {
        print("data recived %%%%%")
    }
    
    
    
}
