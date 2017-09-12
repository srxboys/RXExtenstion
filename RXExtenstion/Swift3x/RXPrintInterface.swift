//
//  RXPrintInterface.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/4/2.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
// 打印 任意类型 的数据(字典、数组、基本类型)
//
//详见：https://github.com/srxboys/RXSwiftExtention
//

import Foundation

/*
    打印接口字段
    ---------------------
    目前不支持多线程调用此方法
 */

public class RXPrintJSON: NSObject {
    static var space = 0 {
        didSet{
            if(space<0) { space = 0 }
        }
    }
    
    let step = 2
    
    fileprivate var printSpace : String {
        var ps = ""
        for _ in 0..<RXPrintJSON.space {
            ps.append(" ")
        }
        return ps
    }
    
    override init() {
        super.init()
    }
    
    convenience init(printObject: Any) {
        self.init()
        NSLog("\n\n\(printJSON(printObject))\n\n")
    }
    
}

extension RXPrintJSON {
public func printJSON(_ object: Any) {
    NSLog("\n\n\(printObject(object))\n\n")
}
   
fileprivate func printDict(_ dict:[String:Any]) -> String {
    var dictJson : String = "\(printSpace){"
    RXPrintJSON.space += step
    for key in dict.keys {
        let valueObject = RXModel.dictForKey(dict, key: key)
        if(valueObject.isValue) {
            dictJson.append("\n")
            dictJson.append(printSpace)
            if(valueObject.object is [String:Any]) {
                dictJson.append(printDict(valueObject.object as! [String : Any]))
            }
            else if(valueObject.object is [Any]) {
                dictJson.append(printArray(valueObject.object as! [Any]))
            }
            else {
                dictJson.append("\(printSpace)'\(key)' = \(printObject(dict[key] ?? ""))")
            }
        }
    }
    dictJson.append("\n\(printSpace)  }\n")
    RXPrintJSON.space -= step
    return dictJson
}

fileprivate func printArray(_ arr : [Any]) -> String {
    var arrJson : String  = "\(printSpace)["
    RXPrintJSON.space += step
    for value in arr {
        arrJson.append("\n")
        arrJson.append(printSpace)
        if(value is [String : Any]) {
            arrJson.append(printDict(value as! [String : Any]))
        }
        else if(value is [Any]) {
            arrJson.append(printArray(value as! [Any]))
        }
        else {
            arrJson.append(printObject(value))
        }
    }
    arrJson.append("\n\(printSpace)]\n")
    RXPrintJSON.space -= step
    return arrJson
}

fileprivate func printObject(_ object : Any) -> String {

    var objectString : String = ""
    
    if(object is String){
        objectString.append("'\(object as! String)'")
    }
    else if(object is Bool) {
        let objectBool = Bool(object as! Bool)
        if(objectBool == true) {
            objectString.append("true")
        }
        else {
            objectString.append("false")
        }
    }
    else if(object is Int) {
        objectString.append("\(Int(object as! Int))")
    }
    else if(object is [String:Any]) {
        objectString.append(printDict(object as! [String:Any]))
    }
    else if(object is [Any]) {
        objectString.append(printArray(object as! [Any]))
    }
    else if(object is Float){
        objectString.append(String(object as! Float))
    }
    else if(object is Double) {
        objectString.append(String(object as! Double))
    }
    else {
        NSLog("打印到这里有问题了\(object)")
    }

    objectString.append(",")
    return objectString
}

}


// MARK: --- 把post请求，以get形式打印 -----
public func printHttp(_ params:[String : Any]) {
#if DEBUG
    var httpString : String = "请求接口=\n    \(SERVER)?"
    for key in params.keys {
        let valueObject = dictForKey(params, key: key)
        if(valueObject.isValue) {
            httpString.append("\(key)=\(valueObject.object)&")
        }
        
    }
    httpString = (httpString as NSString).substring(to: httpString.characters.count-1)
    httpString.append("\n")
    NSLog(httpString)
#endif
}
