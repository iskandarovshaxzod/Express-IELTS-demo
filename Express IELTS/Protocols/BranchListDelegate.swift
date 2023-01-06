//
//  BranchesListProtocol.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 02.01.2023.
//

import Foundation

protocol BranchListDelegate {
    func onSuccessGetAllBranches(branches: [String])
    func onErrorGetAllBranches(error: String?)
}
