//
//  Category.swift
//  Market
//
//  Created by Aleksandar Savić on 09.05.20.
//  Copyright © 2020 Aleksandar Savić. All rights reserved.
//

import Foundation
import UIKit

class Category {
    
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    init(_name: String, _imageName: String) {
        
        id = ""
        name = _name
        imageName = _imageName
        image = UIImage(named: _imageName)
    }

    init(_dictionary: NSDictionary) {
        
        id = _dictionary[kOBJECTID] as! String
        name = _dictionary[kNAME] as! String
        image = UIImage(named: _dictionary[kIMAGENAME] as?  String ?? "")
    }
}

//MARK: Download category from Firebase

func downloadCategoriesFromFirebase(completion: @escaping (_ categoryArray: [Category]) -> Void) {
    
    var categoryArray: [Category] = []
    //hat so nicht fu_collectionReference: nktioniert:
    //FirebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
    FirebaseReference(_collectionReference: .Category).getDocuments { (snapshot, Error) in
        guard let snapshot = snapshot else {
            completion(categoryArray)
            return
        }
        
        if !snapshot.isEmpty {
            for categoryDict in snapshot.documents {
                //nur um die anzuzeigen ob sie created wurden print("created new category with")
                categoryArray.append(Category(_dictionary: categoryDict.data() as NSDictionary))
            }
        }
        
        completion(categoryArray)
    }
    
}

//MARK: Save category function

func saveCategoryToFirebase(_ category: Category) {
    
    let id = UUID().uuidString
    category.id = id
    
    FirebaseReference(_collectionReference: .Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
    //hat so nicht fu_collectionReference: nktioniert:
    //FirebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
    
}


//MARK: Helpers

func categoryDictionaryFrom(_ category: Category) -> NSDictionary {
 
    return NSDictionary(objects: [category.id, category.name, category.imageName], forKeys: [kOBJECTID as NSCopying, kNAME as NSCopying, kIMAGENAME as NSCopying])
}


/*use only one time

func createCategorySet() {
    
    let tower = Category(_name: "Tower", _imageName: "tower")
    let cpu = Category(_name: "CPU", _imageName: "cpu")
    let gpu = Category(_name: "GPU", _imageName: "gpu")
    let netzteil = Category(_name: "Netzteil", _imageName: "netzteil")
    let mainboard = Category(_name: "Mainboard", _imageName: "mainboard")
    let ram = Category(_name: "Ram", _imageName: "ram")
    let ssd = Category(_name: "SSD", _imageName: "ssd")
    let festplatte = Category(_name: "Festplatte", _imageName: "festplatte")
    let laufwerk = Category(_name: "Laufwerk", _imageName: "laufwerk")
    let cpuKuehler = Category(_name: "CPU Kühler", _imageName: "cpuKuehler")
    let luefter = Category(_name: "Lüfter", _imageName: "luefter")
    let kabel = Category(_name: "Kabel", _imageName: "kabel")
    let tastatur = Category(_name: "Tastatur", _imageName: "tastatur")
    let maus = Category(_name: "Maus", _imageName: "maus")
    let lautsprecher = Category(_name: "Lautsprecher", _imageName: "lautsprecher")
 
    let arrayOfCategories = [tower,cpu,gpu,netzteil,mainboard,ram,ssd,festplatte,laufwerk,cpuKuehler,luefter,kabel,tastatur,maus,lautsprecher]
    
    for category in arrayOfCategories {
        saveCategoryToFirebase(category)
    }
}*/

