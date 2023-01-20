//
//  HomeScreenView.swift
//  Camera GPT
//
//  Created by KJ on 1/6/23.
//

import SwiftUI

struct HistoryView: View {
    @State public var showScannerSheet = false
    @State private var scannedTexts:[ScanData] = []
    @State private var responses = [ResponseModel]()
    
    @ObservedObject var ChatModel = ChatGPTViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                if scannedTexts.count > 0 {
                    List{
                        ForEach(responses){ response in
                            NavigationLink(
                                destination:ScrollView{Text(response.content)},
                                label: {
                                    Text(response.content).lineLimit(1)
                                })
                        }
                        ForEach(scannedTexts){ response in
                            NavigationLink(
                                destination:ScrollView{Text(response.content)},
                                label: {
                                    Text(response.content).lineLimit(1)
                                })
                        }
                    }
                }
                else{
                    VStack(alignment: .center, spacing: 10){
                        Image(systemName: "photo.stack")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                        Text("No Scanned Items Available")
                            .font(.system(size: 20))
                            .bold()
                        Text("Scan items from camera button!")
                            .font(.system(.caption))
                    }
                    .foregroundColor(.gray)
                    .padding()
                }
            }
                .navigationTitle("Camera GPT")
                .sheet(isPresented: $showScannerSheet, content: {
                    self.makeScannerView()
                })
        }
    }
    
    private func makeScannerView()-> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                let newScanData = ScanData(content: outputText)
                self.scannedTexts.append(newScanData)

                // send request to Open AI
                ChatModel.send(text: outputText){ response in
                    let newResponse = ResponseModel(content: response)
                    responses.append(newResponse)
                }
            }
            self.showScannerSheet = false
        })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
