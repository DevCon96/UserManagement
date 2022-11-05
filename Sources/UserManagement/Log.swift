//
//  File 2.swift
//  
//
//  Created by Connor Jones on 28/06/2022.
//

import Foundation

func log(_ statement: String, file: String = #file, function: String = #function, line: Int = #line) {
    print("\(file) : \(function) : [\(line)] \(statement)")
}
