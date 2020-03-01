//
//  APIService.swift
//  MVVMPlayground
//
//  Created by Madhur Jain on 29/02/2019.


import Foundation


let baseURL = "https://api.500px.com/v1/photos?feature=popular"

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchPopularPhoto( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
    // Simulate a long waiting for fetching
   func fetchPopularPhoto( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: APIError? )->() ) {
    guard let url = URL(string: baseURL) else {return}
      URLSession.shared.dataTask(with: url){(data , _ , _) in
          guard let data = data else {return}
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .iso8601
          let photos = try! decoder.decode(Photos.self, from: data)
        complete(true, photos.photos! , nil)
          print("Completed fetching json")
      }.resume()
    }
    
    
    
}







