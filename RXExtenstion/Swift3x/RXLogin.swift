//
//  RXLogin.swift
//  RXSwift98098fLottery
//
//  Created by srx on 2017/5/30.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

//登录加密
//
// 详见：https://github.com/srxboys/RXSwiftExtention
//

import UIKit


let USER_NAME = "rx_login_user"
let USER_PASS = "rx_login_pass"

public class RXLogin : NSObject {
    class func Login(_ userName: String, _ password:String)  {
        var count = 0
#if OS_OBJECT_SWIFT3
    count = userName.characters.count
#else
    count = userName.count
#endif
        guard  count > 0 else {
            return
        }
        guard count > 0 else {
            return
        }
        baseEn64(USER_NAME, userName)
        baseEn64(USER_PASS, password)
        
    }
    
    class func getLogin() -> (userName: String, password:String) {
        let name = baseUn64(USER_NAME)
        let pass = baseUn64(USER_PASS)
        return (name, pass)
    }
    
    class func getLoginToOC() -> [String:String] {
        let user = getLogin()
        let userName = user.userName;
        let userPs = user.password;
        var dict = [String:String]()
        dict["name"] = userName
        dict["password"] = userPs
        return dict
    }
    
    class func removeLogin() {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: USER_NAME)
        userDefault.removeObject(forKey: USER_PASS)
        userDefault.synchronize()
    }
    
    // MARK: 加密
    fileprivate class func baseEn64(_ key:String ,_ value: String) {
        let utf8Data = value.data(using: String.Encoding.utf8)
        let base64EncodeString : String? = utf8Data?.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        if let base64EncodeString = base64EncodeString {
            storageUser(key: key, value: base64EncodeString)
        }
    }
    
    // MARK: 解密
    fileprivate class func baseUn64(_ key : String) -> String {
        let valueString  = getUser(key: key)
        let valueData = valueString.data(using: String.Encoding.utf8)
        guard valueData != nil else {
            return ""
        }
        let decodeData = Data(base64Encoded: valueData!, options: Data.Base64DecodingOptions.init(rawValue: 0))
        if let decodeData = decodeData {
            let decodeString = String(data: decodeData, encoding: String.Encoding.utf8)
            if decodeString != nil {
                return decodeString!
            }
        }
        return ""
    }
    
// MARK: 加密和解密操作以下方法------------
    // MARK: 存到沙盒
    fileprivate class func storageUser(key:String, value:String) {
        let userDefault = UserDefaults.standard
        userDefault.set(value, forKey: key)
        userDefault.synchronize()
    }
    
    // MARK: 从沙盒里获取
    fileprivate class func getUser(key : String) -> String {
        let userDefault = UserDefaults.standard
        let value = userDefault.object(forKey: key)
        if(value is String) {
            return value as! String
        }
        return ""
    }
}
