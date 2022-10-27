//
//  ListNodesViewController.swift
//  StructureTreeApp
//
//  Created by Андрей Антонов on 27.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit

class ListNodesViewController: UIViewController {
    
    // MARK: properties
    
    private let nodeTableView = UITableView()
    
    // MARK: lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraint()
        setupTableView()
    }

    // MARK: setupView
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(nodeTableView)
    }
    
    private func setupTableView() {
        nodeTableView.dataSource = self
        nodeTableView.register(
            ListNodesTableViewCell.self,
            forCellReuseIdentifier: String(describing: ListNodesTableViewCell.self)
        )
    }
    
    private func setupConstraint() {
        nodeTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nodeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nodeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nodeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nodeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource

extension ListNodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nodeTableView.dequeueReusableCell(withIdentifier: String(describing: ListNodesTableViewCell.self)) as! ListNodesTableViewCell
        
        return cell
    }
}
