//
//  ViewExt.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 16.12.2020.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
