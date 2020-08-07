//
//  FirebaseCollectionReference.swift
//  Market
//
//  Created by Aleksandar Savić on 09.05.20.
//  Copyright © 2020 Aleksandar Savić. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String{
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(_collectionReference.rawValue)
}

