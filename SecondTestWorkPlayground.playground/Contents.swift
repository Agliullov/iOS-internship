import UIKit

//MARK: - Задание 2 Замыкание
var myClosure: ()-> Void = {print("I love Swift")}
myClosure()

func repeatTask(times: Int, task: ()-> Void) {
  var count = 0
  while count < times {
    task()
    count = count + 1
  }
}

repeatTask(times: 10) {
  myClosure()
}
print("\n")
//---

//MARK: - Задание 3 Location
enum Direction {
  case up
  case down
  case left
  case right
}

var location: (y: Int, x: Int) = (y: 0, x: 0)

let steps: [Direction] = [.up, .up, .left, .down, .left, .down, .down, .right, .right, .down, .right]

for direction in steps {
  switch direction {
  case .up:
    location.y += 1
  case .down:
    location.y -= 1
  case .left:
    location.x -= 1
  case .right:
    location.x += 1
  }
  print(location)
}
print("\n")
//---

//MARK: - Задание 4
class Rectangle {
  var width: Int
  var height: Int
  
  init(width: Int, height: Int) {
    self.width = width
    self.height = height
  }
  
  func rectanglePerimeter() {
    let result = (width + height) * 2
    print("Периметр прямоугольника равен \(result) \n")
  }
}

var test: Rectangle = Rectangle(width: 5, height: 5)
test.rectanglePerimeter()
//---

//Задание 5---
extension Rectangle {
  var acreage: Int {
    return width * height
  }
}

print("Площадь прямоугольника равна \(test.acreage)")
//---
