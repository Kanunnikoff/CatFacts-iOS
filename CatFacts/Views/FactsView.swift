//
//  FactsView.swift
//  CatFacts
//
//  Created by Kanunnikov Dmitriy Sergeevich on 18.12.2020.
//

import SwiftUI
import Combine

struct FactsView: View {
    
    @State private var showingErrorAlert: Bool = false
    @State private var showingCopiedNotice: Bool = false
    
    @State private var loading: Bool = false
    
    @State private var facts: Array<Fact> = []
    
    private let animalTypes = [
        "cat",
        "dog",
        "snail",
        "horse",
        "all"
    ]
    
    var body: some View {
        GeometryReader { g in
            if facts.isEmpty {
                if !loading {
                    VStack(alignment: .center) {
                        Spacer()
                        Text("Couldn't load facts. Please, try again.")
                            .padding(.top, 10)
                        Spacer()
                    }
                    .frame(width: g.size.width)
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        ProgressView()
                        Text("Loading facts...")
                            .padding(.top, 10)
                        Spacer()
                    }
                    .frame(width: g.size.width)
                }
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(facts) { fact in
                            VStack {
                                Text(fact.text)
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.white)
                                    .padding()
                                
                                HStack {
                                    Spacer()
                                    
                                    let formattedDate = getFormattedDate(string: fact.updatedAt)
                                    
                                    if let verified = fact.status.verified, verified {
                                        Text("\(formattedDate), verified")
                                            .font(.system(size: 11, weight: .regular, design: .rounded))
                                            .foregroundColor(Color.white)
                                    } else {
                                        Text("\(formattedDate), unverified")
                                            .font(.system(size: 11, weight: .regular, design: .rounded))
                                            .foregroundColor(Color.white)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.bottom)
                            }
                            .background(Color.accentColor)
                            .cornerRadius(10)
                                .frame(width: g.size.width - 40)
                                .onTapGesture {
                                }
                                .onLongPressGesture {
                                    Util.copyToClipboard(text: fact.text)
                                    showingCopiedNotice = true

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        showingCopiedNotice = false
                                    }
                                }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("CatFacts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if showingCopiedNotice {
                    Text("Copied")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                if loading {
                    ProgressView()
                } else {
                    Button(action: {
                        if loading == true {
                            return
                        }
                        
                        loadCatFacts()
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    })
                    .disabled(loading)
                }
            }
        }
        .onAppear(perform: {
            loadCatFacts()
        })
    }
    
    private func loadCatFacts() {
        loading = true
        
        let animalTypeIndex = SharedSettings.getAnimalType()
        let animalType = animalTypes[animalTypeIndex]
        let amount = SharedSettings.getAmount()
        
        let factsUrl = Config.getFactsUrl(animalType, amount)
        
        Api.shared.queryFact(
            factsUrl,
            onSuccess: { json in
                loading = false
                
                if amount == "1" {
                    guard let response = try? Util.fromJson(json, Fact.self) else {
                        #if DEBUG
                        print("could't parse facts json: \(json)")
                        #endif
                        
                        self.facts = []
                        return
                    }
                    
                    self.facts = [response]
                } else {
                    guard let response = try? Util.fromJson(json, Array<Fact>.self) else {
                        #if DEBUG
                        print("could't parse facts json: \(json)")
                        #endif
                        
                        self.facts = []
                        return
                    }
                    
                    self.facts = response
                }
            }, onError: { error in
                loading = false
                
                #if DEBUG
                print("could't get facts: \(error)")
                #endif
                
                self.facts = []
            }
        )
    }
    
    private func getFormattedDate(string: String) -> String {
        let date = Util.parseDate(string: string)
        return Util.formatLocalized(date: date)
    }
}

struct FactsView_Previews: PreviewProvider {
    static var previews: some View {
        FactsView()
    }
}
