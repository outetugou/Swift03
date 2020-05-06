//
//  ViewController.swift
//  Swift03
//
//  Created by 王铁刚 on R 2/03/24.
//  Copyright © Reiwa 2 王铁刚. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func showAlertView(_ sender: Any) {
        let alert = UIAlertController(title: "aTitle", message: "aMessage", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "button1", style: .default, handler: { (action) in
//            print("click \(action.title!)")
//        }))
//        alert.addAction(UIAlertAction(title: "button2", style: .default, handler: { (action) in
//            print("click \(action.title!)")
//        }))
        alert.addAction(UIAlertAction(title: "cancel1", style: .cancel, handler: { (action) in
            print("click \(action.title!)")
        }))
//        alert.addAction(UIAlertAction(title: "delete1", style: .destructive, handler: { (action) in
//            print("click \(action.title!)")
//        }))
        alert.addTextField { (textField) in
            textField.delegate = self
        }
        self.present(alert, animated: true) {
            print("alert had shown")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myCircle = Circle()
        print("半径\(myCircle.radius)")
        print("面积\(myCircle.area)")
        
        let john = Person()
        if let roomCount = john.residence?.numberOfRooms {
            print(roomCount)
        }
        
        let array1 = [(5,6),(7,8),(9,10)]
        for item in array1.indices {
            print(item)
        }
        let numbers = [10,20,30,40]
        let dosome = numbers.map { (num:Int) -> Int in
            return num + 1
        }
        print(dosome)
        let scores = ["1", "2", "three", "four", "5"]
        let mapped: [Int?] = scores.map { str in Int(str) }
        print(mapped)
        let compactMapped: [Int] = scores.compactMap { str in Int(str) }
        print(compactMapped)
        
        let memb = ["dj":12,"db":13,"zh":14]
        let djValue = memb["dj"]
        let dbValue = memb["db"]
        print(djValue!,dbValue!)
        
//        let fiveImageView = UIImageView(image: UIImage(named: "five"))
//        fiveImageView.center = CGPoint(x: 100, y: 150)
//        view.addSubview(fiveImageView)
//        
//        UIView.animate(withDuration: 1.0,
//                       delay: 0,
//                       options: [.curveEaseInOut, .autoreverse, .repeat],
//                       animations: {
//                        fiveImageView.center.x = self.view.frame.width - 100
//        }, completion: nil)
    }
    
    func test1(para1: Int) -> Int {
        return 3
    }
    
}

class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    fileprivate var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

class Circle {
    fileprivate var radius:Double = 1
    fileprivate var area:Double {
        get {
            return radius * radius * Double.pi
        }
        set (menseki) {
            radius = sqrt(menseki / Double.pi)
        }
    }
}
