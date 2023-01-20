//
//  HomeScreenView.swift
//  Camera GPT
//
//  Created by KJ on 1/7/23.
//

import SwiftUI

struct HomeScreenView: View {
    
    @State private var scannedTexts:[ScanData] = []
    
    let icons = ["house.fill", "camera.circle.fill", "ellipsis.message"]
    @State var tabSelected = 0
    
    var body: some View {
        VStack{
            ZStack{
                switch tabSelected {
                case 0:
                    HistoryView()
                case 1:
                    HistoryView(showScannerSheet: true)
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
    }
}
