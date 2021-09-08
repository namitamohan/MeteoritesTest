//
//  BookmarksViewController.swift
//  MeteoriteTest
//
//  Created by Namita on 9/5/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import UIKit

protocol BookmarkViewDelegate {
    
    func displayList(list: [Meteorite])
}

class BookmarksViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    private let bookmarkPresenter = BookmarkPresenter()
    var meteorites: [Meteorite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.Titles.bookmark
        bookmarkPresenter.setViewDelegate(bookmarkViewDelegate: self)
        bookmarkPresenter.getBookmarkedMeteorites()
        tableView.tableFooterView = UIView()
    }
}

extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCells.bookmarkTableViewCell, for: indexPath) as! BookmarkTableViewCell
        cell.setDataForCell(meteorite: meteorites[indexPath.row])
        return cell
    }
}

extension BookmarksViewController: BookmarkViewDelegate {
    
    func displayList(list: [Meteorite]) {
        meteorites = list
        tableView.reloadData()
    }
}
