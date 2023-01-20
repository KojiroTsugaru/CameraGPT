//
//  ChatView.swift
//  Camera GPT
//
//  Created by KJ on 1/17/23.
//

import SwiftUI

let firstMessage = MessageModel(isSentByUser: false, messageText: "Hello, I'm Chat GPT. Ask me any questions, then I can answer them for you:)")

struct messageTextView: View {
    let message: MessageModel
    var body: some View {
        VStack(alignment: .leading){
                if !message.isSentByUser {
                    Text("Chat GPT")
                        .font(.system(size: 15))
                        .foregroundColor(.black.opacity(0.9))
                        .offset(y: 10)
                }
                HStack{
                    if message.isSentByUser {
                        Spacer()
                        Spacer()
                    }
                    ZStack{
                        Text(message.messageText)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(message.backgroundColor)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                            )
                    }
                    if !message.isSentByUser {
                        Spacer()
                    }
                }.frame(maxWidth: .infinity)
        }
    }
}
    
let chatModel = ChatGPTViewModel()
var messages = [String]()

struct ChatView: View {
    
    @State var messages = [MessageModel]()
    @State var text = ""
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical){
                ForEach(messages) { message in
                    HStack{
                        messageTextView(message: message)
                        Spacer()
                    }
                }
            }
            Spacer()
            HStack{
                TextField("Ask Something...", text: $text)
                Button {
                    // この一行の意味はいまいちわからん
                    guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    
                    let newMessage = MessageModel(isSentByUser: true, messageText: text)
                    messages.append(newMessage)
                    
                    // send request to Chat GPT here
                    chatModel.send(text: text) { response in
                        DispatchQueue.main.async {
                            let newResponse = MessageModel(isSentByUser: false, messageText: response)
                            self.messages.append(newResponse)
                            self.text = ""
                        }
                    }
                } label: {
                    Text("Ask")
                        .font(.system(size: 18))
                        .padding(.horizontal)
                        .padding(.vertical, 1)
                        .background(RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.gray.opacity(0.3)))
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.gray.opacity(0.2)))
        }
        .padding()
        .onAppear(){
            messages.append(firstMessage)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
