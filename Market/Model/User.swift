//
//  User.swift
//  Market
//
//  Created by Aleksandar Savić on 16.06.20.
//  Copyright © 2020 Aleksandar Savić. All rights reserved.
//

import Foundation
import FirebaseAuth

class User {
    
    let objectId: String
    var email: String
    var firstName: String
    var lastName: String
    var fullName: String
    var purchasedItemIds: [String]
    var fullAddress: String?
    var onBoard: Bool
    
    //MARK: Initializers
    init(_objectId: String, _email: String, _firstName: String, _lastName: String) {
        objectId = _objectId
        email = _email
        firstName = _firstName
        lastName = _lastName
        fullName = _firstName + " " + _lastName
        fullAddress = ""
        onBoard = false
        purchasedItemIds = []
    }
    init(_dictionary: NSDictionary) {
        objectId = _dictionary[kOBJECTID] as! String
        if let mail = _dictionary[kEMAIL] {
            email = mail as! String
        } else {
            email = ""
        }
        if let fname = _dictionary[kFIRSTNAME] {
            firstName = fname as! String
        } else {
            firstName = ""
        }
        if let lname = _dictionary[kLASTNAME] {
            lastName = lname as! String
        } else {
            lastName = ""
        }
        
        fullName = firstName + " " + lastName
        
        if let fAddress = _dictionary[kFULLADDRESS] {
            fullAddress = fAddress as! String
        } else {
            fullAddress = ""
        }
        if let onB = _dictionary[kONBOARD] {
            onBoard = onB as! Bool
        } else {
            onBoard = false
        }
        if let purchasedIds = _dictionary[kPURCHASEDITEMIDS] {
            purchasedItemIds = purchasedIds as! [String]
        } else {
            purchasedItemIds = []
        }
    }
    
    //MARK: Return Current User
    class func currentId() -> String {
        return Auth.auth().currentUser!.uid
    }
    class func currentUser() -> User? {
        if Auth.auth().currentUser != nil {
            if let dictionary = UserDefaults.standard.object(forKey: kCURRENTUSER) {
                return User.init(_dictionary: dictionary as! NSDictionary)
            }
        }
        return nil
    }
    
}


