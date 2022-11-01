//
//  NodeModel.swift
//  StructureTreeApp
//
//  Created by Андрей Антонов on 31.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import Foundation


struct RootNodeModel: Codable {
    var name: String
    var childNodeList: [ChildNode?]
}

struct ChildNode: Codable {
    var name: String
    var childs: [ChildNode?]
}
