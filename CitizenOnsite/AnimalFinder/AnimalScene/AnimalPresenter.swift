//
//  AnimalPresenter.swift
//  CitizenOnsite
//
//  Created by Godwin Olorunshola on 2021-10-03.
//  Copyright © 2021 gabe. All rights reserved.
//

import Foundation

protocol AnimalPresenterProtocol {
    func presentDogs(_ dogs: [DogViewModel])
    func presentError(_ error: Error)
}

class AnimalPresenter: AnimalPresenterProtocol {
    weak var view: AnimalDisplayLogic?
    func presentDogs(_ dogs: [DogViewModel]) {
        view?.displayDogs(dogs)
    }
    
    func presentError(_ error: Error) {
        view?.displayError(error)
    }
    
}

struct DogViewModel {
    let dogImage: String
    let dogName: String
}
