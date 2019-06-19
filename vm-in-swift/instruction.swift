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
    private let function:(Any...) -> Void
    
    init(function:@escaping (Any...) -> Void) {
        self.function = function
    }
    
    func Call(args:Any...) {
        self.function(args)
    }
}

class OpcodeInstruction {
    private let opcode:GenericOpcode
    private let type:String
    
    init(type:String, opcode:GenericOpcode) {
        self.type = type
        self.opcode = opcode
    }
    
    func GetType() -> String {
        return self.type
    }
    
    func Execute(args: Any...) -> Void {
        self.opcode.Call(args: args)
    }
    
    static func GetOpcode(type:String) throws -> OpcodeInstruction {
        let find = OpcodeInstruction.opcodeContainer.first(where: {(arg) -> Bool in
            let (t,_) = arg
            return t == type
        })
        
        guard find != nil && find?.1 != nil else {
            throw InstructionError.UndefinedOpcode
        }
        
        return OpcodeInstruction(type: type, opcode: find!.1)
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
    private var opcodeInstruction:OpcodeInstruction?
    private var command:[String]
    
    init(command:String) throws {
        self.command = [String]()
        
        for commandItem in command.components(separatedBy: .whitespaces) {
            self.command.append(commandItem)
        }
    }
    
    func Execute() throws -> Void {
        do {
            try self.DiscoverOpcode()
            self.Evaluate()
            
        } catch let error as InstructionError {
            //TODO:proper execution error and logging
            print("Error: \(error)")
            exit(EXIT_FAILURE)
        }
    }
    
    private func Evaluate() -> Void {

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
}
