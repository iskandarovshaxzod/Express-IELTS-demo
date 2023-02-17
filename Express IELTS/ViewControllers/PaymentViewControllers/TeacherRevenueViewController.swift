//
//  TeacherRevenueViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.12.2022.
//

import UIKit

class TeacherRevenueViewController: BaseViewController {
    
    let presenter = TeacherPaymentListPresenter()
    
    let subView    = UIView()
    let hView      = UIView()
    let monthView  = HeaderMonthView()
    let tableView  = UITableView()
    let noDataImg  = UIImageView()
    let segment    = UISegmentedControl(items: ["By teacher",
                                               "By group"])
    
    var teacher: Teacher?
    var payments    = [TeacherPayments]()
    var allReceipts = [Payment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllTeacherPayments(teacherID: teacher?.id?.description ?? "",
                                        year: 2023, month: 2)
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
        segment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        subView.addSubview(noDataImg)
        noDataImg.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        noDataImg.image       = UIImage(named: "no_data")
        noDataImg.contentMode = .scaleAspectFit
        noDataImg.isHidden    = true
        
        
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
    
    @objc func segmentChanged() {
        reloadData()
    }

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension TeacherRevenueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return segment.selectedSegmentIndex == 0 ? 1 : payments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segment.selectedSegmentIndex == 0 ? allReceipts.count : payments.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return segment.selectedSegmentIndex == 1 ? payments[section].group.groupName.capitalized : ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = segment.selectedSegmentIndex == 0 ? "\(allReceipts[indexPath.row].student)" : payments[indexPath.row].group.groupName.capitalized
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
    func onSuccessGetAllTeacherPayments(payments: [TeacherPayments], allReceipts: [Payment]) {
        DispatchQueue.main.async { [weak self] in
            self?.payments    = payments
            self?.allReceipts = allReceipts
            self?.reloadData()
            print(payments.count)
            print(allReceipts.count)
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
