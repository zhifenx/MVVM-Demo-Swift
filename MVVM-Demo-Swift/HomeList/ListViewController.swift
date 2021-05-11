//
//  ListViewController.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/10.
//

import UIKit

class ListViewController: UITableViewController {
    
    var listViewModel = ListViewModel()
    var datas: [ListModel] = [] //这里引入了model
    
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
        jumpToDemoVC(indexPath)
    }
    
    @objc func insertData() {
        listViewModel.insertData()
    }
    
    func jumpToDemoVC(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = LDLoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = RxSwiftLoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break;
        }
    }
    
}
