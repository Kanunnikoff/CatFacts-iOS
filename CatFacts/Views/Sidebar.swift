//
//  Sidebar.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 18.12.2020.
//

import SwiftUI

struct Sidebar: View {
    
    @State private var isActive = true
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            #if os(iOS)
            content
                .navigationTitle("Menu")
            #else
            content
                .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
            #endif
            
            FactsView()
        }
    }
    
    var content: some View {
        VStack {
            List {
                NavigationLink(destination: FactsView(), isActive: $isActive) {
                    Label("CatFacts", systemImage: "text.quote")
                }
                NavigationLink(destination: SettingsView()) {
                    Label("Settings", systemImage: "gear")
                }
                NavigationLink(destination: AboutView()) {
                    Label("About", systemImage: "info.circle")
                }
            }
            .listStyle(SidebarListStyle())
        }
    }
}

#if DEBUG
struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Sidebar()
                .preferredColorScheme(.light)
            Sidebar()
                .preferredColorScheme(.dark)
        }
    }
}
#endif
