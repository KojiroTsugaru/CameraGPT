//
//  ResponseDetailView.swift
//  Camera GPT
//
//  Created by KJ on 5/4/23.
//

import SwiftUI

let test: String = "This is test string.This is test string.This is test string.This is test string.This is test string.This is test string.This is test string.This is test string.This is test string.This is test string.This is test string.This is test string.This is test string.This is test string.This is test string."

struct ResponseDetailView: View {
    let question: String?
    let response: String?
    
    var body: some View {
        ScrollView(.vertical){
            VStack(){
                Text("Question:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20).bold())
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Text(question ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Text("Answer:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20).bold())
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Text(response ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Spacer()
            }
        }
    }
}

struct ResponseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseDetailView(question: test, response: test)
    }
}
