//
//  FirebaseManager.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.11.2022.
//

import UIKit
import FirebaseCoreInternal
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

class FirebaseManager{
    
    static let shared = FirebaseManager()
    
    var db   = Firestore.firestore()
    var auth = Auth.auth()
    
    var expressRef: CollectionReference{
        return db.collection("express_test")
    }
    
    var generalRef: CollectionReference{
        return db.collection("test")
    }
    
    var studentData: [String : Int] {
        var data = [String : Int]()
        for i in 1...(Database.shared.currentGroupType.rawValue) {
            data["\(i)"] = 0
        }
        return data
    }
    
    var time: Date?{
        return updateTime()
    }
    
    var users = [UserModel]()
    var branches: [String]{
        var branches = [String]()
        for user in users {
            if user.isBranch {
                branches.append(user.name)
            }
        }
        return branches
    }
    
    func updateTime() -> Date?{
        print("time changing")
        let docRef = db.collection("test").document("s1IPKNH51jJwAuMqatun")
        docRef.updateData([
            "time": FieldValue.serverTimestamp()
        ]) { err in
            if let err {
                print("time Error updating document: \(err)")
            } else {
                print("time Document successfully updated")
                docRef.getDocument { snapshot, error in
                    if let document = snapshot, document.exists {
                        if let x = document.get("time") as? Timestamp{
                            var time = x.dateValue()
                            print("time \(time)")
                            time.addTimeInterval(18_000)
                            print("time \(time)")
                            
                        }
                    } else {
                        print("time Document does not exist")
                    }
                }
            }
        }
        print("time changed")
        
//        docRef.getDocument { snapshot, error in
//            if let document = snapshot, document.exists {
//                if let x = document.get("time") as? Timestamp{
//                    var time = x.dateValue()
//                    print("time \(time)")
//                    time.addTimeInterval(18_000)
//                    print("time \(time)")
//                }
//            } else {
//                print("time Document does not exist")
//            }
//        }
        return nil
    }
    
}

// MARK: Extension for `USER` methods
extension FirebaseManager {
    func validateUser(email: String, password: String,
                      success: @escaping () -> Void,
                      error: @escaping (Error?) -> Void) {
        
        expressRef.whereField("isShow", isEqualTo: true).getDocuments { [weak self] snapShot, err in
            if err != nil {
                error(err)
            } else {
                snapShot?.documents.forEach{ doc in
                    self?.users.append(UserModel(name: doc.documentID,
                                           email:    doc.data()["email"] as? String ?? "",
                                           password: doc.data()["password"] as? String ?? "",
                                           isBranch: doc.data()["isBranch"] as? Bool ?? true))
                }
                
                if let _ = self?.users.first(where: {$0.email == email && $0.password == password}) {
                    success()
                } else {
                    error(Errors.userNotFound)
                }
            }
        }
    }
    
    func changePassword(for user: String, password: String,
                        success: @escaping () -> Void,
                        error: @escaping (Error?) -> Void){
        expressRef.document(user).updateData(["password" : password]) { err in
            if err != nil {
                error(err)
            } else {
                success()
            }
        }
    }
}

// MARK: Extension for `Adding` methods
extension FirebaseManager {
    func addNewBranch(email: String, password: String,
                      success: @escaping () -> Void,
                      error: @escaping (Error?) -> Void) {
        expressRef.document(email).setData(["email" : email + "@gmail.com",
                                            "isBranch" : true,
                                            "isShow" : true,
                                            "password" : password]) { err in
            if err != nil {
                error(err)
            } else {
                success()
            }
        }
    }
    
    func addNewTeacher(teacherName: String,
                       success: @escaping () -> Void,
                       error: @escaping (Error?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)")
        .setData(["isShow" : true]) { err in
            if err != nil {
                error(err)
            } else {
                success()
            }
        }
    }
    
