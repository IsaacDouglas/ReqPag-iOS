//
//  HistoricTableViewController.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

class HistoricTableViewController: UITableViewController {

    private var items: [Transaction] = []
    private var saldo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.title = "Histórico"
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(cell: HistoricTableViewCell.self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        request()
    }
    
    func request() {
        Requester.getRequest(url: Constants.urlTransaction, onError: {_ in
            print("Error")
        }, onSucess: { data in
            print("Sucess")
            let historic = try! JSONDecoder().decode(Transactions.self, from: data)
            self.items = historic.transacoes
            self.saldo = historic.saldo
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
            cell.textLabel?.text = "Saldo: R$\(saldo)"
            cell.textLabel?.setFont(.bold, size: 27)
            cell.textLabel?.textColor = Color.one.color
            cell.textLabel?.textAlignment = .center
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HistoricTableViewCell.identifier, for: indexPath) as! HistoricTableViewCell
            cell.setup(transaction: items[indexPath.row - 1])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 70 : 135
    }

}
