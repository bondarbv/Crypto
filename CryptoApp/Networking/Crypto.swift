//
//  Crypto.swift
//  CryptoApp
//
//  Created by Bohdan on 05.06.2022.
//

import Foundation

struct Crypto: Codable {
    let symbol, lastPrice, priceChangePercent: String?
    
    init?(cryptoData: CryptoData) {
        symbol = cryptoData.symbol
        lastPrice = cryptoData.lastPrice
        priceChangePercent = cryptoData.priceChangePercent
    }
}
