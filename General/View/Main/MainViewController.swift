//
//  MainViewController.swift
//  recPag
//
//  Created by Isaac Douglas on 09/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private let height: CGFloat = 150
    
    private let config: [Menu] = [.pay, .sale, .history, .wallet]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "RecPag"

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: MainCollectionViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cell: MainTableViewCell.self)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.setup(menu: config[indexPath.row + 2])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = collectionView.frame.size.width
        let offSet = (width - (height * 2)) / 3
        return UIEdgeInsets(top: 0, left: offSet, bottom: 0, right: offSet)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        cell.setup(menu: config[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 0 {
            let camera = CameraViewController()
            camera.delegate = self
            navigationController?.pushViewController(camera, animated: true)
        }else if indexPath.row == 1 {
            let sale = SaleViewController()
            navigationController?.pushViewController(sale, animated: true)
        }
    }
    
}

extension MainViewController: StreamDelegate {
    func stream(text: String) {
        print(text)
    }
    
}
