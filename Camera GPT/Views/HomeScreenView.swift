//
//  HomeScreenView.swift
//  Camera GPT
//
//  Created by KJ on 1/7/23.
//

import SwiftUI

struct HomeScreenView: View {
    let icons = ["house.fill", "camera.circle.fill", "ellipsis.message"]
    @State var tabSelected = 0
    @EnvironmentObject var ChatModel: ChatGPTViewModel
    @EnvironmentObject var responses: Responses
    @EnvironmentObject var scannedTexts: ScanDatas
    
    var body: some View {
        VStack{
            ZStack{
                switch tabSelected {
                case 0:
                    HistoryView()
                case 1:
                    ScannerView(completion: { textPerPage in
                        if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                            let newScanData = ScanData(content: outputText)
                            self.scannedTexts.scanDatas.append(newScanData)

                            // send request to Open AI
                            if outputText.count <= 120 {
                                ChatModel.send(text: outputText){ response in
                                    DispatchQueue.main.async {
                                        let newResponse = ResponseModel(content: response)
                                        responses.responses.append(newResponse)
                                    }
                                }
                            }
                        }
                        tabSelected = 0
                    })
                    .edgesIgnoringSafeArea(.all)
                case 2:
                    ChatView()
                default:
                    Text("Nothing")
                }
            }
            Spacer()
            Divider()
            // Custom tab bar
            HStack (alignment: .bottom){
                ForEach(0..<3) { num in
                    Button {
                        tabSelected = num
                    } label: {
                        if num == 1 {
                            Spacer()
                            Image(systemName: icons[num])
                                .font(.system(size: 60))
                                .foregroundColor(tabSelected == num ? .black : .cyan)
                            Spacer()
                        }
                        else {
                            Spacer()
                            Image(systemName: icons[num])
                                .font(.system(size: 25))
                                .foregroundColor(tabSelected == num ? .black : .gray)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}



struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(ScanDatas())
            .environmentObject(Responses())
            .environmentObject(ChatGPTViewModel())
    }
}
