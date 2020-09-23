//
//  EventViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 01.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    private var filters: [FiltersEntity] = []
    
    private var sections: [EventsEntity] = []
    
    var mutableFilters: [FiltersEntity] = []
    
    var categoryEnum: CategoryEnum = .Default
    private var mode: ControllerMode = .viewing
    
    private let coreDataService = CoreDataService()
    private let alamofireDataService = AlamofireNetworkService()
    private let firebaseDataService = FirebaseDataService()
    private let localDataService = LocalDataService()

    var navigationTitle: String?
    
    private var segmentControl: UISegmentedControl!
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = UIColor.secondarySystemGroupedBackground
        } else {
            tableView.backgroundColor = UIColor.likesGrayColor
        }
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width, bottom: 0, right: 0)
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: String(describing: EventTableViewCell.self))
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navigationTitle
        view.backgroundColor = UIColor.white
        
        setupSegmentControl()
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        categoryChange(category: categoryEnum)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 8.0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "rectangle"), style: .done, target: self, action: #selector(backVC)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "filterIcon"), style: .done, target: self, action: #selector(filterEventVC)), animated: true)
        
        checkFilterDataWithAlamofire()
    }
    
    private func checkFilterDataWithAlamofire() {
        alamofireDataService.getAlamofireFilters { (data, error) in
            if let data = data, data.count != 0 {
                DispatchQueue.main.async {
                    self.filters = data
                }
            } else {
                self.localDataService.getLocalEventFilters { (filters) in
                    self.filters = filters!
                }
            }
        }
    }
    
    private func checkDataWithAlamofire() {
        self.setMode(mode: .updating)
        alamofireDataService.getAlamofireEvents { (data, error) in
            if let data = data, data.count != 0 {
                DispatchQueue.main.async {
                    self.sections = data
                    self.tableView.reloadData()
                    self.setMode(mode: .viewing)
                }
            } else {
                self.firebaseFetchService()// Check data from Firebase.getData
            }
        }
    }
    
    private func firebaseFetchService() {
        self.setMode(mode: .updating)
        firebaseDataService.getEventsFirebaseData { (categories) in
            if let categoryInFB = categories, categoryInFB.count != 0 {
                DispatchQueue.main.async() {
                    self.sections = categoryInFB
                    self.tableView.reloadData()
                    self.setMode(mode: .viewing)
                }
            } else {
                let alertController = UIAlertController(title: "Произошла ошибка подключения", message: "Не удалось подключиться к серверу. Данные могут быть устаревшими.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                self.coreDataFetchService()// Check data from CoreData
                self.setMode(mode: .viewing)
            }
        }
    }
    
    fileprivate func coreDataFetchService() {
        self.setMode(mode: .updating)
        if let coreDataFetch = coreDataService.fetchEventDataFromCoreData(), coreDataFetch.count != 0 {
            DispatchQueue.main.async() {
                self.sections = coreDataFetch
                self.tableView.reloadData()
                self.setMode(mode: .viewing)
            }
        } else {
            let _ = localDataService.getLocalEventKids { eventsFromJSON in // Get local data and save in CoreData
                self.coreDataService.saveEventDataInCoreData(eventsFromJSON) { eventsSaveInCoreData in
                    guard let localEvents = eventsSaveInCoreData else { return }
                    var objectsCategoryEntity: [EventsEntity] = []
                    
                    for event in localEvents {
                        var detailsInfo: DetailsInfo?
                        if let _ = event.detailsInfo {
                            do {
                                detailsInfo = try JSONSerialization.jsonObject(with: event.detailsInfo!, options: .allowFragments) as? DetailsInfo
                            } catch let error as NSError {
                                print(error)
                            }
                        }
                        let object = EventsEntity(id: event.id,
                                                  eventTitle: event.eventTitle ?? "",
                                                  eventImageView: event.eventImageView ?? "",
                                                  topDescriptionLabel: event.topDescriptionLabel ?? "",
                                                  timeLabel: event.timeLabel ?? "",
                                                  detailsInfo: detailsInfo)
                        objectsCategoryEntity.append(object)
                    }
                    DispatchQueue.main.async() {
                        self.sections = objectsCategoryEntity
                        self.tableView.reloadData()
                    }
                }
                self.setMode(mode: .viewing)
            }
        }
    }
    
    func setupSegmentControl() {
        var height: CGFloat = 0
        if let navigationBarMaxY = self.navigationController?.navigationBar.frame.maxY {
            height = navigationBarMaxY + 10.0
        }
        
        segmentControl = UISegmentedControl(frame: CGRect(x: 8, y: height, width: view.frame.width - 16, height: 30))
        segmentControl?.insertSegment(withTitle: "Текущие", at: 0, animated: false)
        segmentControl?.insertSegment(withTitle: "Завершенные", at: 1, animated: false)
        
        segmentControl?.selectedSegmentIndex = 0
        
        if #available(iOS 13.0, *) {
            self.segmentControl.selectedSegmentTintColor = UIColor.greenColor
        } else {
            //self.segmentControl?.tintColor = UIColor.greenColor
        }
        
        segmentControl.layer.borderWidth = 1.0
        segmentControl.layer.borderColor = UIColor.greenColor.cgColor
        segmentControl.tintColor = UIColor.greenColor
        
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.greenColor], for: UIControl.State.normal)
        view.addSubview(segmentControl!)
    }
    
    func categoryChange(category: CategoryEnum) {
        switch category {
        case .Kids:
            checkDataWithAlamofire()
        case .Adults:()
            
        case .Elderly:()
            
        case .Animals:()
            
        case .Events:()
            
        case .Default:()
        }
    }
    
    fileprivate func openDetailsEvent(event: EventsEntity) {
        let detailsEventVC = DetailsEventViewController()
        detailsEventVC.events = event
        detailsEventVC.navigationTitle = event.eventTitle
        navigationController?.pushViewController(detailsEventVC, animated: true)
    }
    
    @objc fileprivate func backVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func filterEventVC() {
        let filterEventVC = HelpFilterViewController()
        filterEventVC.delegate = self
        if !mutableFilters.isEmpty {
            filterEventVC.filters = mutableFilters
        } else {
            filterEventVC.filters = filters
        }
        navigationController?.pushViewController(filterEventVC, animated: true)
    }
    
    //MARK: - Activity Indicator
    private func setMode(mode: ControllerMode) {
        self.mode = mode
        self.updateNavigationItems(animated: true)
    }
    
    private func updateNavigationItems(animated: Bool) {
        switch self.mode {
        case .viewing:
            self.navigationItem.setHidesBackButton(false, animated: animated)
            self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "filterIcon"), style: .done, target: self, action: #selector(filterEventVC)), animated: true)

        case .editing:()
        case .updating:
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.color = UIColor.white
            activityIndicator.startAnimating()
            
            let rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
            self.navigationItem.setRightBarButton(rightBarButtonItem, animated: animated)
            self.navigationItem.setHidesBackButton(true, animated: animated)
        }
    }
}

extension EventViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self)) as? EventTableViewCell else { return UITableViewCell() }
        let event = sections[indexPath.row]
        cell.setup(event: event)
        cell.selectionStyle = .none
        return cell
    }
}

extension EventViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.row]
        openDetailsEvent(event: section)
    }
}

extension EventViewController: FilterStructChange {
    
    func filterValueDidChange(filter: [FiltersEntity]?) {
        guard let filter = filter else { return }
        mutableFilters = filter
    }
}
