//
//  Global.swift
//  Cashr
//
//  Created by Ahmed on 12/04/2021.
//

import Foundation
class Global
{
    class var shared : Global {
        struct Static
        {
            static let instance : Global = Global()
        }
        return Static.instance
    }
    var role:String!
//    var currentUserLogin: UserData!
    var currentUserFCM: String = ""
}
