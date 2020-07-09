//
//  ViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 09.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    internal let firstFloat: Float? = 3.0
    internal let secondFloat: Float? = nil
    
    internal var arrayInt = [18,7,3,65,12,4,9,2,73,10]
    
    internal var stringTask: String = "abc123"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTwoDouble(a: 5, b: 7)
        createCortege(firstName: "Ivan", lastName: "Ivanov")
        createTwoFloat(statement: firstFloat)
        createTwoFloat(statement: secondFloat)
        createFibonacciSeries()
        bubbleSort(arrayInt)
        stringFormatter(stringTask: stringTask)
    }
    
    //MARK: - Задание 2
    func createTwoDouble(a:Double, b:Double) {
        let a: Double = a
        let b: Double = b
        let avarage = (a + b) / 2
        print(avarage)
    }
    
    //MARK: - Задание 3
    func createCortege(firstName: String, lastName: String) {
        let userInfo: (String, String) = (firstName: firstName, lastName: lastName)
        let fullName = userInfo.0 + " \(userInfo.1)"
        print(fullName)
    }
    
    //MARK: - Задание 4
    func createTwoFloat(statement: Float?) {
        guard statement != nil else {
            return print("Variable can't be unwrapped")
        }
        print(statement!)
    }
    
    //MARK: - Задание 5
    func createFibonacciSeries() {
        var x: Int = -1
        var y: Int = 1
        var sum: Int = 0
        print("Start Fibonacci Series")
        for _ in 0..<15 {
            sum = x + y
            x = y
            y = sum
            print(sum)
        }
        print("End Fibonacci Series")
    }
    
    //MARK: - Задание 6
    func bubbleSort(_ arrayInt: [Int]) -> [Int] {
        var array = arrayInt
        for _ in 0...array.count {
            for value in 1...array.count - 1 {
                if array[value-1] > array[value] {
                    let largerValue = array[value-1]
                    array[value-1] = array[value]
                    array[value] = largerValue
                }
            }
        }
        print("Отсортированный массив: \(array)")
        return array
    }
    
    //MARK: - Задание 7
    func stringFormatter(stringTask: String) {
        //var a = stringTask.last
        if let number = Int(stringTask.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            let changeNumber = number + 1
            let newString = stringTask.dropLast(3)
            print("\(newString)\(changeNumber)")
        }
    }
}

