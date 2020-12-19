//
//  WidgetTimelineProvider.swift
//  WidgetExtension
//
//  Created by Kanunnikov Dmitriy Sergeevich on 19.12.2020.
//

import SwiftUI
import WidgetKit

struct WidgetTimelineProvider: TimelineProvider {
    
    private let EVERY_DAY = 0
    private let EVERY_12_HOURS = 1
    private let EVERY_6_HOURS = 2
    private let EVERY_3_HOURS = 3
    private let EVERY_HOUR = 4
    
    private let animalTypes = [
        "cat",
        "dog",
        "snail",
        "horse",
        "all"
    ]
    
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry.empty
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> ()) {
        let data = WidgetEntryData(
            text: "A cat has more bones than a human; humans have 206, and the cat - 230.",
            date: "2020-08-23T01:24:34.712Z",
            verified: true
        )
        let entry = WidgetEntry(date: Date(), data: data)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> ()) {
        let date = Date()
        
        let refreshRateIndex = SharedSettings.getWidgetRefreshRate()
        
        var nextUpdateDate = Date()
        
        if refreshRateIndex == EVERY_12_HOURS {
            nextUpdateDate = Calendar.current.date(
                byAdding: .hour,
                value: 12,
                to: date
            )!
        } else if refreshRateIndex == EVERY_6_HOURS {
            nextUpdateDate = Calendar.current.date(
                byAdding: .hour,
                value: 6,
                to: date
            )!
        } else if refreshRateIndex == EVERY_3_HOURS {
            nextUpdateDate = Calendar.current.date(
                byAdding: .hour,
                value: 3,
                to: date
            )!
        } else if refreshRateIndex == EVERY_HOUR {
            nextUpdateDate = Calendar.current.date(
                byAdding: .hour,
                value: 1,
                to: date
            )!
        } else {
            nextUpdateDate = Calendar.current.date(
                byAdding: .day,
                value: 1,
                to: date
            )!
        }
        
        let animalTypeIndex = SharedSettings.getAnimalType()
        let animalType = animalTypes[animalTypeIndex]
        
        let factsUrl = Config.getFactsUrl(animalType, "1")
        
        Api.shared.queryFact(
            factsUrl,
            onSuccess: { json in
                guard let fact = try? Util.fromJson(json, Fact.self) else {
                    return
                }
                
                //---
                
                let data = WidgetEntryData(text: fact.text, date: fact.updatedAt, verified: fact.status.verified)
                let entry = WidgetEntry(date: date, data: data)
                
                let timeline = Timeline(
                    entries: [entry],
                    policy: .after(nextUpdateDate)
                )
                
                completion(timeline)
            }, onError: { error in
                let data = WidgetEntryData(
                    text: "A cat has more bones than a human; humans have 206, and the cat - 230.",
                    date: "2020-08-23T01:24:34.712Z",
                    verified: true
                )
                let entry = WidgetEntry(date: date, data: data)
                
                let timeline = Timeline(
                    entries: [entry],
                    policy: .after(nextUpdateDate)
                )
                
                completion(timeline)
            }
        )
    }
}
