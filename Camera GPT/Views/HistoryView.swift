//
//  HomeScreenView.swift
//  Camera GPT
//
//  Created by KJ on 1/6/23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var scannedTexts: ScanDatas
    @EnvironmentObject var responses: Responses
    
    var body: some View {
        NavigationView{
            VStack{
                if scannedTexts.scanDatas.count > 0 {
                    List{
                        ForEach(responses.responses){ response in
                            NavigationLink(
                                destination:ScrollView{Text(response.content)},
                                label: {
                                    Text(response.content).lineLimit(1)
                                })
                        }
                        ForEach(scannedTexts.scanDatas){ response in
                            NavigationLink(
                                destination:ScrollView{Text(response.content)},
                                label: {
                                    Text(response.content).lineLimit(1)
                                })
                        }
                    }
                    .navigationTitle("Your Scanned Items")
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
                    .navigationTitle("Welcome to Camera GPT")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(ScanDatas())
            .environmentObject(Responses())
            .environmentObject(ChatGPTViewModel())
    }
}
