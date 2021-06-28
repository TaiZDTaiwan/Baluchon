//
//  Test.swift
//  BaluchonTests
//
//  Created by Raphaël Huang-Dubois on 21/06/2021.
//

import XCTest
@testable import Baluchon

class AmountTestCase: XCTestCase {
    private var amount: Amount!

    override func setUp() {
        super.setUp()
        amount = Amount()
    }
    
    func testGivenAmountWithoutEuroSign_WhenAddingValueToAmountInTextWithoutEuroSign_ThenAmountWithoutEuroSignReturnADoubleOfAmountInTextWithoutEuroSign() {
        amount.amountInTextWithoutEuroSign = "80"
        XCTAssertTrue(amount.amountWithoutEuroSign == 80.0)
    }
    
    func testGivenStockAmountInEuroCountIsLessThanTwo_WhenApplyingFunctionAddNumberToAmount_ThenInsertNumberToAddInIndexZeroOfArray() {
        amount.addNumberToAmount("test")
        XCTAssertTrue(amount.stockAmountInEuro[0] == "test")
    }
    
    func testGivenStockAmountInEuroCountIsMoreThanOne_WhenApplyingFunctionAddNumberToAmount_ThenInsertNumberToAddInIndexOneOfArray() {
        amount.stockAmountInEuro.append("new element")
        amount.addNumberToAmount("test")
        XCTAssertTrue(amount.stockAmountInEuro[1] == "test")
    }
    
    func testGivenStockAmountInEuroHasEuroSign_WhenApplyingFunctionGetAmountInTextWithoutEuroSign_ThenAmountInTextWithoutEuroSignHasNotEuroSign() {
        amount.getAmountInTextWithoutEuroSign()
        let test = amount.amountInTextWithoutEuroSign.contains(" EUR")
        XCTAssertFalse(test)
    }
    
    func testGivenStockAmountInEuroWithValues_WhenApplyingFunctionRemoveEntireAmountInEuro_ThenOnlyRemainsSpaceAndEuroSignInIndexZero() {
        amount.stockAmountInEuro.append("80")
        amount.removeEntireAmountInEuro()
        XCTAssertTrue(amount.stockAmountInEuro[0] == " EUR")
    }
    
    func testGivenStockAmountOtherCurrencyIsLessThanTwo_WhenApplyingFunctionInsertConvertedInArray_ThenInsertAmountInIndexZero() {
        amount.insertConvertedAmountInArray(80.0)
        XCTAssertTrue(amount.stockAmountOtherCurrency[0] == "80.0")
    }
    
    func testGivenStockAmountOtherCurrencyIsMoreThanOne_WhenApplyingFunctionInsertConvertedInArray_ThenRemoveFirstArrayElementAndInsertAmountInIndexZero() {
        amount.stockAmountOtherCurrency.append("one element")
        amount.stockAmountOtherCurrency.append("two element")
        amount.insertConvertedAmountInArray(80.0)
        XCTAssertTrue(amount.stockAmountOtherCurrency[0] == "80.0")
    }
    
    func testGivenStockAmountOtherCurrencyIsMoreThanOne_WhenApplyingFunctionDisplayNewCurrencyignInArray_ThenRemoveLastArrayElementAndInsertLabelCurrencyInLastIndex() {
        amount.stockAmountOtherCurrency.append("one element")
        amount.stockAmountOtherCurrency.append("two element")
        amount.displayNewCurrencySignInArray("EUR")
        XCTAssertTrue(amount.stockAmountOtherCurrency.last == "EUR")
    }
}
