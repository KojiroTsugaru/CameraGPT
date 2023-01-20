//
//  CharGPTViewModel.swift
//  Camera GPT
//
//  Created by KJ on 1/6/23.
//

import OpenAISwift
import Foundation

final class ChatGPTViewModel: ObservableObject {
    init() {
        setup()
    }
    
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
                completion("Fail Why?")
            }
        })
    }
}

