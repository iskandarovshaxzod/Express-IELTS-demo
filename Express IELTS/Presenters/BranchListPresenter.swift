//
//  BranchesListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 02.01.2023.
//

import UIKit

class BranchListPresenter {

    typealias PresenterDelegate = BranchListDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllBranches() {
        FirebaseManager.shared.getAllBranches(success: { [weak self] branches in
            self?.delegate?.onSuccessGetAllBranches(branches: branches)
        }, error: { [weak self] err in
            self?.delegate?.onErrorGetAllBranches(error: err)
        })
    }
}
