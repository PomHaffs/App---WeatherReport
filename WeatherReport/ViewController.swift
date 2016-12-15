//
//  ViewController.swift
//  WeatherReport
//
//  Created by Tomas-William Haffenden on 15/12/16.
//  Copyright © 2016 PomHaffs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var forecastDisplay: UILabel!
    
    @IBAction func searchButtonPressed(_ sender: Any) {
       
        var searchLocation = searchTextField.text
        
        searchLocation = searchLocation?.replacingOccurrences(of: " ", with: "-").capitalized
        
        let searchURL = "http://www.weather-forecast.com/locations/\(searchLocation!)/forecasts/latest"
        
        if let url = URL(string: searchURL) {
            
            print(url)
            
            let request = NSMutableURLRequest(url: url)
            
            let weatherSearch = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                var message = ""
                
                if error != nil {
                    
                    print(error as Any)
                
                } else {
                    
                    if let unwrappedData = data {
                        
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                            
                            if contentArray.count > 0 {
                                
                                stringSeparator = "</span>"
                                
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                    
                                    if newContentArray.count > 0 {
                                        
                                        message = newContentArray[0].replacingOccurrences(of: "&deg;C", with: "°")
                                        
                                        print(newContentArray[0])
                                    }
                                
                            }
                        }
                    }
                }
            }
            
            weatherSearch.resume()
            
        }

        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //KEYBOARD REMOVAL
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

}

