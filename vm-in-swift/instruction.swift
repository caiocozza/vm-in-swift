//
//  instruction.swift
//  vm-in-swift
//
//  Created by Caio Cozza on 15/06/2019.
//  Copyright © 2019 Caio Cozza. All rights reserved.
//

import Foundation

class Instruction {
    init(opcode:Int, command:String) {
        self.opcode = opcode
        self.command = command
    }
    
    private let opcode:Int
    private let command:String
}
