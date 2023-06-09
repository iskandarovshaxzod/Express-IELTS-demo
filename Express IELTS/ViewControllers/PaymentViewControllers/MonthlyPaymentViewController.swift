//
//  MonthlyPaymentViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class MonthlyPaymentViewController: BaseViewController {
    
    let subView    = UIView()
    let totalView  = TotalRevenueView()
    let branchView = TotalRevenueView()
    
    let pieChart = PieChart()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateChartUI()
    }
    
    override func configureNavBar() {
        title = "monthly_payment".localized
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
        
        subView.addSubview(pieChart)
        pieChart.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(width/2 - width/2.4)
        }
        
        subView.addSubview(totalView)
        totalView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(width / 1.2)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(width / 2 + 20)
        }
        
        subView.addSubview(branchView)
        branchView.snp.makeConstraints { make in
            make.top.equalTo(totalView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(width / 2 + 20)
        }

        
        totalView.updateTexts(text: "monthly_rev_all_branch".localized,  sum: "1 000 200 200")
        branchView.updateTexts(text: String(format: "monthly_rev_a_branch".localized, "`Mega`"), sum: "0")
    }
    
    func animateChartUI() {
        pieChart.lineWidth = 0.85
        pieChart.addChartData(data: [
            PieChartDataSet(percent: 40, colors: [UIColor.purpleishBlueThree,UIColor.brightLilac]),
            PieChartDataSet(percent: 40, colors: [UIColor.darkishPink,UIColor.lightSalmon]),
            PieChartDataSet(percent: 19, colors: [UIColor.dustyOrange,UIColor.lightMustard]),
            PieChartDataSet(percent: 1, colors: [UIColor.greenyBlue,UIColor.hospitalGreen])
        ])
    }

}
