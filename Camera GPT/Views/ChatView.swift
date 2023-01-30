//
//  ChatView.swift
//  Camera GPT
//
//  Created by KJ on 1/17/23.
//

import SwiftUI

let firstMessage = MessageModel(isSentByUser: false, messageText: "Hello, I'm Chat GPT. Ask me any questions.")

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

struct ChatView: View {
    
    @State var messages = [MessageModel]()
    @State var text = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Rectangle()
                .frame(height: 70)
                .foregroundColor(.green.opacity(0.2))
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical){
                ScrollViewReader { value in
                    ForEach(messages) { message in
                        HStack{
                            messageTextView(message: message)
                            Spacer()
                        }
                    }
                    .onChange(of: messages.count) { _ in
                        value.scrollTo(messages.last?.id, anchor: .center)
                    }
                }
            }
            .padding(.horizontal)
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
                    Image(systemName: "paperplane")
                        .font(.system(size: 20))
                        .foregroundColor(.blue.opacity(0.8))
                        .padding(.horizontal, 3)
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.gray.opacity(0.2)))
            .padding(.horizontal)
        }
        .onAppear(){
            messages.append(firstMessage)
            chatModel.setup()
        }
        .background(Color.gray.opacity(0.05))
    }
}
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
