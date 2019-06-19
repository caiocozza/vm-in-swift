//
//  core.swift
//  vm-in-swift
//
//  Created by Caio Cozza on 15/06/2019.
//  Copyright © 2019 Caio Cozza. All rights reserved.
//

import Foundation

class VirtualMachine {
    init() {
        self.instructions = [Instruction]()
    }
    
    func Setup(file: String) -> Void {
        do {
            let rawInstructions = try NSString(contentsOfFile: file, encoding: String.Encoding.utf8.rawValue)
            
            
            for rawInstruction in rawInstructions.components(separatedBy: .newlines) {
                self.instructions.append(try Instruction(command: rawInstruction))
            }
        } catch let error as NSError {
            //TODO:Proper Error handling
            print("Error: \(error)")
            exit(EXIT_FAILURE)
        } catch let error as InstructionError {
            print("Instruction Error: \(error)")
            exit(EXIT_FAILURE)
        }
    }
    
    func Execute() -> Void {
        for instruction in self.instructions {

        }
    }
    
    private var instructions:[Instruction]
}
