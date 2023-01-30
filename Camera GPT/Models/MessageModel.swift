//
//  MessageModel.swift
//  Camera GPT
//
//  Created by KJ on 1/17/23.
//

import Foundation
import SwiftUI

struct MessageModel: Identifiable {
    var id = UUID()
    var isSentByUser: Bool
    var messageText: String
    var backgroundColor: Color
    
    init(isSentByUser: Bool, messageText: String){
        self.isSentByUser = isSentByUser
        
        // trimming whitespaces
        self.messageText = messageText
        self.messageText.trimmingCharacters(in: .whitespaces)
        
        if self.isSentByUser { self.backgroundColor = Color.gray.opacity(0.3)} else { self.backgroundColor = Color.blue.opacity(0.3) }
    }
}

