//
//  Util.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 16.12.2020.
//

import Foundation
import UIKit
import SwiftUI

struct Util {
    
    private static let DECODER = JSONDecoder()
    private static let NETWORK_TIMEOUT = 5.0
    
    static func makeGetRequest(_ url: String, onSuccess: @escaping ((String) -> Void), onError: @escaping ((String) -> Void)) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = NETWORK_TIMEOUT
        configuration.timeoutIntervalForResource = NETWORK_TIMEOUT
        
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request, completionHandler: { data, resp, error in
            guard let data = data, error == nil else {
                onError(error?.localizedDescription ?? "http error")
                return
            }
            
            let response = String(data: data, encoding: .utf8)!
            onSuccess(response)
        })
        
        task.resume()
    }
    
    static func alert(title: String, message: String) -> Alert {
        return Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("OK")))
    }
    
    static func fromJson<T>(_ json: String, _ type: T.Type) throws -> T where T: Decodable {
        try DECODER.decode(type, from: json.data(using: .utf8)!)
    }
    
//    static func browse(url: String) {
//        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url)
//        }
//    }
    
    static func currentTimeMillis()-> Int64 {
        Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    static func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
    
    static func parseDate(string: String, withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)!
    }
    
    static func formatLocalized(date: Date, withTemplate template: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate(template)
        
        return dateFormatter.string(from: date)
    }
}
