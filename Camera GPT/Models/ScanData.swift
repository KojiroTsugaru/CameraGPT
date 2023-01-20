//
//  ScanData.swift
//  Camera GPT
//
//  Created by KJ on 1/6/23.
//

import Foundation

struct ScanData: Identifiable {
    var id = UUID()
    var content: String
    
    init(content: String) {
        self.content = content
    }
}

struct ResponseModel: Identifiable {
    var id = UUID()
    var content: String
    
    init(content: String) {
        self.content = content
    }
}
