//
//  ViewModel.swift
//  FlowCoordinators
//
//  Created by Elvin Bearden on 3/12/19.
//  Copyright © 2019 Setec Astronomy. All rights reserved.
//

protocol ViewModel {
    
}

protocol TableViewModel: ViewModel {
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
}
