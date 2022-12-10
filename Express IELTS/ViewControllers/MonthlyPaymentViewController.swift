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
    
//    let pieChart = PieChart(frame: CGRect(x: 0, y: 0,
//                                          width:  UIScreen.main.bounds.width / 1.2,
//                                          height: UIScreen.main.bounds.width / 1.2))

    override func viewDidLoad() {
        super.viewDidLoad()
//        makeChartUI()
    }
    
    override func configureNavBar() {
        title = "Monthly payments"
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = .systemPink
        
        subView.addSubview(pieChart)
        pieChart.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.top.equalToSuperview().offset(100)
            make.width.equalTo(300)
        }
        makeChartUI()
    }
    
    func makeChartUI() {
        pieChart.lineWidth = 0.85
        pieChart.addChartData(data: [
            PieChartDataSet(percent: 20, colors: [UIColor.purpleishBlueThree,UIColor.brightLilac]),
            PieChartDataSet(percent: 20, colors: [UIColor.darkishPink,UIColor.lightSalmon]),
            PieChartDataSet(percent: 20, colors: [UIColor.dustyOrange,UIColor.lightMustard]),
            PieChartDataSet(percent: 40, colors: [UIColor.greenyBlue,UIColor.hospitalGreen])
            
        ])
    }

}
