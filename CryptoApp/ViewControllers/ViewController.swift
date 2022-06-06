//
//  ViewController.swift
//  CryptoApp
//
//  Created by Bohdan on 05.06.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    let networkManager = CryptoNetworkManager()
    
    var selectedRow = 0
    
    var currencies = ["BTCUSDT", "DOGEUSDT", "LTCUSDT", "ETHUSDT", "ETCUSDT", "XRPUSDT", "ADAUSDT", "ATOMUSDT", "AVAXUSDT"]
    
    let allCurrencies = [
        "BTCUSDT", "DOGEUSDT", "LTCUSDT", "ETHUSDT", "ETCUSDT", "XRPUSDT", "ADAUSDT", "ATOMUSDT", "AVAXUSDT", "BNBUSDT",
        "DOTUSDT", "LINKUSDT", "LUNAUSDT", "SHIBUSDT", "SOLUSDT", "TRXUSDT", "UNIUSDT"
    ]
    
    //MARK: - UI
    private let tableView = UITableView()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    private let refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Crypto"
        layout()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.id)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .darkGray
        tableView.separatorStyle = .none
        tableView.rowHeight = 50

        
        tableView.refreshControl = refreshControl
        navigationItem.leftBarButtonItem = self.editButtonItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewCrypto))
        tableView.isHidden = true
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func editButtonItem() -> UIBarButtonItem {
        let editButton = super.editButtonItem
        editButton.action = #selector(editButtonAction)
        return editButton
    }
    
    @objc private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc private func editButtonAction(sender: UIBarButtonItem) {
        if self.tableView.isEditing == true {
            self.tableView.isEditing = false
            sender.style = UIBarButtonItem.Style.plain
            sender.title = "Edit"
        } else {
            self.tableView.isEditing = true
            sender.style = UIBarButtonItem.Style.done
            sender.title = "Done"
        }
    }
    
    @objc private func addNewCrypto() {
        let viewController = UIViewController()
        viewController.preferredContentSize = CGSize(width: 250,height: 250)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        viewController.view.addSubview(pickerView)
        let alertController = UIAlertController(title: "Choose crypto", message: "", preferredStyle: .alert)
        alertController.setValue(viewController, forKey: "contentViewController")
        
        let addCryptoAction = UIAlertAction(title: "Done", style: .default) { _ in
            if !self.currencies.contains(self.allCurrencies[self.selectedRow]) {
                self.currencies.append(self.allCurrencies[self.selectedRow])
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addCryptoAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    //MARK: - Layout
    private func layout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
