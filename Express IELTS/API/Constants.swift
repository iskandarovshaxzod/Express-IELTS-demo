//
//  Constants.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 12.02.2023.
//

import Foundation

struct Constants {
    static let BASE_URL = "/"
    
    //USER
    static let USER_AUTH        = "user/auth"
    static let USER_LIST        = "user/list"
    static let USER_CHANGE_PASS = "user/change/password/"
    static let USER_CHANGE_NAME = "user/change/name/"
    
    //ATTENDANCE
    static let ATTENDANCE_ADD    = "attendance/add"
    static let ATTENDANCE_LIST   = "attendance/list"
    static let ATTENDANCE_UPDATE = "attendance/update"
    
    //BRANCH
    static let BRANCH_ADD         = "branch/add"
    static let BRANCH_LIST        = "branch/list"
    static let BRANCH_DELETE      = "branch/delete/"
    
    //CONFIG
    static let CONFIG_ADD    = "config/add"
    static let CONFIG_LIST   = "config/list/"
    static let CONFIG_UPDATE = "config/update/"
    static let CONFIG_DELETE = "config/delete/"
    
    //GROUP
    static let GROUP_ADD    = "group/add"
    static let GROUP_LIST   = "group/list/"
    static let GROUP_UPDATE = "group/update/"
    static let GROUP_DELETE = "group/delete/"
    
    //PAYMENT
    static let PAYMENT_ADD          = "payment/add"
    static let PAYMENT_TEACHER_LIST = "payment/teacher/list/"
    
    //STUDENT
    static let STUDENT_ADD         = "student/add"
    static let STUDENT_BRANCH_LIST = "student/branchList/"
    static let STUDENT_GROUP_LIST  = "student/groupList/"
    static let STUDENT_DELETE      = "student/delete/"
    static let STUDENT_UPDATE      = "student/update/"
    
    //TEACHER
    static let TEACHER_ADD         = "teacher/add"
    static let TEACHER_LIST        = "teacher/list/"
    static let TEACHER_UPDATE      = "teacher/update/"
    static let TEACHER_DELETE      = "teacher/delete/"
    
    //MONTHS
    static let MONTH_LIST          = "month/list"
}
