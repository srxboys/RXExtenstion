//: Playground - noun: a place where people can play


// swift3.x 请看 https://github.com/srxboys/RXSwiftExtention


import UIKit


//函数中参数默认值
func makeCoffee(coffeeName:String = "猫屎") -> String {
    return "已经只做了 \(coffeeName) 咖啡"
}

makeCoffee()
makeCoffee(coffeeName: "拿铁")
//---------------------------------

//可变参数（参数可以多个也可以让为几个）
func sum(num : Int ...) -> Int {
    var result = 0
    for n in num {
        result += n
    }
    return result;
}

sum(num: 1,2,3)
sum(num: 1,2,3,4,0)


//---------------------------------
class Person {
    
    var get:Int = 0
    private var name : String = "srxboys";
}

let p = Person();
p.get = 3;
print(p.get)

//print(p.name); //调用不了

//---------------------------------

class MyClass: NSObject {
    var age = 0
     func setValue(value: AnyObject?, forUndefinedKey key: String) {
        //避免出现bug
        print("no match key=\"\(key)\"")
    }
    
}

let myClass = MyClass()
//myClass.setValuesForKeys(["age": 19, "name":"srxboys"])
print(myClass.age)
//---------------------------------
