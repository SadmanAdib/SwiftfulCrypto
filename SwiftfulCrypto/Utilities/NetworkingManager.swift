//
//  NetworkingManager.swift
//  SwiftfulCrypto
//
//  Created by Sadman Adib on 1/10/22.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError { // by conforming to Localized Error, we can use the .localizedDescription
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from URL \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
             .subscribe(on: DispatchQueue.global(qos: .default)) // dataTaskPublisher already sibscribes to the background thread, but still doing explicitly to stay safe.
             .tryMap({ try handleURLResponse(output: $0, url: url) })
             .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher() // this converts the complex return type to AnyPublisher<Data, Error>
    }
    
    static func handleURLResponse(output:  URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
