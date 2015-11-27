//
//  ViewController.swift
//  HelloJSON
//
//  Created by Thanh Vu on 11/27/15.
//  Copyright © 2015 Thanh Vu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UITextView!
    @IBOutlet var userInfo: [UIButton]!
    
    var userArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let jsonObjectUrl = "http://jjwanda.com/jsonTest/jsonObject.html"
        let jsonArrayUrl = "http://jjwanda.com/jsonTest/jsonArray.html"
        
        print("viewDidLoad")
        if let url = NSURL(string: jsonArrayUrl) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                    for item in json[].arrayValue{
                        let user = User(json: item)
                        userArray.append(user)
        
                        print(user.name)
                }
            }
        }
        
        for i in 0...2{
            print("i \(i)")
            userInfo[i].setTitle(userArray[i].name, forState: UIControlState.Normal)
        }
        display.text = ""
    }

    
    @IBAction func userInfo(sender: UIButton) {
        var u = userArray[0]
        switch sender.currentTitle!{
        case userArray[0].name: u = userArray[0]
        case userArray[1].name: u = userArray[1]
        case userArray[2].name: u = userArray[2]
        default: break
        }
        let info = "name: \(u.name) \nid: \(u.id) \nadmin: \(u.admin) \ncash: \(u.cash)"
        print(info)
        display.text = info
    }
    
}

class User: NSObject {
    
    var id: Int
    var name: String
    var admin: Bool
    var cash: Double
    
    init(id: Int, name: String, admin:Bool, cash: Double) {
        self.id = id
        self.name = name
        self.admin = admin
        self.cash = cash
    }
    
    // should check this
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.admin = json["admin"].boolValue
        self.cash = json["cash"].doubleValue
    }
    
    func toString() -> String{
        return "id: \(id), name: \(name), admin: \(admin), cash: \(cash)"
    }
}
