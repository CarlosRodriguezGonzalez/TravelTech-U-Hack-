//
//  DataHolder.swift
//  U-Hack!
//
//  Created by Charly Maxter on 02/10/2018.
//  Copyright © 2018 U-Hack. All rights reserved.
//

import UIKit
import Firebase

class DataHolder: NSObject {
    
    static let sharedInstance:DataHolder=DataHolder()
   
    var firDataBaseRef:DatabaseReference!
    
    func initFirebase(){
        FirebaseApp.configure()
        firDataBaseRef=Database.database().reference()        
    }
    
}
