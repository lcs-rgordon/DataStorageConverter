//
//  Functions.swift
//  DataStorageConverter
//
//  Created by Russell Gordon on 2021-02-11.
//

import Foundation

/// Converts a given value in one of the allowed DataStorageUnits to an equivalent value in bits.
/// - Parameters:
///   - from: What data storage unit the provided value is in.
///   - value: The value to convert to bits.
/// - Returns: The provided value in bits.
func convertToBits(from: DataStorageUnits, value: Int) -> Int {
    
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

/// Converts a given value in bits to an equivalent value in one of the allowed DataStorageUnits.
/// - Parameters:
///   - to: What data storage unit the value in bits should be converted to.
///   - value: The value to be converted.
/// - Returns: The provided value in the desired data storage unit.
func convertFromBits(to: DataStorageUnits, value: Int) -> Int {
    
    switch to {
    case .bit:
        return value
    case .nibble:
        return value / 4
    case .byte:
        return value / 8
    case .kilobyte:
        return value / 8192
    case .megabyte:
        return value / 8388608
    case .gigabyte:
        return value / 8589934592
    }
    
}
