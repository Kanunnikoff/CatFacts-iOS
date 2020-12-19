//
//  SettingsView.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 18.12.2020.
//

import SwiftUI
import WidgetKit

struct SettingsView: View {
    
    private let MIN_AMOUNT = 1
    private let MAX_AMOUNT = 500
    
    private let animalTypes = [
        "cat",
        "dog",
        "snail",
        "horse",
        "all"
    ]
    
    private let widgetRefreshRates = [
        "Every day",
        "Every 12 hours",
        "Every 6 hours",
        "Every 3 hours",
        "Every hour"
    ]
    
    @State private var selectedAnimalTypeIndex: Int = 0
    @State private var amount: String = "1"
    @State private var selectedWidgetRefreshRateIndex: Int = 0
    
    @State private var showInvalidAmountAlert: Bool = false
    
    @State private var inited: Bool = false
    
    var body: some View {
        Form {
            let animalTypeIndexBinding = Binding<Int>(get: {
                self.selectedAnimalTypeIndex
            }, set: {
                self.selectedAnimalTypeIndex = $0
            })
            Picker(selection: animalTypeIndexBinding, label: Text("Animal type")) {
                ForEach(0 ..< animalTypes.count) {
                    Text(self.animalTypes[$0])
                }
            }
            
            let sizeBinding = Binding<String>(get: {
                self.amount
            }, set: {
                self.amount = $0
            })
            TextField("Amount (default 1)", text: sizeBinding)
                .textContentType(.oneTimeCode)
                .keyboardType(.numberPad)
                .alert(isPresented: $showInvalidAmountAlert, content: {
                    Util.alert(title: "Error", message: "Acceptable amount from \(MIN_AMOUNT) to \(MAX_AMOUNT)")
                })
            
            let widgetRefreshRateIndexBinding = Binding<Int>(get: {
                self.selectedWidgetRefreshRateIndex
            }, set: {
                self.selectedWidgetRefreshRateIndex = $0
            })
            Picker(selection: widgetRefreshRateIndexBinding, label: Text("Widget refresh rate")) {
                ForEach(0 ..< widgetRefreshRates.count) {
                    Text(self.widgetRefreshRates[$0])
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear {            
            if inited {
                return
            }
            
            initSettings()
        }
        .onChange(of: selectedAnimalTypeIndex) { newIndex in
            SharedSettings.setAnimalType(newIndex)
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onChange(of: amount) { newAmount in
            saveNewAmount(newAmount)
        }
        .onChange(of: selectedWidgetRefreshRateIndex) { newIndex in
            SharedSettings.setWidgetRefreshRate(newIndex)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    private func initSettings() {
        selectedAnimalTypeIndex = SharedSettings.getAnimalType()
        amount = SharedSettings.getAmount()
        selectedWidgetRefreshRateIndex = SharedSettings.getWidgetRefreshRate()
        
        inited = true
    }
    
    private func saveNewAmount(_ newAmount: String) {
        if newAmount.isEmpty {
            return
        }
        
        guard let intAmount = Int(newAmount) else {
            return
        }
        
        if intAmount < MIN_AMOUNT || intAmount > MAX_AMOUNT {
            showInvalidAmountAlert.toggle()
            return
        }
        
        SharedSettings.setAmount(newAmount)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
