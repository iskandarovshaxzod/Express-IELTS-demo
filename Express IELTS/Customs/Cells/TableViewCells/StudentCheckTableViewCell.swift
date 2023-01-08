//
//  StudentCheckTableViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 21.12.2022.
//

import UIKit

class StudentCheckTableViewCell: UITableViewCell {
    
    let subView    = UIView()
    let scrollView = UIScrollView()
    
    let view1 = UIView()
    let view2 = UIView()
    
    let nameLabel = UILabel()
    var days = [String: Int]()
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
        
        subView.addSubview(view1)
        view1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(200)
        }
        view1.backgroundColor = .blue
        
        view1.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        
        
        subView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(view1.snp.right).offset(20)
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
        
        subView.addSubview(view2)
        view2.snp.makeConstraints { make in
            make.left.equalTo(collectionView.snp.right).offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.right.equalToSuperview().offset(-10)
        }
        view2.backgroundColor = .brightLilac
        view2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }

    @objc func viewTapped() {
        
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
