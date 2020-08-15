//
//  ViewController.swift
//  JsonPOSTMethod
//
//  Created by Mac on 15/08/20.
//  Copyright © 2020 Akash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtBody: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnPostClick(_ sender: Any) {
        setupPostMethod()
    }
    

}

extension ViewController{
    func setupPostMethod() {
        guard let uid = self.txtID.text else {return}
        guard let title = self.txtTitle.text else {return}
        guard let body = self.txtBody.text else {return}
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameter: [String : Any] = [
                "userId":uid,
                "title":title,
                "body":body
            ]
            
            request.httpBody = parameter.percentEscaped().data(using: .utf8)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error == nil{
                    print("nodata")
                        print(error?.localizedDescription ?? "Unkown error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    guard (200...299) ~= response.statusCode else{
                        print("statusCode :- \(response.statusCode)")
                        return
                    }
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch let error{
                    print(error.localizedDescription)
                }
                }.resume()
        }

    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
