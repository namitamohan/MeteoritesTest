//
//  ViewController.swift
//  MeteoriteTest
//
//  Created by Namita on 9/3/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import UIKit

protocol MeteoriteListViewDelegate: NSObjectProtocol {
    
    func displayList(response:[Meteorite]?)
    
    func displayFilteredList(list: [Meteorite])

    func displayError(error: String)
}

class MeteoriteListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private let meteoriteListPresenter = MeteoriteListPresenter(meteoriteDataService: MeteoriteDataService())
    var meteorites: [Meteorite] = []
    var filteredList: [Meteorite] = []
    
    var refreshView: UIRefreshControl {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refresh
    }
    
    var filters = MeteoriteFilters(fromYear: nil, sortBy: .name)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        meteoriteListPresenter.setViewDelegate(meteoriteListViewDelegate: self)
        getMeteoriteList()
    }
    
    func setupViews() {
        title = Constants.Titles.homeViewTitle
        tableView.refreshControl = refreshView
        tableView.tableFooterView = UIView()
    }
    
    func getMeteoriteList() {
        meteoriteListPresenter.getMeteoriteList()
    }
    
    @objc func handleRefresh(_ control: UIRefreshControl) {
        getMeteoriteList()
    }
    
    @IBAction func fillterAction(_ sender: Any) {
        let filterViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.ViewControllers.filterTableViewController) as! FilterTableViewController
        
        filterViewController.filters = self.filters
        filterViewController.saveFilters = { [weak self] (selectedFilters) in
            self?.filters = selectedFilters
            self?.meteoriteListPresenter.getFilteredList(list: self?.meteorites, filters: self?.filters)
        }
        
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    @IBAction func bookMarkAction(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.ViewControllers.bookmarksViewController) as! BookmarksViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MeteoriteListViewController: MeteoriteListViewDelegate {
    
    func displayFilteredList(list: [Meteorite]) {
        filteredList = list
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func displayList(response: [Meteorite]?) {
        meteorites = response ?? []
        filteredList = meteorites
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func displayError(error: String) {
        print(error)
    }
}

extension MeteoriteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meteorite = filteredList[indexPath.row]
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.ViewControllers.meteoriteLocationViewController) as! MeteoriteLocationViewController
        viewController.meteorite = meteorite
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension MeteoriteListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCells.meteoriteListTableViewCell, for: indexPath) as! MeteoriteListTableViewCell
        cell.setDataForCell(meteorite: filteredList[indexPath.row])
        cell.bookmarkMeteorite = { [weak self] in
            self?.meteoriteListPresenter.bookmarkMeteorite(meteorite: self?.filteredList[indexPath.row]) { (isBookmarked) in
                cell.bookmarkButton.isSelected = isBookmarked
            }
        }
        return cell
    }
}
