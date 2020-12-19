//
//  FactCard.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 19.12.2020.
//

import SwiftUI

struct FactCard: View {
    
    let fact: Fact
    
    var body: some View {
        VStack {
            Text(fact.text)
                .font(.system(size: 17, weight: .regular, design: .rounded))
                .foregroundColor(Color.white)
                .padding()
            
            HStack {
                Spacer()
                
                let formattedDate = getFormattedDate(string: fact.updatedAt)
                
                if let verified = fact.status.verified, verified {
                    Text("\(formattedDate), verified")
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .foregroundColor(Color.white)
                } else {
                    Text("\(formattedDate), unverified")
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .foregroundColor(Color.white)
                }
                
                Spacer()
            }
            .padding(.bottom)
        }
        .background(Color.accentColor)
        .cornerRadius(10)
    }
    
    private func getFormattedDate(string: String) -> String {
        let date = Util.parseDate(string: string)
        return Util.formatLocalized(date: date)
    }
}
