//
//  EventViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 01.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
  
  var categoryEnum: CategoryEnum = .Default
  
  fileprivate var sections: [Events] = []
  
  fileprivate let filters: [FilterViewControllerDataSourse] = FilterViewControllerDataSourse.dataSourse()
  var mutableFilters: [FilterViewControllerDataSourse] = []
  
  var navTitle: String?
  
  var segmentControl: UISegmentedControl!
  
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    if #available(iOS 13.0, *) {
      tableView.backgroundColor = UIColor.secondarySystemGroupedBackground
    } else {
      tableView.backgroundColor = UIColor.gray
    }
    
    tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width, bottom: 0, right: 0)
    tableView.register(EventTableViewCellTest.self, forCellReuseIdentifier: String(describing: EventTableViewCellTest.self))
    tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.white
    self.setupSegmentControl()
    self.title = self.navTitle
    self.view.addSubview(self.tableView)
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.categoryChange(category: self.categoryEnum)
    
    NSLayoutConstraint.activate([
      self.tableView.topAnchor.constraint(equalTo: self.segmentControl.bottomAnchor, constant: 8.0),
      self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.view.rightAnchor.constraint(equalTo: self.tableView.rightAnchor),
      self.view.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor)
    ])
    
    self.navigationItem.setHidesBackButton(true, animated: true)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "rectangle"), style: .done, target: self, action: #selector(backVC)), animated: true)
    
    self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "filterIcon"), style: .done, target: self, action: #selector(filterEventVC)), animated: true)
  }
  
  func getDataSourceFromJSON(filename fileName: String) {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let events = NetworkDataFetcher.shared.decodeJSONData(type: [Events].self, from: data)
        if let events = events {
          self.sections = events
        }
      } catch {
        print("Error! Unable to parse \(fileName).json")
      }
    }
  }
  
  func setupSegmentControl() {
    var height: CGFloat = 0
    if let navigationBarMaxY = self.navigationController?.navigationBar.frame.maxY {
      height = navigationBarMaxY + 10.0
    }
    
    self.segmentControl = UISegmentedControl(frame: CGRect(x: 8, y: height, width: self.view.frame.width - 16, height: 30))
    self.segmentControl?.insertSegment(withTitle: "Текущие", at: 0, animated: false)
    self.segmentControl?.insertSegment(withTitle: "Завершенные", at: 1, animated: false)
    
    self.segmentControl?.selectedSegmentIndex = 0
    if #available(iOS 13.0, *) {
      self.segmentControl.selectedSegmentTintColor = GREEN_COLOR
    } else {
      self.segmentControl?.backgroundColor = GREEN_COLOR
    }
    
    self.segmentControl.layer.borderWidth = 1.0
    self.segmentControl.layer.borderColor = GREEN_COLOR.cgColor
    self.segmentControl.tintColor = GREEN_COLOR
    
    self.segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
    self.segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: GREEN_COLOR], for: UIControl.State.normal)
    self.view.addSubview(self.segmentControl!)
  }
  
  
  func categoryChange(category: CategoryEnum) {
    switch category {
    case .Kids:
      self.getDataSourceFromJSON(filename: "events")
    case .Adults:()
      
    case .Elderly:()
      
    case .Animals:()
      
    case .Events:()
      
    case .Default:()
    }
  }
  
  
  @objc fileprivate func openDetailsEvent(title: String) {
    let detailsEventVC = DetailsEventViewController()
    detailsEventVC.navigationTitle = title
    self.navigationController?.pushViewController(detailsEventVC, animated: true)
  }
  
  @objc fileprivate func backVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc fileprivate func filterEventVC() {
    let filterEventVC = HelpFilterViewController()
    filterEventVC.delegate = self
    if !self.mutableFilters.isEmpty {
      filterEventVC.filters = self.mutableFilters
    } else {
      filterEventVC.filters = self.filters
    }
    self.navigationController?.pushViewController(filterEventVC, animated: true)
  }
}

extension EventViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.sections.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCellTest.self)) as? EventTableViewCellTest else { return UITableViewCell() }
    let event = self.sections[indexPath.row]
    cell.setup(event: event)
    return cell
  }
}

extension EventViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let section = self.sections[indexPath.row]
    self.openDetailsEvent(title: section.mainLabel)
  }
}

extension EventViewController: FilterStructChanged {
  
  func filterValueDidChange(filter: [FilterViewControllerDataSourse]?) {
    guard let filter = filter else { return }
    self.mutableFilters = filter
  }
}
