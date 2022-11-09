//
//  NodeModel.swift
//  StructureTreeApp
//
//  Created by Андрей Антонов on 31.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import Foundation


struct NodeModel: Codable {
    var name: String
    var childNodeList: [NodeModel]?
}
