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
                
                if error != nil {
                    self.forecastDisplay.text = "Something has gone wrong, trying typing your location again"
                } else {
                    if let unwrappedData = data {
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        print(dataString as Any)
                    }
                }
            }
            
            weatherSearch.resume()
            
        }

        
        
        
//        if let url = URL(string: "http://stackoverflow.com") {
//            
//            let request = NSMutableURLRequest(url: url)
//            
//            let task = URLSession.shared.dataTask(with: request as URLRequest) {
//                //3 things we get back - data, responce, error
//                data, response, error in
//                
//                if error != nil {
//                    print(error as Any)
//                } else {
//                    if let unwrappedData = data {
//                        //UTF8 is standard encoding
//                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
//                        
//                        print(dataString as Any)
//                        
//                        DispatchQueue.main.sync(execute: {
//                            
//                            //Update UI would go here AFTER stuff has loaded
//                            
//                        })
//                        
//                    }
//                }
//                
//            }
//            //this is making it RUN or nothing happensd
//            task.resume()
//        }
        
        
        
        
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

