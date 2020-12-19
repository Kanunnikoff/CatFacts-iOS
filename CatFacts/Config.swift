//
//  Config.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 16.12.2020.
//

import Foundation

class Config {
    
    //--- App Store
    
    static let APPSTORE_APP_ID = 1545769958
    static let APPSTORE_APP_URL = "https://itunes.apple.com/app/id\(APPSTORE_APP_ID)"
    static let APPSTORE_APP_REVIEW_URL = "https://itunes.apple.com/app/id\(APPSTORE_APP_ID)?action=write-review"
    static let APPSTORE_DEVELOPER_URL = "https://itunes.apple.com/developer/id1449411291"
    
    static let PACKAGE_NAME = "software.kanunnikoff.CatFacts"
    
    //--- App
    
    static let PRIVACY_POLICY_URL = "https://docs.google.com/document/d/1bpBHA0mJpquAf-ZUD_2arAlmdbaJ32YKbljmGBPWU_A/edit?usp=sharing"
    static let EMAIL_URL = "mailto:dmitry.kanunnikoff@gmail.com?subject=CatFacts%20%28iOS%29"
    
    //--- Api
    
    static let ANIMAL_TYPE = "{ANIMAL_TYPE}"
    static let AMOUNT = "{AMOUNT}"
    static let URL = "https://cat-fact.herokuapp.com/facts/random?animal_type=\(ANIMAL_TYPE)&amount=\(AMOUNT)"
    static let ANIMAL_TYPE_ALL = "all"
    static let ALL_ANIMAL_TYPES = "cat,dog,snail,horse"
    
    static func getFactsUrl(_ animalType: String, _ amount: String) -> String {
        return URL.replacingOccurrences(of: ANIMAL_TYPE, with: animalType == ANIMAL_TYPE_ALL ? ALL_ANIMAL_TYPES : animalType)
            .replacingOccurrences(of: AMOUNT, with: amount)
    }
    
}
