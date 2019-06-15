//
//  core.swift
//  vm-in-swift
//
//  Created by Caio Cozza on 15/06/2019.
//  Copyright © 2019 Caio Cozza. All rights reserved.
//

import Foundation

class VirtualMachine {
    init(file: String) {
        self.file = file
        self.instructions = [Instruction]()
    }
    
    private let file:String
    private var instructions:[Instruction]
}
