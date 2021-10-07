//
//  AnimalService.swift
//  CitizenOnsite
//
//  Created by Godwin Olorunshola on 2021-10-03.
//  Copyright © 2021 gabe. All rights reserved.
//

import Foundation

protocol AnimalServiceProtocol {
    func fetchDogBreeds(completion: @escaping (Result<Breed, DogError>) -> Void)
    func fetchDog(breed: String, completion: @escaping (Result<Dog, DogError>) -> Void)
}

struct AnimalService: AnimalServiceProtocol {
    let apiclient: ApiClient
    func fetchDogBreeds(completion: @escaping (Result<Breed, DogError>) -> Void) {
        apiclient.execute(StringConstants.dogBreedURL, completion: completion)
    }
    
    func fetchDog(breed: String, completion: @escaping (Result<Dog, DogError>) -> Void) {
        let urlString = String(format: StringConstants.dogURL, breed)
        apiclient.execute(urlString, completion: completion)
    }
}


enum StringConstants {
    static let dogBreedURL = "https://dog.ceo/api/breeds/list"
    static let dogURL = "https://dog.ceo/api/breed/%@/images/random"
}
