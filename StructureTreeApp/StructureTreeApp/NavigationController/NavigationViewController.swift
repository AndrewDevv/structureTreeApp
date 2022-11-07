//
//  NavigationViewController.swift
//  StructureTreeApp
//
//  Created by Андрей Антонов on 01.11.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {
    
    private let nodeListVC = ListNodesViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.pushViewController(nodeListVC, animated: false)
    }
}
