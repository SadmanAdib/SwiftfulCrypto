//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Sadman Adib on 22/10/22.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .sink { (returnedCoinDetails) in
                print("Recieved Coin Detail Data")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
    
}
