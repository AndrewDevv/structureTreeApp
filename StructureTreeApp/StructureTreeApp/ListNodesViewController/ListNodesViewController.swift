//
//  ListNodesViewController.swift
//  StructureTreeApp
//
//  Created by Андрей Антонов on 27.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ListNodesViewController: UIViewController {
    
    // MARK: properties
    
    private let nodeTableView = UITableView()
    private var nodeModelVariable = Variable<[NodeModel]>([])
    private let disposeBag = DisposeBag()
    
    // MARK: lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraint()
        setupTableView()
        addNavBarItem()
        bindViewModel()
        getNode(forKey: "Node", castTo: NodeModel.self)
    }

    // MARK: setupView
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(nodeTableView)
    }
    
    private func setupTableView() {
        nodeTableView.delegate = self
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
            
            if let text = aletController.textFields?[0].text {
                self.nodeModelVariable.value.append(NodeModel(name: text, childNodeList: []))
                self.saveNode(object: self.nodeModelVariable.value, forKey: "Node")
                self.nodeTableView.reloadData()
            }
        }
        let cancelButton = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        aletController.addAction(addButton)
        aletController.addAction(cancelButton)
        
        present(aletController, animated: true, completion: nil)
    }
    
    // MARK: get/set data
    
    private func saveNode(object: [NodeModel], forKey: String) {
        UserDefaults.standard.setObject(object, forKey: forKey).subscribe().disposed(by: disposeBag)
    }
    
    private func getNode(forKey: String, castTo: NodeModel.Type) {
        UserDefaults.standard.getObject(forKey: forKey, castTo: castTo).subscribe().disposed(by: disposeBag)
    }
    
    // MARK: Navigate
    
    private func navigateOnNextNode(indexPath: IndexPath) {
        let navVC = NavigationViewController()
        
        navigationController?.pushViewController(navVC, animated: false)
    }
}

// MARK: RxDataSource

extension ListNodesViewController {
    func bindViewModel() {
        
        nodeModelVariable.asObservable().bind(to: nodeTableView.rx.items(
            cellIdentifier: String(describing: ListNodesTableViewCell.self),
            cellType: ListNodesTableViewCell.self
        )) { row, node, cell in
            cell.configure(name: node.name)
        }
        .disposed(by: disposeBag)
        
        nodeTableView.rx
            .itemDeleted
            .subscribe(onNext: { self.nodeModelVariable.value.remove(at: $0.row) })
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDelegate

extension ListNodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateOnNextNode(indexPath: indexPath)
    }
}
