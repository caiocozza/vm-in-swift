//
//  instruction.swift
//  vm-in-swift
//
//  Created by Caio Cozza on 15/06/2019.
//  Copyright © 2019 Caio Cozza. All rights reserved.
//

import Foundation

class Opcode {
    static func GetOpcode(stringOpcode:String) -> Int {
        let x = Opcode.opcodes.first(where: {(arg0) -> Bool in
            let (_, raw) = arg0
            return raw == stringOpcode
        })
        
        return x?.0 ?? 0
    }
    
    static private let opcodes:[(Int, String)] = [
        (1,"set"),
        (2,"move")
    ]
}

class GenericOpcode<T> {
    init(function: T) {
        self.function = function
    }
    
    func Call(args:Any...) {
        (self.function as! (Any...) -> ())(args)
    }
    
    private let function: T
}

enum InstructionError : Error {
    case EmptyCommand
    case UndefinedOpcode
}

class Instruction {
    init(command:String) throws {
        self.opcode = 1
        self.command = [String]()
        
        for commandItem in command.components(separatedBy: .whitespaces) {
            self.command.append(commandItem)
        }
    }
    
    private func DiscoverOpcode() throws -> Void {
        guard self.command.count > 0 else {
            throw InstructionError.EmptyCommand
        }
        
        let opcode = Opcode.GetOpcode(stringOpcode: command[0])
        
        guard opcode > 0 else {
            throw InstructionError.UndefinedOpcode
        }
        
        self.opcode = opcode
    }
    
    private var opcode:Int
    private var command:[String]
}
