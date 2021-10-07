//
//  ApiClient.swift
//  CitizenOnsite
//
//  Created by Godwin Olorunshola on 2021-10-03.
//  Copyright © 2021 gabe. All rights reserved.
//

import Foundation
protocol ApiClient {
    func execute<T: Codable>(_ urlString: String, completion: @escaping (Result<T, DogError>) -> Void)
}
class ApiClientImpl: ApiClient {
    func execute<T: Codable>(_ urlString: String, completion: @escaping (Result<T, DogError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.apiError(error.localizedDescription)))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}

enum DogError: Error {
    case apiError(String)
    case decodingError
}
