//
//  Api.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 16.12.2020.
//

import Foundation

final class Api : NSObject {
    
    public static let shared = Api()
 
    private override init() {
    }
    
    public func queryFact(
        _ url: String,
        onSuccess: @escaping ((String) -> Void),
        onError: @escaping ((String) -> Void)
    ) {
        Util.makeGetRequest(url, 
            onSuccess: { json in
                DispatchQueue.main.async {
                    onSuccess(json)
                }
            }, onError: { error in
                onError(error)
            }
        )
    }
}
