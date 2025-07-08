//
//  Untitled.swift
//  UIKitBasicsDemo
//
//  Created by hazemhabeb on 08/07/2025.
//

import UIKit

class SimpleTableViewController: UIViewController, UITableViewDataSource {

    let tableView = UITableView()
    let data = ["One", "Two", "Three", "Four", "Five"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simple Table"
        view.backgroundColor = .white

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
