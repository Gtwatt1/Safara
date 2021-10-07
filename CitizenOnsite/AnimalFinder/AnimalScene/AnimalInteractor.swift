//
//  AnimalInteractor.swift
//  CitizenOnsite
//
//  Created by Godwin Olorunshola on 2021-10-03.
//  Copyright © 2021 gabe. All rights reserved.
//

import Foundation

protocol AnimalInteractorProtocol {
    func fetchDogs()
}
class AnimalInteractor: AnimalInteractorProtocol {
    var service: AnimalServiceProtocol?
    var presenter: AnimalPresenterProtocol?
    
    func fetchDogs() {
        let myGroup = DispatchGroup()
        service?.fetchDogBreeds { [weak self] (result: Result<Breed, DogError>) in
            var dogsViewModel = [DogViewModel]()
            switch result {
            case .success(let breed):
                breed.message.forEach { breed in
                    myGroup.enter()
                    self?.fetchDogDetails(breed: breed) { (result: Result<Dog, DogError>) in
                        myGroup.leave()
                        switch result {
                        case .success(let dog):
                            dogsViewModel.append( DogViewModel(dogImage: dog.message, dogName: breed))
                        case .failure(_):
                            break
                        }
                    }
                }
            case .failure(_):
                break
            }
            
            myGroup.notify(queue: .main) {
                self?.presenter?.presentDogs(dogsViewModel)
            }
        }
    }
    
    private func fetchDogDetails(breed: String, completion: @escaping (Result<Dog, DogError>) -> Void) {
        service?.fetchDog(breed: breed, completion: completion)
    }
}
