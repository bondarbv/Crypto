//
//  CryptoNetworkManager.swift
//  CryptoApp
//
//  Created by Bohdan on 05.06.2022.
//

import Foundation

final class CryptoNetworkManager {
    
    func performRequest(pair: String, completionHandler: @escaping (Crypto) -> Void) {
    guard let url = URL(string: "https://www.binance.com/api/v3/ticker/24hr?symbol=\(pair)") else { return }
    let request = URLRequest(url: url)
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: request) { data, response, error in
        if let data = data {
            if let crypto = self.parseJSON(with: data) {
                completionHandler(crypto)
            }
        }
    }
    task.resume()
}

private func parseJSON(with data: Data) -> Crypto? {
    let decoder = JSONDecoder()
    
    do {
        let cryptoData = try decoder.decode(CryptoData.self, from: data)
        guard let crypto = Crypto(cryptoData: cryptoData) else { return nil }
        return crypto
        
    } catch let error as NSError {
        print(String(describing: error))
    }
    return nil
}
}
