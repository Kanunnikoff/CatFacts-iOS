//
//  Fact.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 16.12.2020.
//

import Foundation

class Fact : Decodable, Identifiable {
    var status: Status
    var type: String
    var deleted: Bool
    var _id: String
    var user: String
    var text: String
    var __v: Int
    var source: String?
    var updatedAt: String
    var createdAt: String
    var used: Bool?
    
    class Status: Decodable {
        var verified: Bool?
        var sentCount: Int
    }
}
