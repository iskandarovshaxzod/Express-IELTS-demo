//
//  HeaderMonthView.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 12.12.2022.
//

import UIKit

class HeaderMonthView: UIView {
    
    let subView = UIView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing      = 0
        let collectionView = UICollectionView(frame: CGRect(),
                                              collectionViewLayout: layout)
        return collectionView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(txt: String) {
        super.init(frame: CGRect())
        
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }
        subView.backgroundColor = .gray
        
        subView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .gray
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}

extension HeaderMonthView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MonthCollectionViewCell
        cell.text = "November\(indexPath.row+1) 2022"
        cell.initViews()
        return cell
    }
}
