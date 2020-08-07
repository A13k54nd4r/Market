//
//  Basket.swift
//  Market
//
//  Created by Aleksandar Savić on 13.06.20.
//  Copyright © 2020 Aleksandar Savić. All rights reserved.
//

import Foundation

class Basket {
    var id: String!
    var ownerId: String!
    var itemIds: [String]!
    init() {
    }
    init(_dictionary: NSDictionary) {
        id = _dictionary[kOBJECTID] as? String
        ownerId = _dictionary[kOWNERID] as? String
        itemIds = _dictionary[kITEMIDS] as? [String]
    }
}

//MARK: - Download items
func downloadBasketFromFirestore(_ ownerId: String, completion: @escaping (_ basket: Basket?)-> Void) {
    FirebaseReference(_collectionReference: .Basket).whereField(kOWNERID, isEqualTo: ownerId).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(nil)
            return
        }
        if !snapshot.isEmpty && snapshot.documents.count > 0 {
            let basket = Basket(_dictionary: snapshot.documents.first!.data() as NSDictionary)
            completion(basket)
        } else {
            completion(nil)
        }
    }
}

//MARK: Save to Firestore
func saveBasketToFirestore(_ basket: Basket) {
    FirebaseReference(_collectionReference: .Basket).document(basket.id).setData(basketDictionaryFrom(basket) as! [String: Any])
}

//MARK: Helper Functions
func basketDictionaryFrom(_ basket: Basket) -> NSDictionary {
    return NSDictionary(objects: [basket.id, basket.ownerId, basket.itemIds], forKeys: [kOBJECTID as NSCopying, kOWNERID as NSCopying, kITEMIDS as NSCopying])
}

//MARK: Update Basket
func updateBasketInFirestore(_ basket: Basket, withValues: [String: Any], completion: @escaping (_ error: Error?) -> Void) {
    FirebaseReference(_collectionReference: .Basket).document(basket.id).updateData(withValues) { (error) in
        completion(error)
    }
}











