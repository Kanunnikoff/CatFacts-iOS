//
//  WidgetSmallView.swift
//  WidgetExtension
//
//  Created by Kanunnikov Dmitriy Sergeevich on 19.12.2020.
//

import SwiftUI

struct WidgetView: View {
    var entry: WidgetTimelineProvider.Entry
    
    var body: some View {
        let fact = entry.data
        
        VStack {
            Text(fact.text)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .minimumScaleFactor(0.2)
                .padding()
            
            Spacer()
            
            HStack {
                Spacer()
                
                let formattedDate = getFormattedDate(string: fact.date)
                
                if let verified = fact.verified, verified {
                    Text("\(formattedDate), verified")
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                } else {
                    Text("\(formattedDate), unverified")
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                }
                
                Spacer()
            }
            .padding(.bottom)
        }
    }
    
    private func getFormattedDate(string: String) -> String {
        let date = Util.parseDate(string: string)
        return Util.formatLocalized(date: date)
    }
}
