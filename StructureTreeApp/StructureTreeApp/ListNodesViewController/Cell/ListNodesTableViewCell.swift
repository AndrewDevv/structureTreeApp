//
//  ListNodesTableViewCell.swift
//  StructureTreeApp
//
//  Created by Андрей Антонов on 27.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit

class ListNodesTableViewCell: UITableViewCell {
    
    // MARK: properties
    
    private let nameLabel = UILabel()
    
    // MARK: init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
        setupConstraint()
    }
    
    // MARK: private methods
    
    private func setupView() {
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraint() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
    }
    
    // MARK: methods
    
    func configure(name: String) {
        nameLabel.text = name
    }
}
