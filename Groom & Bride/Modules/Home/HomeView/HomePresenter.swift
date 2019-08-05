//
//  HomePresenter.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 8/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol, HomeInteractorOutputProtocol {
    
    weak var view: HomeViewProtocol?
    private let interactor: HomeInteractorInputProtocol?
    private let router: HomeRouterProtocol?
    private var allHalls = [Hall]()
    private let limit: Int = 8
    private var offset: Int = 0
    var isFinishedPaging: Bool = true
    var hallsNumberOfRows: Int = 0
    
    var categoriesNumberOfRows: Int {
        return categories.count
    }
    
    let categories: [HallCategory] = {
        let cat1 = HallCategory(_id: "0", name: "All", image: "AllICON777.png")
        let cat2 = HallCategory(_id: "5d0cbfc9a758321414bf9871", name: "Hotel", image: "HotelICON777")
        let cat3 = HallCategory(_id: "5d0cbfc9a758321414bf9872", name: "Club", image: "ClubICON777")
        let cat4 = HallCategory(_id: "5d0cbfc9a758321414bf9875", name: "Open Air", image: "OpenAirICON777")
        let cat5 = HallCategory(_id: "5d0cbfc9a758321414bf9873", name: "Yacht", image: "YachtICON777")
        let cat6 = HallCategory(_id: "5d0cbfc9a758321414bf9874", name: "Villa", image: "VillaICON777")
        let cat7 = HallCategory(_id: "5d1214f4de675f000488d442", name: "Individual", image: "IndividualICON777")
        return [cat1,cat2,cat3,cat4,cat5,cat6,cat7]
    }()
    
    init(view: HomeViewProtocol, interactor: HomeInteractorInputProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func fetchData(currentCell: Int) {
        if isFinishedPaging && currentCell >= allHalls.count {
            isFinishedPaging = false
             interactor?.loadMoreHalls(limit: self.limit, offset: self.offset)
        }
    }
    
    func configureHallCell(cell: HallCell, indexpath: IndexPath) {
        let rowCell = allHalls[indexpath.row]
        cell.configure(hall: rowCell)
    }
    
    func configureFilterCell(cell: FilterCell, indexpath: IndexPath) {
        let rowCell = categories[indexpath.row]
        cell.configure(category: rowCell)
    }
    
    func hallsFetchedSuccessfully(halls: [Hall]){
        // we got data ....
    
        self.allHalls.append(contentsOf: halls)
        hallsNumberOfRows = allHalls.count
        view?.dataRecived()
        offset += 1
        isFinishedPaging = true
    }
    
    
    func dataBassed(halls: [Hall]) {
        print("data basseddddd \n ")
        self.allHalls = halls
    }
    
}
