//
//  ReceiptModel.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.01.2023.
//

import FirebaseFirestore

struct ReceiptModel {
    let name: String
    let paymentTime: [String: Timestamp]
}
