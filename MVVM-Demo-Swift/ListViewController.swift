//
//  ListViewController.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/10.
//

import UIKit

class ListViewController: UITableViewController {
    
    var listViewModel = ListViewModel()
    var datas: [ListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertData))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mvvm-cell")
        self.tableView.tableFooterView = UIView()
        
        listViewModel.liveData.observe { [weak self] dataArr in
            self?.datas = dataArr
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mvvm-cell")
        cell.textLabel?.text = datas[indexPath.row].title
        cell.detailTextLabel?.text = datas[indexPath.row].detail
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func insertData() {
        listViewModel.insertData()
    }
    
}
