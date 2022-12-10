//
//  MonthlyPaymentViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class MonthlyPaymentViewController: BaseViewController {
    
    let subView = UIView()
    
    let pieChart = PieChart()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavBar() {
        title = "Monthly payment"
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = .systemPink
        
        subView.addSubview(pieChart)
        pieChart.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(width/2 - width/2.4)
            make.top.equalToSuperview().offset(topPadding + 30)
        }
        animateChartUI()
    }
    
    func animateChartUI() {
        pieChart.lineWidth = 0.85
        pieChart.addChartData(data: [
            PieChartDataSet(percent: 20, colors: [UIColor.purpleishBlueThree,UIColor.brightLilac]),
            PieChartDataSet(percent: 20, colors: [UIColor.darkishPink,UIColor.lightSalmon]),
            PieChartDataSet(percent: 20, colors: [UIColor.dustyOrange,UIColor.lightMustard]),
            PieChartDataSet(percent: 40, colors: [UIColor.greenyBlue,UIColor.hospitalGreen])
        ])
    }

}
