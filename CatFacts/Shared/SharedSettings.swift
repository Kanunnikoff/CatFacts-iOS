//
//  SharedSettings.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 19.12.2020.
//

import Foundation

struct SharedSettings {
    
    static let ANIMAL_TYPE = "animal_type"
    static let AMOUNT = "amount"
    static let WIDGET_REFRESH_RATE = "widget_refresh_rate"
    
    private static let userDefaults = UserDefaults.init(suiteName: "group.\(Config.PACKAGE_NAME)")
    
    static func getAnimalType() -> Int {
        let animalType = userDefaults?.integer(forKey: ANIMAL_TYPE)
        return animalType == nil ? 0 : animalType!
    }
    
    static func setAnimalType(_ value: Int) {
        userDefaults?.set(value, forKey: ANIMAL_TYPE)
    }
    
    static func getAmount() -> String {
        let amount = userDefaults?.string(forKey: AMOUNT)
        return amount == nil ? "5" : amount!
    }
    
    static func setAmount(_ value: String) {
        userDefaults?.set(value, forKey: AMOUNT)
    }
    
    static func getWidgetRefreshRate() -> Int {
        let widgetRefreshRate = userDefaults?.integer(forKey: WIDGET_REFRESH_RATE)
        return widgetRefreshRate == nil ? 0 : widgetRefreshRate!
    }
    
    static func setWidgetRefreshRate(_ value: Int) {
        userDefaults?.set(value, forKey: WIDGET_REFRESH_RATE)
    }
}
