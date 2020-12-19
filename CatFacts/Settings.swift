//
//  Settings.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 17.12.2020.
//

import Foundation

struct Settings {

    static let LAUNCHES_COUNT = "launches_count"
    static let LAUNCHES_COUNT_THRESHOLD = "launches_count_threshold"
    static let LAST_VERSION_PROMTED_FOR_REVIEW = "last_version_prompted_for_review"
    
    //---
   
    static func getLaunchesCount() -> Int {
        return UserDefaults.standard.integer(forKey: LAUNCHES_COUNT)
    }
    
    static func setLaunchesCount(_ value: Int) {
        UserDefaults.standard.set(value, forKey: LAUNCHES_COUNT)
    }
    
    static func getLaunchesCountThreshold() -> Int {
        let threshold = UserDefaults.standard.integer(forKey: LAUNCHES_COUNT_THRESHOLD)
        
        if threshold == 0 {
            return 5
        }
        
        return threshold
    }
    
    static func setLaunchesCountThreshold(_ value: Int) {
        UserDefaults.standard.set(value, forKey: LAUNCHES_COUNT_THRESHOLD)
    }
}
