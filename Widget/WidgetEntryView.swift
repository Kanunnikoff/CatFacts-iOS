//
//  WidgetEntryView.swift
//  WidgetExtension
//
//  Created by Kanunnikov Dmitriy Sergeevich on 19.12.2020.
//

import SwiftUI
 
struct WidgetEntryView: View {
    var entry: WidgetTimelineProvider.Entry

    @ViewBuilder
    var body: some View {
        WidgetView(entry: entry)
    }
}
