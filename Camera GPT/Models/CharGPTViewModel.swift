//
//  CharGPTViewModel.swift
//  Camera GPT
//
//  Created by KJ on 1/6/23.
//

import OpenAISwift
import Foundation

final class ChatGPTViewModel: ObservableObject {
    init() {}
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping (String) -> Void ){
        self.setup()
        client?.sendCompletion(with: text,
                               maxTokens: 500,
                               completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure:
                break
            }
        })
    }
}

