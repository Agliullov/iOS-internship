//
//  ViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 09.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //---Задание 2
    fileprivate let a: Double = 5.0
    fileprivate let b: Double = 7.0
    fileprivate var avarage: Double = 0.0
    //---Задание 3
    fileprivate let fullName: (String, String) = ("firstName", "lastName")
    //---Задание 4
    fileprivate let firstFloat: Float? = 3.0
    fileprivate var secondFloat: Float?
    //---Задание 6
    fileprivate var arrayInt = [18, 7, 3, 65, 12, 4, 9, 2, 73, 10]
    //---Задание 7
    fileprivate var trashString: String = "abc123"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.halfSummTwoNumber()
        self.printFullName()
        self.printOptionalNumber(number: self.firstFloat)
        self.printOptionalNumber(number: self.secondFloat)
        self.printFibonacciNumber()
        self.bubbleSort(self.arrayInt)
        self.replaceLastCharacterString(trashString: self.trashString)
    }
    
    //MARK: - Задание 2
    func halfSummTwoNumber() {
        self.avarage = (self.a + self.b) / 2
        print(avarage)
    }
    
    //MARK: - Задание 3
    func printFullName() {
        let fullName: String = "Full name: \(self.fullName.0)" + " \(self.fullName.1)"
        print(fullName)
    }
    
    //MARK: - Задание 4
    func printOptionalNumber(number: Float?) {
        guard let number = number else { return print("Variable can't be unwrapped") }
        print("Number: \(number)")
    }
    
    //MARK: - Задание 5
    func printFibonacciNumber() {
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
    func bubbleSort(_ arrayInt: [Int]) {
        var initialArray = arrayInt
        for _ in 0...initialArray.count {
            for value in 1...initialArray.count - 1 {
                if initialArray[value - 1] > initialArray[value] {
                    let largerValue = initialArray[value - 1]
                    initialArray[value - 1] = initialArray[value]
                    initialArray[value] = largerValue
                }
            }
        }
        print("Отсортированный массив: \(initialArray)")
    }
    
    //MARK: - Задание 7
    func replaceLastCharacterString(trashString: String) {
        guard let lastCharacter = trashString.last?.description, let lastNumber = Int(lastCharacter) else {
            return print("Can't serialize last character in number")
        }
        let numberPlusOne: Int = lastNumber + 1
        let replaceString: String = String(trashString.dropLast()) + "\(numberPlusOne)"
        print(replaceString)
    }
}

