//
//  TranslaterViewController.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 04/06/2021.
//

import UIKit

class TranslaterViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets from view
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var languagesStackView: UIStackView!
    @IBOutlet weak var toTranslateTextField: UITextField!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var toTranslateLanguageLabel: UILabel!
    @IBOutlet weak var translatedLanguageLabel: UILabel!
    @IBOutlet weak var swapLanguagesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables and constants

    // Int use in the language selection process.
    private var userTag = 0
    
    // Text typed by the user to translate.
    private var typedTextToTranslate: String? {
        return toTranslateTextField.text
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        prepareMainViewInterface()
        super.viewDidLoad()
    }
    
    // MARK: - Functions and Actions dragged from view
    
    // To set up the whole interface view to load before appearing.
    private func prepareMainViewInterface() {
        translatedTextView.inputView = UIView()
        toTranslateTextField.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        translatedTextView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        mainView.setTemplateBackground()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // If there is a text in toTranslateTextField, launch the translation process if user stop typing at least for 1 sec, otherwise display "Traduction" in translatedTextView.
    @IBAction func typeToTranslateTextFieldKeyboard(_ sender: UITextField) {
        let textBeforeDelay = typedTextToTranslate
        
        if let userTapText = typedTextToTranslate {
            if userTapText.isEmpty {
                translatedTextView.text = "Traduction"
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let textAfterDelay = self.typedTextToTranslate
                    if textBeforeDelay == textAfterDelay {
                        self.launchTranslationProcess()
                    }
                }
            }
        }
    }
    
    // To launch the translation process from the translater session file and determine the next steps depending on the success of getting API's data.
    private func launchTranslationProcess() {
        guard let userTapText = typedTextToTranslate else {
            presentAlert("Impossible to type text.")
            return
        }
    
        TranslaterService.shared.getTranslation(userTag: userTag, text: userTapText) { [weak self] success, translation in
            if success, let translation = translation {
                self?.getTranslation(translation)
                self?.setMinimumAnimationTimeForActivityIndicator()
            } else {
                self?.presentAlert("The translation download has failed.")
            }
        }
    }
    
    // Because the delay of getting API's data is too fast, set a length activity indicator animation to 0.4 sec.
    private func setMinimumAnimationTimeForActivityIndicator() {
        toggleActivityIndicator(shown: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.toggleActivityIndicator(shown: false)
        }
    }
    
    // To display or dismiss the activity indicator and other view elements.
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        toTranslateTextField.isHidden = shown
        translatedTextView.isHidden = shown
    }
    
    // To display the tranlation provinded by API in the translatedTextView.
    private func getTranslation(_ translation: Translation) {
        let text = translation.data.translations[0].translatedText
        translatedTextView.text = text
    }
    
    // To dismiss the keyboard linked to toTranslateTextField when the user taped outside the keyboard.
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        toTranslateTextField.resignFirstResponder()
    }
    
    // When swapLanguagesButton taped, start the swap languages process.
    @IBAction func tapSwapLanguagesButton(_ sender: UIButton) {
        
        if toTranslateLanguageLabel.text == "Français" {
            swapLanguagesTitleLabel(toTranslateLanguage: "Anglais", translatedLanguage: "Français", tag: 1)
            if toTranslateTextField.hasText {
                let saveText = toTranslateTextField.text
                swapTextFieldAndTextViewContent(toTranslateText: translatedTextView.text, translatedText: saveText!)
            }
        } else {
            swapLanguagesTitleLabel(toTranslateLanguage: "Français", translatedLanguage: "Anglais", tag: 0)
            if toTranslateTextField.hasText {
                let saveText = toTranslateTextField.text
                swapTextFieldAndTextViewContent(toTranslateText: translatedTextView.text, translatedText: saveText!)
            }
        }
    }
    
    // To swap the languages title label.
    private func swapLanguagesTitleLabel(toTranslateLanguage: String, translatedLanguage: String, tag: Int) {
        toTranslateLanguageLabel.text = toTranslateLanguage
        translatedLanguageLabel.text = translatedLanguage
        userTag = tag
    }
    
    // To swap in toTranslateTextField and translatedTextView the orignal text with the translated text.
    private func swapTextFieldAndTextViewContent(toTranslateText: String, translatedText: String) {
        toTranslateTextField.text = toTranslateText
        translatedTextView.text = translatedText
    }
}
