

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    let currencySymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var currencySelected = ""
    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
       
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
  
    // this will get called EVERYTIME the picker is scrolled.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getBitcoinData(url: finalURL)
        currencySelected = currencySymbolArray[row]
    }
    
    
    

    
    
    
//    
    //    //MARK: - Networking
    //    /***************************************************************/
    
        func getBitcoinData(url: String) {
            
            Alamofire.request(url, method: .get)
                .responseJSON { response in
                    if response.result.isSuccess {
    
                        print("Sucess! Got the money data")
                        let moneyJSON : JSON = JSON(response.result.value!)
    
                        self.updateBitcoinData(json: moneyJSON)
    
                    } else {
                        print("Error: \(String(describing: response.result.error))")
                        self.bitcoinPriceLabel.text = "Connection Issues"
                    }
                }
    
        }
    
    
//
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitcoinData(json : JSON) {
        
        if let bitcoinResult = json["ask"].double {
            bitcoinPriceLabel.text = String(currencySelected) + String(bitcoinResult)
            
        }
        
        else{
            bitcoinPriceLabel.text = "Currency Unavailable"
        }
       
    }
    




}

