//
//  instruction.swift
//  vm-in-swift
//
//  Created by Caio Cozza on 15/06/2019.
//  Copyright © 2019 Caio Cozza. All rights reserved.
//

import Foundation

enum InstructionError : Error {
    case EmptyCommand
    case UndefinedOpcode
}

class GenericOpcode {
    init(function:@escaping (Any...) -> Void) {
        self.function = function
    }
    
    func Call(args:Any...) {
        self.function(args)
    }
    
    private let function:(Any...) -> Void
}

class OpcodeInstruction {
    init(opcode:GenericOpcode) {
        self.opcode = opcode
    }
    
    private let opcode:GenericOpcode
    
    static func GetOpcode(type:String) throws -> OpcodeInstruction {
        let find = OpcodeInstruction.opcodeContainer.first(where: {(arg) -> Bool in
            let (t,_) = arg
            return t == type
        })
        
        guard find != nil && find?.1 != nil else {
            throw InstructionError.UndefinedOpcode
        }
        
        return OpcodeInstruction(opcode: find!.1)
    }
    
    static private let opcodeContainer:[(String, GenericOpcode)] = [
        ("set", GenericOpcode(function: {(args:Any...) -> Void in
            //TODO
        })),
        ("move", GenericOpcode(function: {(args:Any...) -> Void in
            //TODO
        })),
        ("copy", GenericOpcode(function: {(args:Any...) -> Void in
            //TODO
        }))
    ]
}

class Instruction {
    init(command:String) throws {
        self.command = [String]()
        
        for commandItem in command.components(separatedBy: .whitespaces) {
            self.command.append(commandItem)
        }
    }
    
    private func DiscoverOpcode() throws -> Void {
        guard self.command.count > 0 else {
            throw InstructionError.EmptyCommand
        }
        

        let opcode = try? OpcodeInstruction.GetOpcode(type: command[0])
        
        guard opcode != nil else {
            throw InstructionError.UndefinedOpcode
        }
        
        self.opcodeInstruction = opcode
    }
    
    private var opcodeInstruction:OpcodeInstruction?
    private var command:[String]
}
