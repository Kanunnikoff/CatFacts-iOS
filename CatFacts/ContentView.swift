//
//  ContentView.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 16.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ViewBuilder
    var body: some View {
        #if os(iOS)
        Sidebar()
        #else
        Sidebar()
            .frame(minWidth: 1000, minHeight: 600)
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

