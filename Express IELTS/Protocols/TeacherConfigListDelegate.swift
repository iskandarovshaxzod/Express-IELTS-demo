//
//  TeacherConfigListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation

protocol TeacherConfigListDelegate {
    func onSuccessGetAllTeacherConfigs(configs: [Config])
    func onSuccessUpdateConfig()
    func onSuccessDeleteConfig()
    func onError(error: String?)
}
