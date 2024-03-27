//
//  ViewController.swift
//  InfoService
//
//  Created by Sergey Savinkov on 27.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var modelArray = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        setupViews()
        setDelegate()
        setConstrints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellID)
    }
    
    func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func getData() {
        NetworkService.shared.getData { (model) in
            DispatchQueue.main.async {
                self.modelArray = model.body.services
                self.tableView.reloadData()
                print("\(self.modelArray.count)")
            }
        }
    }
    
    private func setConstrints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellID, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let model = modelArray[indexPath.row]
        cell.cellConfigure(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelArray[indexPath.row]
        guard let url = URL(string: model.link) else { return }
        UIApplication.shared.open(url)
    }
}

