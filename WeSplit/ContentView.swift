//
//  ContentView.swift
//  WeSplit
//
//  Created by Lucas Andrade on 01/05/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercetage = 20
    @FocusState private var amountIsFocused: Bool
    
    let currencyFormater = Locale.current.currencyCode ?? "USD"
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercetage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
    
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercetage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
//                Section {
//                    Picker("Tip percentage", selection: $tipPercetage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                } header: {
//                    Text("How much tip do you want to leave?")
//                }
                
                Section {
                    Picker("Tip (%)", selection: $tipPercetage) {
                        ForEach(0..<101) {
                            Text("\($0)%")
                        }
                        
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currencyFormater))
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(grandTotal, format: .currency(code: currencyFormater))
                } header: {
                    Text("Grand Total")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
