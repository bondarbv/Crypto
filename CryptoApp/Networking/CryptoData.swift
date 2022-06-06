//
//  CryptoData.swift
//  CryptoApp
//
//  Created by Bohdan on 05.06.2022.
//

import Foundation

struct CryptoData: Codable {
    let symbol, lastPrice, priceChangePercent: String?
}

