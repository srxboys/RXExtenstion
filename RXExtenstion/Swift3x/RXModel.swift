//
//  RXModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
/*
 * 数据模型 基类 
 *
 * 详见：https://github.com/srxboys/RXSwiftExtention
 
 *
 * 有个小小的改动，以前所有dict都是公共区域写的，为了让OC 用类方法，放到了 RXModel的大括号里面
 * 再看RXPrintInterface.swift里面，我就没有动，就变成了不是类方法也不是实例方法的，就不提供给OC调用
 */

import UIKit

class RXModel: NSObject {
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //不存在的
        NSLog("error 不存在的key" + key)
    }



    /*
     * 所有返回的类型，一定要和 定义的类型匹配否则必崩溃 *****
     */

    // MARK: --- String-----
    /// 根据字典key获取内容为 字符串类型
    public class func dictForKeyString(_ dict:[String:Any], key : String) ->String {

        let valueStatus = dictForKey(dict, key: key)
        
        if(!valueStatus.isValue) {
            return ""
        }
        let value = valueStatus.object
        if value is String {
            
        var count : Int = 0
#if OS_OBJECT_SWIFT3
    count = (value as! String).characters.count
#else
    count = (value as! String).count
#endif
            
            if( count > 0 && (value as! String) != "<null>") {
                return value as! String
            }
            else {
                return ""
            }
        }
        else if(value is [String:Any]) { return "" }
        else if(value is [Any]) { return "" }
        else {
        
            let valueString = "\(value)"
            var valueStringCount = 0
            
    #if OS_OBJECT_SWIFT3
        valueStringCount = valueString.characters.count;
    #else
        valueStringCount = valueString.count;
    #endif
           if valueStringCount <= 0 { return "" }
        }
        return "\(value)"
    }

    /// 根据字典key获取内容为 数值类型
    public class func dictForKeyInt(_ dict:[String:Any], key : String) ->Int {
        let value = dictForKeyString(dict, key: key)
        if(!value.isEmpty) {
            return Int(value)!
        }
        return 0
    }

    // MARK: --- Bool -----
    /// 根据字典key获取内容为 布尔类型
    public class func dictForKeyBool(_ dict:[String:Any], key : String) ->Bool {
        let value = dictForKeyInt(dict, key: key)
        if(value > 0) { return true }
        return false
    }

    // MARK: --- CGFloat -----
    /// 根据字典key获取内容为 CGFloat
    public class func dictForKeyCGFloat(_ dict:[String:Any], key : String) ->CGFloat {
        let value = dictForKeyString(dict, key: key)
        if(!value.isEmpty) {
        return CGFloat(Float(value)!)
        }
        return 0
    }

    // MARK: --- Float -----
    /// 根据字典key获取内容为 Float
    public class func dictForKeyFloat(_ dict:[String:Any], key : String) ->Float {
        let value = dictForKeyString(dict, key: key)
        if(!value.isEmpty) {
            return Float(value)!
        }
        return 0
    }


    // MARK: --- Dictionary -----
    /// 根据字典key获取内容为字典  返回值  [值，是否有值]
    public class func dictForKeyDict(_ dict:[String:Any], key : String) ->(object:[String:Any], isValue:Bool) {
        let valueStatus = dictForKey(dict, key: key)
        if(!valueStatus.isValue) {
            return ([String:Any](), false)
        }
        let value = valueStatus.object
        if value is [String:Any] {
            return (value as! [String:Any], true)
        }
        return ([String:Any](), false)
    }

    // MARK: --- Any -----
    /// 根据字典key获取内容为任意类型  返回值  [值，是否有值]
   public class func  dictForKey(_ dict:[String:Any], key:String) -> (object:Any, isValue:Bool) {
        guard dict.index(forKey: key) != nil else {
            return ("", false)
        }
        
        let anyValue = dict[key]
        
        guard anyValue != nil else {
            return ("", false)
        }
        
        if anyValue is Int {
            return (String(anyValue as! Int), true)
        }
        
        if anyValue is String {
            return (anyValue as! String, true)
        }
        
        return (anyValue!, true)
    }

}
