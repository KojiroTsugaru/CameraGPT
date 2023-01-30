//
//  ContentView.swift
//  Camera GPT
//
//  Created by KJ on 1/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeScreenView()
            .environmentObject(ScanDatas())
            .environmentObject(Responses())
            .environmentObject(ChatGPTViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
