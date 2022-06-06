//
//  CustomTableViewCell.swift
//  CryptoApp
//
//  Created by Bohdan on 05.06.2022.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    static let id = "CustomCell"
    
    //MARK: - UI
    let view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    let cryptoImageView = UIImageView()
    
    let name = UILabel()
    
    let lastPrice = UILabel()
    
    let priceChangePercent: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    private func layout() {
        cryptoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        lastPrice.translatesAutoresizingMaskIntoConstraints = false
        priceChangePercent.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(cryptoImageView)
        contentView.addSubview(view)
        contentView.addSubview(name)
        contentView.addSubview(lastPrice)
        view.addSubview(priceChangePercent)
        
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            view.widthAnchor.constraint(equalToConstant: 80),
            view.heightAnchor.constraint(equalToConstant: 40),
            
            cryptoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cryptoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cryptoImageView.widthAnchor.constraint(equalToConstant: 30),
            cryptoImageView.heightAnchor.constraint(equalToConstant: 30),
            
            name.leadingAnchor.constraint(equalTo: cryptoImageView.trailingAnchor, constant: 10),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            priceChangePercent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceChangePercent.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            lastPrice.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            lastPrice.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])

    }
}
