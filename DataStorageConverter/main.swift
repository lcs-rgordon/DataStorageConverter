//
//  main.swift
//  DataStorageConverter
//
//  Created by Russell Gordon on 2021-02-11.
//

import Foundation

/// Prints the data storage unit options
func printDataStorageUnitOptions() {
    print("""
        1 - bit
        2 - nibble
        3 - byte
        4 - kilobyte
        5 - megabyte
        6 - gigabyte

        Q - Quit Program

        """)
}

/// Converts the data storage selection from a string to an enumeration case
func convertToEnumerationCase(selection: String) -> DataStorageUnits {
    switch selection {
    case "1":
        return .bit
    case "2":
        return .nibble
    case "3":
        return .byte
    case "4":
        return .kilobyte
    case "5":
        return .megabyte
    case "6":
        return .gigabyte
    default:
        return .bit
    }
}

// Loop until program is quit
while true {
    
    // MARK: Input
    
    // Show initial menu
    print("""
        Data Storage Converter
        ======================

        Converting from?

        """)
    printDataStorageUnitOptions()
    
    // What data storage unit are we converting from?
    let providedFromUnit = String.collectInput(withPrompt: "Please make a selection (1/2/3/4/5/6/Q): ",
                                               acceptableValues: ["1", "2", "3", "4", "5", "6", "Q", "q"]).uppercased()
    
    // Exit program if user chose to quit
    if providedFromUnit == "Q" {
        exit(0)
    }
    
    // Get the value to be converted
    let providedValue = Int.collectInput(withPrompt: "\nEnter the value to be converted: ", minimum: 0, maximum: nil)
    
    // What system are we converting to?
    print("""

        Converting to?

        """)
    printDataStorageUnitOptions()
    
    // What data storage unit are we converting to?
    let providedToUnit = String.collectInput(withPrompt: "Please make a selection (1/2/3/4/5/6/Q): ",
                                             acceptableValues: ["1", "2", "3", "4", "5", "6", "Q", "q"]).uppercased()
    
    // Exit program if user chose to quit
    if providedToUnit == "Q" {
        exit(0)
    }

    // MARK: Process

    // Translate the provided "from" unit from the input menu into an enumeration case
    let fromUnit = convertToEnumerationCase(selection: providedFromUnit)
    
    // Translate the provided "to" unit from the input menu into an enumeration case
    let toUnit = convertToEnumerationCase(selection: providedToUnit)
    
    // Convert the provided value to an equivalent value in bits
    let interimValue = convertToBits(from: fromUnit, value: providedValue)
    
    // Convert to the desired destination unit
    let finalValue = convertFromBits(to: toUnit, value: interimValue)

    // MARK: Output

    // Report results
    let result = getDataStorageConversionResult(providedValue: providedValue,
                                                finalValue: finalValue,
                                                fromUnit: fromUnit,
                                                toUnit: toUnit)
    print(result)

    // Pause before continuing
    print("\nPress return to continue.")
    
    // This captures the return key
    _ = readLine()
}
