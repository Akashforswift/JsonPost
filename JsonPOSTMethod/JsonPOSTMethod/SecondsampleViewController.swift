//
//  SecondsampleViewController.swift
//  JsonPOSTMethod
//
//  Created by Mac on 15/08/20.
//  Copyright © 2020 Akash. All rights reserved.
//

import UIKit

class SecondsampleViewController: UIViewController {

    @IBOutlet weak var txtid: UITextField!
    @IBOutlet weak var txttitle: UITextField!
    @IBOutlet weak var txtbody: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        sendData()
    }
    
    @IBAction func sendbtn(_ sender: UIButton) {
        
    }
    
    func sendData(){
        guard let uid = txtid.text else{return}
        guard let title = txttitle.text else{return}
        guard let body = txtbody.text else{return}

        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts"){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
            
            
            let parameter: [String:Any] = [
                "useId": uid,
                "title": title,
                "body": body
            ]
            
            request.httpBody
        }
        
        
        
    }
    
}


