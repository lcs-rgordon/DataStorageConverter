//
//  ContentView.swift
//  iOS-DataStorageConverter
//
//  Created by Russell Gordon on 2021-02-11.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    @State private var fromUnit: DataStorageUnit = .bit
    @State private var input: String = ""
    @State private var toUnit: DataStorageUnit = .bit

    // MARK: Computed properties
    private var output: String {
        
        // Ensure the provided input can be expressed as an integer
        guard let providedValue = Int(input) else {
            return "Please provide an integer value."
        }

        // Return the converted value
        return convert(providedValue: providedValue, fromUnit: fromUnit, toUnit: toUnit)

    }
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Converting from?")) {
                    
                    Picker("From unit:", selection: $fromUnit) {
                        Text(DataStorageUnit.bit.rawValue).tag(DataStorageUnit.bit)
                        Text(DataStorageUnit.nibble.rawValue).tag(DataStorageUnit.nibble)
                        Text(DataStorageUnit.byte.rawValue).tag(DataStorageUnit.byte)
                        Text(DataStorageUnit.kilobyte.rawValue).tag(DataStorageUnit.kilobyte)
                        Text(DataStorageUnit.megabyte.rawValue).tag(DataStorageUnit.megabyte)
                        Text(DataStorageUnit.gigabyte.rawValue).tag(DataStorageUnit.gigabyte)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                
                Section(header: Text("Value to convert?")) {
                    TextField("e.g.: 1024", text: $input)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Converting to?")) {
                    
                    Picker("To unit:", selection: $toUnit) {
                        Text(DataStorageUnit.bit.rawValue).tag(DataStorageUnit.bit)
                        Text(DataStorageUnit.nibble.rawValue).tag(DataStorageUnit.nibble)
                        Text(DataStorageUnit.byte.rawValue).tag(DataStorageUnit.byte)
                        Text(DataStorageUnit.kilobyte.rawValue).tag(DataStorageUnit.kilobyte)
                        Text(DataStorageUnit.megabyte.rawValue).tag(DataStorageUnit.megabyte)
                        Text(DataStorageUnit.gigabyte.rawValue).tag(DataStorageUnit.gigabyte)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }

                Section(header: Text("Result is:")) {
                    
                    Text(output)
                        // Ensures text will wrap to multiple lines
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                }

            }
            .navigationTitle("Storage Converter")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
