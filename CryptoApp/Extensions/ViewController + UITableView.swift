//
//  ViewController + UITableView.swift
//  CryptoApp
//
//  Created by Bohdan on 06.06.2022.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.id) as? CustomTableViewCell else { return UITableViewCell() }
        networkManager.performRequest(pair: currencies[indexPath.row]) { crypto in
            DispatchQueue.main.async {
                cell.selectionStyle = .none
                cell.cryptoImageView.image = UIImage(named: crypto.symbol!)
                cell.name.text = crypto.symbol
                cell.lastPrice.text = "\(String(format: "%.03f", Double(crypto.lastPrice!)!))$"
                
                if crypto.priceChangePercent!.prefix(1) == "-" {
                    cell.view.backgroundColor = #colorLiteral(red: 0.9642285705, green: 0.2769336402, blue: 0.3640719056, alpha: 1)
                    cell.priceChangePercent.text = "\(String(format: "%.02f", Double(crypto.priceChangePercent!)!))%"
                } else {
                    cell.priceChangePercent.text = "+\(String(format: "%.02f", Double(crypto.priceChangePercent!)!))%"
                    cell.view.backgroundColor = #colorLiteral(red: 0.05226563662, green: 0.7961232662, blue: 0.5048202872, alpha: 1)
                }
                
                let i = cell.name.text?.index(cell.name.text!.endIndex, offsetBy: -4)
                cell.name.text?.insert("/", at: i!)
            }
        }
        cell.name.textColor = .darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currencies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
