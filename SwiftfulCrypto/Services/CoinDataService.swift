//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Sadman Adib on 30/9/22.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable? // not a set as we need to address this single cancellable if we want to cancel the CoinDataService only. Else, we would cancel all the subscriptions which would store in this cancellable set.
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        
//      After refactoring to make it reusable
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel() // we cancel this after updating allCoins as the response is only one time response. So no need to keep listening for further responses in that url.
            })
        
//        Before refactoring to make it reusable
//        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
//             .subscribe(on: DispatchQueue.global(qos: .default)) // dataTaskPublisher already sibscribes to the background thread, but still doing explicitly to stay safe.
//             .tryMap { (output) -> Data in
//                 guard let response = output.response as? HTTPURLResponse,
//                       response.statusCode >= 200 && response.statusCode < 300 else {
//                     throw URLError(.badServerResponse)
//                 }
//                 return output.data
//             }
//             .receive(on: DispatchQueue.main)
//             .decode(type: [CoinModel].self, decoder: JSONDecoder())
//             .sink { (completion) in
//                 switch completion {
//                 case .finished:
//                     break
//                 case .failure(let error):
//                     print(error.localizedDescription)
//                 }
//             } receiveValue: { [weak self] (returnedCoins) in
//                 self?.allCoins = returnedCoins
//                 self?.coinSubscription?.cancel() // we cancel this after updating allCoins as the response is only one time response. So no need to keep listening for further responses in that url.
//             }
        
    }
}
