//
//  HistoricTableViewController.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

class HistoricTableViewController: UITableViewController {

    var items: [Transaction] = []
    
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
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoricTableViewCell.identifier, for: indexPath) as! HistoricTableViewCell
        cell.setup(transaction: items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }

}
