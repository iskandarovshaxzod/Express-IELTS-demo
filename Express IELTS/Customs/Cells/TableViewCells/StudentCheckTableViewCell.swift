//
//  StudentCheckTableViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 21.12.2022.
//

import UIKit
import SnapKit

protocol PaidDelegate {
    func pay(for student: Student)
}

class StudentCheckTableViewCell: UITableViewCell {
    
    var delegate: PaidDelegate?
    
    let scrollView = UIScrollView()
    let subView    = UIView()
    let nameView   = UIView()
    let payView    = UIView()
    let statusView = UIView()
    let nameLabel  = UILabel()
    let payLabel   = UILabel()
    
    var student: StudentWithAttendance?
    var size = 12
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 70)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing      = 20
        let collectionView = UICollectionView(frame: CGRect(),
                                              collectionViewLayout: layout)
        return collectionView
    }()

    func initViews() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.backgroundColor = "cl_main_back".color
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(90)
        }
        subView.backgroundColor = .greenyBlue
        
        subView.addSubview(nameView)
        nameView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(200)
        }
        nameView.backgroundColor = .blue
        nameView.layer.cornerRadius = 5
        
        nameView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.text = student?.student.studentName.capitalized
        
        subView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(nameView.snp.right).offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(size * 60 + (size-1)*20)
        }
        collectionView.register(CheckCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .gray
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        
        subView.addSubview(payView)
        payView.snp.makeConstraints { make in
            make.left.equalTo(collectionView.snp.right).offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.right.equalToSuperview().offset(-10)
        }
        payView.backgroundColor = .yellow
        payView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(payViewTapped)))
        
        payView.addSubview(statusView)
        statusView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(student?.paymentStatus ?? 0.0)
        }
        statusView.backgroundColor = .green
        
        payView.addSubview(payLabel)
        payLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        payLabel.numberOfLines = 0
        payLabel.textAlignment = .center
        payLabel.textColor     = .white
        payLabel.text = (student?.paymentStatus ?? 0.0 < 1.0 ? "Pay" : "Paid")
    }

    @objc func payViewTapped() {
        if let student = student?.student {
            delegate?.pay(for: student)
        }
    }
}

extension StudentCheckTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                                                                        as! CheckCollectionViewCell
//        cell.isChecked = 
        cell.initViews()
        
        return cell
    }
}
