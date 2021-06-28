//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 04/06/2021.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    // MARK: - Outlets from view
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var euroLabel: UILabel!
    @IBOutlet weak var otherCurrencyLabel: UILabel!
    @IBOutlet weak var leftButtonsStackView: UIStackView!
    @IBOutlet weak var middleButtonsStackView: UIStackView!
    @IBOutlet weak var rightButtonsStackView: UIStackView!
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var euroButton: UIButton!
    @IBOutlet weak var otherCurrencyButton: UIButton!
    @IBOutlet weak var handTapImage: UIImageView!
    @IBOutlet weak var tapIndicationLabel: UILabel!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables and constants
    
    // Class amount instance.
    private let amount = Amount()
    
    // The converted currency sign chosen by the user.
    private var selectedOtherCurrency = "USD"
    
    // The string to display in otherCurrencyLabel, including a space and the converted currency sign chosen by the user.
    private var selectedOtherCurrecyToShowInView: String {
        return " " + selectedOtherCurrency
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        prepareMainViewInterface()
        adjustAlphaForMainViewInterface(alpha: 0.2)
        super.viewDidLoad()
    }
    
    // MARK: - Functions and Actions dragged from view
    
    // To set up the whole interface view to load before appearing.
    private func prepareMainViewInterface() {
        mainView.setTemplateBackground()
        euroLabel.setRateLabelsBackground()
        otherCurrencyLabel.setRateLabelsBackground()
        setCalculatorButtonsBackgroundColor(buttonsCollection)
        euroButton.setEuroButtonBackgroundAndLayout()
        otherCurrencyButton.setOtherCurrencyButtonBackgroundAndLayout()
        euroLabel.text = amount.showAmountInEuro
        amount.displayNewCurrencySignInArray(selectedOtherCurrecyToShowInView)
        otherCurrencyLabel.text = amount.showAmountInOtherCurrency
    }
    
    // To adjust the opacity of various elements in main view.
    private func adjustAlphaForMainViewInterface(alpha: CGFloat) {
        euroLabel.alpha = alpha
        otherCurrencyLabel.alpha = alpha
        euroButton.alpha = alpha
        leftButtonsStackView.alpha = alpha
        middleButtonsStackView.alpha = alpha
        rightButtonsStackView.alpha = alpha
    }
    
    // To set up all the calculator buttons background.
    private func setCalculatorButtonsBackgroundColor(_ collection: [UIButton]) {
        for oneButton in collection {
            oneButton.setBackgroundColor()
        }
    }
    
    // To dismiss indication when tapping anywhere on screen.
    @IBAction func dismissIndication(_ sender: UITapGestureRecognizer) {
        adjustAlphaForMainViewInterface(alpha: 1.0)
        handTapImage.isHidden = true
        tapIndicationLabel.isHidden = true
    }
    
    // When a number button is tapped, add this number in Euro array, print it in the euroLabel and launch the exchange rate process if user stop typing for 0.5 sec.
    @IBAction func tapNumberButton(_ sender: UIButton) {
        dismissIndication(tapGestureRecognizer)
        
        guard let numberText = sender.title(for: .normal) else {
            self.presentAlert("Insert a number process has failed.")
            return
        }
        amount.addNumberToAmount(numberText)
        euroLabel.text = amount.showAmountInEuro
        let amountInEuroBeforeDelay = amount.showAmountInEuro
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let amountInEuroAfterDelay = self.amount.showAmountInEuro
            if amountInEuroBeforeDelay == amountInEuroAfterDelay {
                self.launchCurrencyRateProcess()
            }
        }
    }
    
    // To launch the currency rate process from the exchange rate session file and determine the next steps depending on the success of getting API's data.
    private func launchCurrencyRateProcess() {
        ExchangeRateService.shared.getRate { [weak self] (success, exchangeRate) in
            if success, let exchangeRate = exchangeRate {
                self?.determineNewConvertedAmount(exchangeRate)
                self?.setMinimumAnimationTimeForActivityIndicator()
            } else {
                self?.presentAlert("The exchange rate download has failed.")
            }
        }
    }
    
    // Because the delay of getting API's data is too fast, set a length activity indicator animation to 0.4 sec and display the converted result in label after that delay.
    private func setMinimumAnimationTimeForActivityIndicator() {
        toggleActivityIndicator(shown: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.toggleActivityIndicator(shown: false)
            self.otherCurrencyLabel.text = self.amount.showAmountInOtherCurrency
        }
    }
    
    // To display or dismiss the activity indicator and the central buttons.
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        for oneButton in buttonsCollection {
            oneButton.isHidden = shown
        }
    }
    
    // To determine the converted euro amount into the user's selected currency conforming to API's rate and show that amount in the otherCurrencyLabel.
    private func determineNewConvertedAmount(_ exchangeRate: ExchangeRate) {
        amount.getAmountInTextWithoutEuroSign()
        let getCurrencyRate = exchangeRate.rates[selectedOtherCurrency]
        guard let amountWithoutEuroSign = amount.amountWithoutEuroSign else {
            self.presentAlert("Error in converting amount.")
            return
        }
        
        guard let getCurrencyRate = getCurrencyRate else {
            self.presentAlert("Error in getting exchange rate.")
            return
        }
        let amountConverted = amountWithoutEuroSign * getCurrencyRate
        let roundedAmount = Double(round(100 * amountConverted) / 100)
        amount.insertConvertedAmountInArray(roundedAmount)
    }
    
    // If stockAmountInEuro array does not contain a decimal sign, adds it in the array and adds a 0 if it's the first element.
    @IBAction func tapDecimalButton(_ sender: UIButton) {
        dismissIndication(tapGestureRecognizer)
        
        if !amount.stockAmountInEuro.contains(".") {
            if amount.stockAmountInEuro.count < 2 {
                amount.addNumberToAmount("0")
                addAndDisplayAnElementInEuroLabel(".")
            } else {
                addAndDisplayAnElementInEuroLabel(".")
            }
        }
    }
    
    // To add a string in the stockAmountInEuro array and display it in the euroLabel.
    private func addAndDisplayAnElementInEuroLabel(_ element: String) {
        amount.addNumberToAmount(element)
        euroLabel.text = amount.showAmountInEuro
    }
    
    // To remove both amount in currency labels but will still display the currency signs.
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        dismissIndication(tapGestureRecognizer)
        
        if amount.stockAmountOtherCurrency.count > 1 {
            amount.stockAmountOtherCurrency.removeFirst()
            otherCurrencyLabel.text = amount.showAmountInOtherCurrency
            amount.removeEntireAmountInEuro()
            euroLabel.text = amount.showAmountInEuro
        }
    }

    // To launch the communication between ListCurrencyViewController to ExchangeRateViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dismissIndication(tapGestureRecognizer)
        
        if segue.identifier == "segueToListCurrency" {
            guard let exchangeListCurrency = segue.destination as? ListCurrencyViewController else {
                self.presentAlert("Error in communicating exchange rate.")
                return
            }
            exchangeListCurrency.delegate = self
        }
    }
}

// MARK: - Protocol and its extension to implement a delegate

protocol ExchangeRateSelectionDelegate: AnyObject {
    func didSelectCurrency(_ currency: String)
}

// To communicate the currency chosen by the user from ListCurrencyViewController to ExchangeRateViewController, display the new currency sign in both button and label otherCurrency and launch the exchange rate process if an amount is visible in euroCurrencyLabel.

extension ExchangeRateViewController: ExchangeRateSelectionDelegate {
    func didSelectCurrency(_ currency: String) {
        selectedOtherCurrency = currency
        otherCurrencyButton.setTitle(selectedOtherCurrency, for: .normal)
        amount.displayNewCurrencySignInArray(selectedOtherCurrecyToShowInView)
        otherCurrencyLabel.text = amount.showAmountInOtherCurrency
        
        if amount.stockAmountOtherCurrency.count > 1 {
            launchCurrencyRateProcess()
        }
    }
}
