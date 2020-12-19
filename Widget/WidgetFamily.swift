//
//  WidgetFamily.swift
//  WidgetExtension
//
//  Created by Kanunnikov Dmitriy Sergeevich on 19.12.2020.
//

import WidgetKit
import SwiftUI

@main
struct WidgetFamily: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        FactWidget()
    }
}

 
