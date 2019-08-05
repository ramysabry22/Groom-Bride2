//
//  HomeProtocol.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 8/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import Foundation

protocol HomeViewProtocol: class {
    var presenter: HomePresenterProtocol? { get set }
    func dataRecived()
}

protocol HomePresenterProtocol: class {
    var view: HomeViewProtocol? { get set }
    var hallsNumberOfRows: Int { get set }
    var isFinishedPaging: Bool { get set}
    var categoriesNumberOfRows: Int { get }
    
    func fetchData(currentCell: Int)
    func configureHallCell(cell: HallCell, indexpath: IndexPath)
    func configureFilterCell(cell: FilterCell, indexpath: IndexPath)
}

protocol HomeRouterProtocol {
    
}

protocol HomeInteractorInputProtocol {
    var presenter: HomeInteractorOutputProtocol? { get set }
    func loadMoreHalls(limit: Int, offset: Int)
}

protocol HomeInteractorOutputProtocol: class {
    func hallsFetchedSuccessfully(halls: [Hall])
    func dataBassed(halls: [Hall])
}



// MARK:- Cells Protocol
protocol HomeHallsCellsVIew  {
    func configure(hall: Hall)
}

protocol CategoryCellView {
    func configure(category: HallCategory)
}


// MARK:- Passing data from onother view
protocol HomeBassDataProtocol {
    func dataRecived()
}
