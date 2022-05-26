//
//  FirebaseReference.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/26/22.
//

import Firebase

enum FCollectionReference: String {
    case Game
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