    func addNewTeacherConfig(configName: String,
                             success: @escaping () -> Void,
                             error: @escaping (Error?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(configName)")
            .setData(["isShow" : true]) { err in
                if err != nil {
                    error(err)
                } else {
                    success()
                }
            }
    }
    
    func addNewGroup(groupName: String, groupType: GroupType,
                     success: @escaping () -> Void,
                     error: @escaping (Error?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(Database.shared.currentConfig)/groups/\(groupName)")
            .setData(["isShow"    : true,
                      "groupType" : groupType.rawValue]) { err in
                if err != nil {
                    error(err)
                } else {
                    success()
                }
            }
    }
    
    func addNewStudent(studentName: String,
                       success: @escaping () -> Void,
                       error: @escaping (Error?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(Database.shared.currentConfig)/groups/\(Database.shared.currentGroup)/students/\(studentName)")
            .setData(["isShow" : true]) { [weak self] err in
                if err != nil {
                    error(err)
                } else {
                    self?.expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(Database.shared.currentConfig)/groups/\(Database.shared.currentGroup)/students/\(studentName)/months/month 1")
                        .setData(self?.studentData ?? ["" : 0]) { err in
                            if err != nil {
                                error(err)
                            } else {
                                success()
                            }
                    }
                }
            }
    }
}

// MARK: Extension for `Getting` methods
extension FirebaseManager {
    func getAllBranches(success: @escaping ([String]) -> Void,
                        error:   @escaping (String?) -> Void) {
        var branches = [String]()
        expressRef.whereField("isShow", isEqualTo: true).whereField("isBranch", isEqualTo: true).getDocuments { snapShot, err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                snapShot?.documents.forEach { doc in
                    branches.append(doc.documentID)
                }
                success(branches)
            }
        }
    }
    
    func getAllTeachers(success: @escaping ([String]) -> Void,
                        error:   @escaping (String?) -> Void) {
        var teachers = [String]()
        expressRef.document(Database.shared.currentBranch).collection("teachers")
            .whereField("isShow", isEqualTo: true).getDocuments(source: .default) { snapShot, err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                snapShot?.documents.forEach { doc in
                    teachers.append(doc.documentID)
                }
                success(teachers)
            }
        }
    }
    
    func getAllTeacherConfigs(success: @escaping ([String]) -> Void,
                              error:   @escaping (String?) -> Void) {
        var configs = [String]()
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)").collection("configs")
        .whereField("isShow", isEqualTo: true).getDocuments { snapShot, err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                snapShot?.documents.forEach { doc in
                    configs.append(doc.documentID)
                }
                success(configs)
            }
        }
    }
    
    func getAllGroups(success: @escaping ([GroupModel]) -> Void,
                      error:   @escaping (String?) -> Void) {
        var groups = [GroupModel]()
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(Database.shared.currentConfig)").collection("groups").whereField("isShow", isEqualTo: true).getDocuments { snapShot, err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                snapShot?.documents.forEach { doc in
                    groups.append(GroupModel(name: doc.documentID,
                    groupType: GroupType(rawValue: doc.data()["groupType"] as? Int ?? 12) ?? .twelve))
                }
                success(groups)
            }
        }
    }
    
    func getAllStudentsOfGroup(success: @escaping ([StudentCheckModel]) -> Void,
                               error:   @escaping (String?) -> Void) {

        var months   = [EachMonthModel]()
        var students = [StudentCheckModel]()
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(Database.shared.currentConfig)/groups/\(Database.shared.currentGroup)").collection("students").whereField("isShow", isEqualTo: true)
            .getDocuments { [weak self] snapShot, err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                snapShot?.documents.forEach { student in
                    months.removeAll()
                    self?.expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(Database.shared.currentConfig)/groups/\(Database.shared.currentGroup)/students/\(student.documentID)").collection("months").getDocuments { snapShot, err in
                        if err != nil {
                            error(err?.localizedDescription)
                            return
                        } else {
                            snapShot?.documents.forEach { doc in
                                months.append(EachMonthModel(monthName: doc.documentID,
                                                             days: doc.data() as? [String : Int]))
                                print("adding")
                            }
                            students.append(StudentCheckModel(studentName: student.documentID,
                                                              months: months))
                            print(students.count)
                            success(students)
                        }
                    }
                }
//                print("entering")
                success(students)
            }
        }
    }
}

// MARK: Extension for `Payment` methods
extension FirebaseManager {
    func getAllReceipts(monthName: String,
                      success: @escaping ([ReceiptModel]) -> Void,
                      error:   @escaping (String?) -> Void) {
        var receipts = [ReceiptModel]()
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/monthly_payments/\(monthName)").collection("receipts").getDocuments { snapShot, err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                snapShot?.documents.forEach { doc in
                    receipts.append(ReceiptModel(name: doc.documentID,
                                    paymentTime: doc.data()["payment_time"] as? [String : Timestamp] ??
                                                 ["" : Timestamp()]))
                }
                success(receipts)
            }
        }
    }
    
    func addReceipt(studentName: String, sum: String,
                    success: @escaping () -> Void,
                    error:   @escaping (String?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/monthly_payments/\("November")/receipts/\(studentName)")
            .setData([sum : FieldValue.serverTimestamp()], merge: true) { err in
                if err != nil {
                    error(err?.localizedDescription)
                } else {
                    success()
                }
            }
    }
}

// MARK: Extension for `DELETE` methods
extension FirebaseManager {
    func deleteBranch(branchName: String,
                success: @escaping () -> Void,
                error:   @escaping (String?) -> Void) {
        expressRef.document(branchName).updateData(["isShow" : false]) { err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                success()
            }
        }
    }
    
    func deleteTeacher(teacherName: String,
                       success: @escaping () -> Void,
                       error:   @escaping (String?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)")
            .updateData(["isShow" : false]) { err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                success()
            }
        }
    }
    
    func deleteTeacherConfig(configName: String,
                             success: @escaping () -> Void,
                             error:   @escaping (String?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(configName)")
            .updateData(["isShow" : false]) { err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                success()
            }
        }
    }
    
    func deleteGroup(groupName: String,
                     success: @escaping () -> Void,
                     error:   @escaping (String?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(Database.shared.currentConfig)/groups/\(groupName)")
            .updateData(["isShow" : false]) { err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                success()
            }
        }
    }
    
    func deleteStudent(studentName: String,
                     success: @escaping () -> Void,
                     error:   @escaping (String?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(Database.shared.currentTeacher)/configs/\(Database.shared.currentConfig)/groups/\(Database.shared.currentGroup)/students/\(studentName)")
            .updateData(["isShow" : false]) { err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                success()
            }
        }
    }
    
}
