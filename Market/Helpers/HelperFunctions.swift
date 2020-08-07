//
//  HelperFunctions.swift
//  Market
//
//  Created by Aleksandar Savić on 10.06.20.
//  Copyright © 2020 Aleksandar Savić. All rights reserved.
//

import Foundation


func convertToCurrency(_ number: Double) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    return currencyFormatter.string(from: NSNumber(value: number))!
}
