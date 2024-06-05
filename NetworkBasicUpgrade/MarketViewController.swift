//
//  MarketViewController.swift
//  NetworkBasicUpgrade
//
//  Created by 김윤우 on 6/5/24.
//

import UIKit
import Alamofire
import SnapKit

struct Market: Decodable {
    
    var market: String
    var korean_name: String
    var english_name: String
    
}



class MarketViewController: UIViewController {
   
    
    let tableView = UITableView()
    
    var list: [Market] = [] {
        
        didSet {
            
            tableView.reloadData()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, "1111111")
        
        callRequest()
        
        print(#function, "2222222")
        configureTableView()
        
    }
    func configureTableView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.backgroundColor = .brown
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.identifier)
       
        
    }
    
    func callRequest() {
        print(#function, "33333333")
        print(#function, "44444444")
        let url = "https://api.upbit.com/v1/market/all"
//        AF.request(url).responseString { response in
//                print(response)
//        }
//        
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                self.list = value
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function, list.count)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        cell.nameLabel.text = list[indexPath.row].market
        
        
        
        return cell
    }
    
    
}
