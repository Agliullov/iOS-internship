//
//  HelpFilterViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

protocol FilterStructChange: class {
  func filterValueDidChange(filter: [FilterViewControllerDataSourse]?)
}

class HelpFilterViewController: UIViewController {
  
  weak var delegate: FilterStructChange?
  
  var filters: [FilterViewControllerDataSourse] = []
  
  var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = UIColor(red: 232 / 255, green: 237 / 255, blue: 237 / 255, alpha: 1.0)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    
    tableView.register(EventFilterHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: String(describing: EventFilterHeaderTableViewCell.self))
    tableView.register(EventFilterTableViewCell.self, forCellReuseIdentifier: String(describing: EventFilterTableViewCell.self))
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Фильтр"
    
    self.navigationItem.setHidesBackButton(true, animated: true)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "rectangle"), style: .done, target: self, action: #selector(backVC)), animated: true)
    self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "doneIcon"), style: .done, target: self, action: #selector(doneFilter)), animated: true)
    
    self.view.addSubview(self.tableView)
    self.tableView.frame = self.view.bounds
    
    self.tableView.tableFooterView = UIView()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  @objc func backVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func doneFilter(){
    self.delegate?.filterValueDidChange(filter: self.filters)
    backVC()
  }
}

extension HelpFilterViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filters.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventFilterTableViewCell.self)) as? EventFilterTableViewCell else { return UITableViewCell() }
    let filter = self.filters[indexPath.row]
    cell.setup(filter: filter)
    cell.complitionHandler = { [weak self ] in
      self?.filters[indexPath.row].isOn = cell.filterSwitch.isOn
    }
    return cell
  }
}

extension HelpFilterViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: EventFilterHeaderTableViewCell.self)) as? EventFilterHeaderTableViewCell else { return nil }
    headerView.titleLabel.text = "Как вы хотите помочь?"
    return headerView
  }
}
