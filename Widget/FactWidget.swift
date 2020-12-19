//
//  Widget.swift
//  Widget
//
//  Created by Kanunnikov Dmitriy Sergeevich on 19.12.2020.
//

import WidgetKit
import SwiftUI

@main
struct FactWidget: Widget {
    let kind: String = "\(Config.PACKAGE_NAME).Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WidgetTimelineProvider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("CatFacts")
        .description("Facts about cats.")
    }
}
