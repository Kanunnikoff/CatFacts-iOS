//
//  WidgetEntry.swift
//  WidgetExtension
//
//  Created by Kanunnikov Dmitriy Sergeevich on 19.12.2020.
//

import SwiftUI
import WidgetKit

struct WidgetEntry: TimelineEntry {
    let date: Date
    let data: WidgetEntryData 
    
    static let empty = WidgetEntry(
        date: Date(),
        data: WidgetEntryData()
    )
}
