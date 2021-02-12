//
//  Functions.swift
//  DataStorageConverter
//
//  Created by Russell Gordon on 2021-02-11.
//

import Foundation

/// Converts a value in a permited DataStorageUnit to an equivalent value in bits.
/// - Parameters:
///   - from: What data storage unit the provided value is in.
///   - value: The value to convert to bits.
/// - Returns: The provided value in bits.
func convertToBits(from: DataStorageUnit, value: Int) -> Int {
    
    switch from {
    case .bit:
        return value
    case .nibble:
        return value * 4
    case .byte:
        return value * 8
    case .kilobyte:
        return value * 8192
    case .megabyte:
        return value * 8388608
    case .gigabyte:
        return value * 8589934592
    }
    
}

/// Converts a given value in bits to an equivalent value in one of the allowed DataStorageUnit.
/// - Parameters:
///   - to: What data storage unit the value in bits should be converted to.
///   - value: The value to be converted.
/// - Returns: The provided value in the desired data storage unit.
func convertFromBits(to: DataStorageUnit, value: Int) -> (quotient: Int, remainder: Int) {
    
    switch to {
    case .bit:
        return (value, value % 1)
    case .nibble:
        return (value / 4, value % 4)
    case .byte:
        return (value / 8, value % 8)
    case .kilobyte:
        return (value / 8192, value % 8192)
    case .megabyte:
        return (value / 8388608, value % 8388608)
    case .gigabyte:
        return (value / 8589934592, value % 8589934592)
    }
    
}


/// Generates a user-friendly sentence summarizing conversion results, with correct pluralization.
/// - Parameters:
///   - providedValue: The value converted.
///   - finalValue: The converted value.
///   - fromUnit: The unit of the value that was converted.
///   - toUnit: The unit that the value was converted to.
/// - Returns: A sentence summarizing the conversion.
func getDataStorageConversionResult(providedValue: Int,
                                    finalValue: (quotient: Int, remainder: Int),
                                    fromUnit: DataStorageUnit,
                                    toUnit: DataStorageUnit) -> String {

    // Start building the result
    var result = ""
    
    // Handle pluralization
    if providedValue == 1 && finalValue.quotient == 1 {
        
        result += """
                \(providedValue) \(fromUnit.rawValue) is equal to \(finalValue.quotient) \(toUnit.rawValue)
                """
                
    } else if providedValue == 1 {
        
        result += """
                \(providedValue) \(fromUnit.rawValue) is equal to \(finalValue.quotient) \(toUnit.rawValue)s
                """

    } else if finalValue.quotient == 1 {
        
        result += """
                \(providedValue) \(fromUnit.rawValue)s is equal to \(finalValue.quotient) \(toUnit.rawValue)
                """

    } else {
        
        result += """
                \(providedValue) \(fromUnit.rawValue)s is equal to \(finalValue.quotient) \(toUnit.rawValue)s
                """
    }
    
    // Report the remainder, if there is one
    if finalValue.remainder == 1 {
        result += " with a remainder of \(finalValue.remainder) bit"
    } else if finalValue.remainder > 1 {
        result += " with a remainder of \(finalValue.remainder) bits"
    }

    // Finish the sentence
    result += "."
    
    // Return complete result
    return result
}

/// Given a value in one data storage unit, returns a summary of the equivalent in another data unit.
/// - Parameters:
///   - providedValue: The value to convert.
///   - fromUnit: What data storage unit the provided value is in.
///   - toUnit: What data storage unit the value should be converted to.
/// - Returns: A written summary of the equivalent value in the desired data storage unit.
func convert(providedValue: Int, fromUnit: DataStorageUnit, toUnit: DataStorageUnit) -> String {
    
    // Convert the provided value to an equivalent value in bits
    let interimValue = convertToBits(from: fromUnit, value: providedValue)
    
    // Convert to the desired destination unit
    let finalValue = convertFromBits(to: toUnit, value: interimValue)

    // Get result
    let result = getDataStorageConversionResult(providedValue: providedValue,
                                                finalValue: finalValue,
                                                fromUnit: fromUnit,
                                                toUnit: toUnit)

    // Return the result
    return result
    
}
