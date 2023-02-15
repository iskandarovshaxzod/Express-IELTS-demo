//
//  TeacherRevenueViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.12.2022.
//

import UIKit

class TeacherRevenueViewController: BaseViewController {
    
    let presenter = TeacherPaymentListPresenter()
    
    let subView   = UIView()
    let monthView = HeaderMonthView()
    let tableView = UITableView()
    let segment   = UISegmentedControl(items: ["By teacher", "By group"])
    
    var teacher: Teacher?
    var receipts  = [Payment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllTeacherPayments(teacherID: teacher?.id?.description ?? "", year: 2023, month: 2)
    }
    
    override func configureNavBar() {
        title = teacher?.teacherName.capitalized
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
        
        subView.addSubview(monthView)
        monthView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        monthView.delegate = self
        
        subView.addSubview(segment)
        segment.snp.makeConstraints { make in
            make.top.equalTo(monthView.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(36)
        }
        segment.selectedSegmentIndex = 0
        segment.selectedSegmentTintColor = "cl_text_blue".color
        
        segment.setTitleTextAttributes([.foregroundColor: "cl_text_blue".color], for: .normal)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segment.layer.borderWidth = 2
        segment.layer.borderColor = "cl_text_blue".color.cgColor
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        tableView.backgroundColor = "cl_main_back".color
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension TeacherRevenueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = receipts[indexPath.row].date
        cell.backgroundColor = "cl_cell_back".color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = StudentReceiptViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.text = "Payment Dates"
        present(vc, animated: false)
    }
}

extension TeacherRevenueViewController: TeacherPaymentListDelegate {
    func onSuccessGetAllTeacherPayments(receipts: [Payment]) {
        DispatchQueue.main.async { [weak self] in
            self?.receipts = receipts
            self?.reloadData()
        }
    }
    
    func onSuccessAddNewTeacherPayment() {}
    
    func onError(error: String?) {
        showErrorMessage(title: error)
    }
}

extension TeacherRevenueViewController: HeaderMonthChanged {
    func monthChanged(to month: Months) {
        
    }
}
