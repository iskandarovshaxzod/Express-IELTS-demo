//
//  GroupListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation

protocol GroupListDelegate {
    func onSuccessGetAllGroups(groups: [Group])
    func onSuccesUpdateGroup()
    func onSuccesDeleteGroup()
    func onError(error: String?)
}
