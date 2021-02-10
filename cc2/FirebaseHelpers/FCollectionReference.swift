//
//  FCollectionReference.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/11.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Recent
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
