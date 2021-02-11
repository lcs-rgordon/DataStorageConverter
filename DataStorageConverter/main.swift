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
    var fromUnit: DataStorageUnits = .bit
    switch providedFromUnit {
    case "1":
        fromUnit = .bit
    case "2":
        fromUnit = .nibble
    case "3":
        fromUnit = .byte
    case "4":
        fromUnit = .kilobyte
    case "5":
        fromUnit = .megabyte
    case "6":
        fromUnit = .gigabyte
    default:
        break
    }
    
    // Translate the provided "to" unit from the input menu into an enumeration case
    var toUnit: DataStorageUnits = .bit
    switch providedToUnit {
    case "1":
        toUnit = .bit
    case "2":
        toUnit = .nibble
    case "3":
        toUnit = .byte
    case "4":
        toUnit = .kilobyte
    case "5":
        toUnit = .megabyte
    case "6":
        toUnit = .gigabyte
    default:
        break
    }
    
    // Convert the provided value to an equivalent value in bits
    let interimValue = convertToBits(from: fromUnit, value: providedValue)
    
    // Convert to the desired destination unit
    let finalValue = convertFromBits(to: toUnit, value: interimValue)
    
    // MARK: Output
    if providedValue == 1 && finalValue.quotient == 1 {
        
        print("""

            \(providedValue) \(fromUnit.rawValue) is equal to \(finalValue.quotient) \(toUnit.rawValue)
            """, terminator: "")
                
    } else if providedValue == 1 {
        print("""

            \(providedValue) \(fromUnit.rawValue) is equal to \(finalValue.quotient) \(toUnit.rawValue)s
            """, terminator: "")

    } else if finalValue.quotient == 1 {
        
        print("""

            \(providedValue) \(fromUnit.rawValue)s is equal to \(finalValue.quotient) \(toUnit.rawValue)
            """, terminator: "")

    } else {
        
        print("""

            \(providedValue) \(fromUnit.rawValue)s is equal to \(finalValue.quotient) \(toUnit.rawValue)s
            """, terminator: "")

    }
    
    if finalValue.remainder == 1 {
        print(" with a remainder of \(finalValue.remainder) \(fromUnit.rawValue)", terminator: "")
    } else if finalValue.remainder > 1 {
        print(" with a remainder of \(finalValue.remainder) \(fromUnit.rawValue)s", terminator: "")
    }

    print("""
        .

        Press return to continue.
        """)
    
    // This captures the return key
    _ = readLine()
}
