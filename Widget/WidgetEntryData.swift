//
//  WidgetEntryData.swift
//  WidgetExtension
//
//  Created by Kanunnikov Dmitriy Sergeevich on 19.12.2020.
//

import Foundation

class WidgetEntryData {
    let text: String
    let date: String
    let verified: Bool?
    
    init() {
        text = ""
        date = ""
        verified = false
    }
    
    init(
        text: String,
        date: String,
        verified: Bool?
    ) {
        self.text = text
        self.date = date
        self.verified = verified
    }
}
