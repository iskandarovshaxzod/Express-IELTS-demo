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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect(),
                                              collectionViewLayout: layout)
        return collectionView
    }()

    func initViews() {
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.backgroundColor = .red
        
        
        
        
//        subView.addSubview(collectionView)
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = .gray
//        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = false
    }

}

extension StudentCheckTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension StudentCheckTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: itemsArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 30)
//    }
}
