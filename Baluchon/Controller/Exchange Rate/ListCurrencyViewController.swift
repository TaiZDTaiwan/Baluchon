//
//  ListCurrencyViewController.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 08/06/2021.
//

import UIKit

class ListCurrencyViewController: UIViewController {
    
    // MARK: - Outlets from view

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variables and constants
    
    // To determine the index of the chosen path by the user.
    private var selectedIndexPath = 0
    
    // The currency chosen by the user which will be used to convert the original euro amount.
    private var selectedCurrencyListCurrencyVC = ""
    
    // Array which will stock and display the currencies concording with the user's research criteria.
    private var searchCurrency = [String]()
    
    // A bool which returns if the user is currently using the search bar to find a specific currency.
    private var searching: Bool {
        return !(searchBar.text?.isEmpty ?? true)
    }
    
    // The delegate to start a communication between ListCurrencyViewController and ExchangeRateViewController.
    weak var delegate: ExchangeRateSelectionDelegate?
}

// MARK: - Protocol table view

extension ListCurrencyViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Return the number of elements composing the table view, either is the number of elements conforming the searching bar criteria or the number total of currencies providing by the API and presenting in CurrencyAbreviationList file.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchCurrency.count
        } else {
            return CurrencyList.currencyAbreviationList.count
        }
    }
    
    // The elements to display in the different table view cells, again depending on the use of the searching bar.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currencyCell = tableView.dequeueReusableCell(withIdentifier: "currency")
        if searching {
            currencyCell?.textLabel?.text = searchCurrency[indexPath.row]
        } else {
            currencyCell?.textLabel?.text = CurrencyList.currencyAbreviationList[indexPath.row]
        }
        return currencyCell!
    }
    
    // To determine the chosen user cell and its component, also save this data in selectedCurrencyListCurrencyVC which will be sent to ExchangeRateViewController. Once a cell is chosen, the table view windows will dismiss.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath.row
        if searching {
            selectedCurrencyListCurrencyVC = searchCurrency[selectedIndexPath]
        } else {
            selectedCurrencyListCurrencyVC = CurrencyList.currencyAbreviationList[selectedIndexPath]
        }
        self.delegate?.didSelectCurrency(selectedCurrencyListCurrencyVC)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Protocol searching bar

extension ListCurrencyViewController: UISearchBarDelegate {
    
    //  Adding a letter in the searching bar would display the currencies starting with that letter, add an other letter to have an even more accurate searching, uppercase and lowercase letters all are accepted.
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCurrency = CurrencyList.currencyAbreviationList.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        tableView.reloadData()
    }
    
    // To update the table view when a research is made with the searchbar.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.reloadData()
    }
}
