//
//  main.swift
//  vm-in-swift
//
//  Created by Caio Cozza on 15/06/2019.
//  Copyright © 2019 Caio Cozza. All rights reserved.
//

import Foundation

func Init() -> Void {
    VirtualMachine().Setup(file: "/Users/caiocozza/Code/swift/vm-in-swift/vm-in-swift/file.vminstr")
}

Init()

