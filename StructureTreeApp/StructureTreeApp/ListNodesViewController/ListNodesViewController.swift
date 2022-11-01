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
    private var nodeModel = RootNodeModel(name: "Root Node", childNodeList: [])
    
    // MARK: lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = nodeModel.name
        
        setupView()
        setupConstraint()
        setupTableView()
        addNavBarItem()
        getData(forKey: "Node", castTo: RootNodeModel.self)
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
    
    private func addNavBarItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNode))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addNewNode() {
        let aletController = UIAlertController(
            title: "Add new node",
            message: "write new node name",
            preferredStyle: .alert
        )
        aletController.addTextField()
        let addButton = UIAlertAction(title: "add", style: .default) { [unowned aletController, weak self] _ in
            guard let self = self else { return }
            
            let text = aletController.textFields?[0].text
            self.nodeModel.childNodeList.append(ChildNode(name: text!, childs: []))
            self.saveData(object: self.nodeModel, forKey: "Node")
            self.nodeTableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        aletController.addAction(addButton)
        aletController.addAction(cancelButton)
        
        present(aletController, animated: true, completion: nil)
    }
    
    // MARK: get/set data
    
    private func saveData(object: RootNodeModel, forKey: String) {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(object, forKey: forKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getData(forKey: String, castTo: RootNodeModel.Type) {
        let userDefaults = UserDefaults.standard
        do {
            let data = try userDefaults.getObject(forKey: forKey, castTo: castTo.self)
            nodeModel = data
            print(data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: UITableViewDataSource

extension ListNodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nodeModel.childNodeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nodeTableView.dequeueReusableCell(withIdentifier: String(describing: ListNodesTableViewCell.self)) as! ListNodesTableViewCell
        cell.configure(name: nodeModel.childNodeList[indexPath.row]?.name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            nodeModel.childNodeList.remove(at: indexPath.row)
            nodeTableView.deleteRows(at: [indexPath], with: .automatic)
            saveData(object: nodeModel, forKey: "Node")
            nodeTableView.reloadData()
        }
    }
}
