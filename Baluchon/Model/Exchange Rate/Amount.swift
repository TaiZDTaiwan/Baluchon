//
//  Amount.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 07/06/2021.
//

import Foundation

class Amount {
    
    // MARK: - Variables and constants
    
    // Array to stock the amount in EUR to convert including EUR sign.
    var stockAmountInEuro = [" EUR"]
    
    // To transform stockAmountInEuro array into one single string.
    var showAmountInEuro: String {
        return stockAmountInEuro.joined(separator: "")
    }
    
    // To stock the amount in EUR into one single string without the EUR sign at the end.
    var amountInTextWithoutEuroSign = ""
    
    // To tranform and stock the amount in EUR from one single string to a Double type.
    var amountWithoutEuroSign: Double? {
        return Double(amountInTextWithoutEuroSign)
    }
    
    // Array to stock the amount converted into the user's chosen currency.
    var stockAmountOtherCurrency = [""]
    
    // To transform stockAmountOtherCurrency array into one single string.
    var showAmountInOtherCurrency: String {
        return stockAmountOtherCurrency.joined(separator: "")
    }
    
    // MARK: - Functions
    
    // To add a number or decimal sign into stockAmountInEuro array, will always place that string before the EUR sign.
    func addNumberToAmount(_ numberToAdd: String) {
        let lastIndex = stockAmountInEuro.endIndex
        if stockAmountInEuro.count < 2 {
            stockAmountInEuro.insert(numberToAdd, at: 0)
        } else {
            stockAmountInEuro.insert(numberToAdd, at: lastIndex-1)
        }
    }
    
    // To get the amount in euro to convert into one single string without the EUR sign.
    func getAmountInTextWithoutEuroSign() {
        var removeEuroSign = [String]()
        let euroSign = " EUR"
        removeEuroSign = stockAmountInEuro
        removeEuroSign.removeAll(where: { euroSign.contains($0) })
        amountInTextWithoutEuroSign = removeEuroSign.joined(separator: "")
    }
    
    // To remove the current euro amount from array to start a new conversion.
    func removeEntireAmountInEuro() {
        stockAmountInEuro.removeAll()
        stockAmountInEuro.append(" EUR")
    }
    
    // To remove if necessarly the previous converted amount and insert the new one in the array stockAmountOtherCurrency.
    func insertConvertedAmountInArray(_ amount: Double) {
        if stockAmountOtherCurrency.count < 2 {
            stockAmountOtherCurrency.insert(String(amount), at: 0)
        } else {
            stockAmountOtherCurrency.remove(at: 0)
            stockAmountOtherCurrency.insert(String(amount), at: 0)
        }
    }
    
    // To remove the previous currency sign and display the new one selected by the user.
    func displayNewCurrencySignInArray(_ labelCurrency: String) {
        if stockAmountOtherCurrency.count < 2 {
            stockAmountOtherCurrency.removeAll()
            stockAmountOtherCurrency.append(labelCurrency)
        } else {
            stockAmountOtherCurrency.removeLast()
            stockAmountOtherCurrency.append(labelCurrency)
        }
    }
}
