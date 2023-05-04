//
//  ScanData.swift
//  Camera GPT
//
//  Created by KJ on 1/6/23.
//

import Foundation

// scandata model

struct ScanData: Identifiable {
    var id = UUID()
    var content: String
    
    init(content: String) {
        self.content = content
    }
}

class ScanDatas: ObservableObject {
    @Published var scanDatas = [ScanData]()
}

// response model

struct ResponseModel: Identifiable{
    var id = UUID()
    var content: String
    var question: String
    
    init(question: String, content: String) {
        self.question = question
        self.content = content
    }
}

class Responses: ObservableObject {
    @Published var responses = [ResponseModel]()
}
