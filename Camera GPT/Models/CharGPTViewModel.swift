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

