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

struct FirebaseManager{
    
    static let shared = FirebaseManager()
    
    var db   = Firestore.firestore()
    var auth = Auth.auth()
    
    var expressRef: CollectionReference{
        return db.collection("express_test")
    }
    
    var generalRef: CollectionReference{
        return db.collection("test")
    }
    
    var usersRef: CollectionReference{
        return db.collection("users")
    }
    
    var time: Date?{
        return updateTime()
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
//        auth.signIn(withEmail: email, password: password) { res, err in
//            if err != nil {
//                error(err)
//            } else {
//                success(res)
//            }
//        }
        var users = [UserModel]()
        
        usersRef.getDocuments { snapShot, err in
            if err != nil {
                error(err)
            } else {
                snapShot?.documents.forEach{ doc in
                    users.append(UserModel(name:  doc.documentID,
                                           email: doc.data()["email"] as? String ?? "",
                                           password: doc.data()["password"] as? String ?? ""))
                }
                
                if let user = users.first(where: {$0.email == email && $0.password == password}) {
                    success()
                } else {
                    error(UserLoginError.notFound)
                }
            }
        }
        
        
    }
    
    func changePassword(){
        
    }
}

// MARK: Extension for Adding methods
extension FirebaseManager {
    func addNewBranch(email: String, password: String, handler: @escaping (Error?) -> Void) {
        auth.createUser(withEmail: email + "@gmail.com", password: password) { res, err in
            if err != nil{
                handler(err)
            } else {
                expressRef.document(email).setData(["isShow" : true]){ err in
                    handler(err)
                }
            }
        }
    }
    
    func addNewTeacher(teacherName: String, handlder: @escaping (Error?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)")
        .setData(["isShow" : true]) { err in
            handlder(err)
        }
    }
    
    func addNewTeacherConfig(teacherName: String, teacherConfig: String, handlder: @escaping (Error?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)/configs/\(teacherConfig)")
            .setData(["isShow" : true]) { err in
                handlder(err)
            }
    }
    
    func addNewGroup(teacherName: String, teacherConfig: String, groupName: String, handlder: @escaping (Error?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)/configs/\(teacherConfig)/groups/\(groupName)")
            .setData(["isShow" : true]) { err in
                handlder(err)
            }
    }
    
    func addNewStudent(teacherName: String, teacherConfig: String, groupName: String, studentName: String,
                       handlder: @escaping (Error?) -> Void) {
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)/configs/\(teacherConfig)/groups/\(groupName)/students/\(studentName)")
            .setData(["isShow" : true]) { err in
                if err != nil {
                    handlder(err)
                } else {
                    expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)/configs/\(teacherConfig)/groups/\(groupName)/students/\(studentName)/months/month 1").setData([
                            "1" : 0,
                            "2" : 0,
                            "3" : 0,
                            "4" : 0,
                            "5" : 0,
                            "6" : 0,
                            "7" : 0,
                            "8" : 0,
                            "9" : 0,
                            "10" : 0,
                            "11" : 0,
                            "12" : 0,
                        ]) { err in
                            handlder(err)
                            }
                }
            }
    }
}

// MARK: Extension for Getting methods
extension FirebaseManager {
    func getAllBranches(success: @escaping ([String]) -> Void,
                        error:   @escaping (String?) -> Void) {
        var branches = [String]()
        expressRef.whereField("isShow", isEqualTo: true).getDocuments { snapShot, err in
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
    
    func getAllTeacherConfigs(teacherName: String,
                              success: @escaping ([String]) -> Void,
                              error:   @escaping (String?) -> Void) {
        var configs = [String]()
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)").collection("configs")
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
    
    func getAllGroups(teacherName: String, configName: String,
                      success: @escaping ([String]) -> Void,
                      error:   @escaping (String?) -> Void) {
        var groups = [String]()
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)/configs/\(configName)").collection("groups").whereField("isShow", isEqualTo: true).getDocuments { snapShot, err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                snapShot?.documents.forEach { doc in
                    groups.append(doc.documentID)
                }
                success(groups)
            }
        }
    }
    
    func getAllStudentsOfGroup(teacherName: String, configName: String, groupName: String,
                      success: @escaping ([StudentCheckModel]) -> Void,
                      error:   @escaping (String?) -> Void) {

        var months   = [EachMonthModel]()
        var students = [StudentCheckModel]()
        
        expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)/configs/\(configName)/groups/\(groupName)").collection("students").whereField("isShow", isEqualTo: true).getDocuments { snapShot, err in
            if err != nil {
                error(err?.localizedDescription)
            } else {
                snapShot?.documents.forEach { student in
                    months.removeAll()
                    expressRef.document("\(Database.shared.currentBranch)/teachers/\(teacherName)/configs/\(configName)/groups/\(groupName)/students/\(student.documentID)").collection("months").getDocuments { snapShot, err in
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
                        }
                    }
                }
                print("entering")
                success(students)
            }
        }
    }
}
