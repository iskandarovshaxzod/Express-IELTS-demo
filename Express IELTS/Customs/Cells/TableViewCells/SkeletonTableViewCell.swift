//
//  SkeletonTableViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.01.2023.
//

import UIKit

class SkeletonTableViewCell: UITableViewCell {
    
    let view      = UIView()
    let viewLayer = CAGradientLayer()

    func initViews() {
        
        contentView.backgroundColor = "cl_main_back".color
        view.backgroundColor        = "cl_cell_back".color
        
        viewLayer.startPoint = CGPoint(x: 0, y: 0.5)
        viewLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        view.layer.addSublayer(viewLayer)
        
        let viewGroup = makeAnimationGroup()
        viewGroup.beginTime = 0.0
        viewLayer.add(viewGroup, forKey: "backgroundColor")
        
        addSubview(view)
        view.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        viewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 100) //view.bounds
        viewLayer.cornerRadius  = 20
        view.layer.cornerRadius = 20
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

extension UIColor {

    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }

    static var gradientLightGrey: UIColor {
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }

}
