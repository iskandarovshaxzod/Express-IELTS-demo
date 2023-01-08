//
//  SkeletonViewsTableViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.01.2023.
//

import UIKit

class SkeletonViewsTableViewCell: UITableViewCell {
    
    let view1      = UIView()
    let view1Layer = CAGradientLayer()
    
    let view2      = UIView()
    let view2Layer = CAGradientLayer()

    func initViews() {
        
        contentView.backgroundColor  = "cl_main_back".color
        view1.backgroundColor        = "cl_cell_back".color
        view2.backgroundColor        = "cl_cell_back".color
        
        view1Layer.startPoint = CGPoint(x: 0, y: 0.5)
        view1Layer.endPoint   = CGPoint(x: 1, y: 0.5)
        view1.layer.addSublayer(view1Layer)
        
        view2Layer.startPoint = CGPoint(x: 0, y: 0.5)
        view2Layer.endPoint   = CGPoint(x: 1, y: 0.5)
        view2.layer.addSublayer(view2Layer)
        
        let viewGroup = makeAnimationGroup()
        viewGroup.beginTime = 0.0
        view1Layer.add(viewGroup, forKey: "backgroundColor")
        
        let viewGroup2 = makeAnimationGroup(previousGroup: viewGroup)
        view2Layer.add(viewGroup2, forKey: "backgroundColor")
        
        addSubview(view1)
        view1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(UIScreen.main.bounds.width - 150)
        }
        
        addSubview(view2)
        view2.snp.makeConstraints { make in
            make.left.equalTo(view1.snp.right).offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
        }
        
        view1Layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 150, height: 70)
        view1Layer.cornerRadius  = 20
        view1.layer.cornerRadius = 20
        
        view2Layer.frame = CGRect(x: 0, y: 0, width: 100, height: 70)
        view2Layer.cornerRadius  = 20
        view2.layer.cornerRadius = 20
    }
    
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.gradientLightGrey.cgColor
        anim1.toValue = UIColor.gradientDarkGrey.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0

        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.gradientDarkGrey.cgColor
        anim2.toValue = UIColor.gradientLightGrey.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude // infinite
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            // Offset groups by 0.33 seconds for effect
            group.beginTime = previousGroup.beginTime + 0.33
        }
    
        return group
    }
}
