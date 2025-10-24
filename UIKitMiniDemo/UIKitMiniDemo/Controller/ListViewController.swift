//
//  ListViewController.swift
//  UIKitMiniDemo
//
//  Created by hazemhabeb on 22/10/2025.
//

import UIKit

class ListViewController : UIViewController {
    
    private var item : [Item] = [
        .init(id: 1, title: "SwiftUI", description: "Learn modern UI"),
        .init(id: 2, title: "UIKit", description: "Master legancy code"),
        .init(id: 3, title: "Combine", description: "Reactive Programming")
    ]
    
    private let tableView = UITableView()
    
    weak var delegate : ItemSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items"
        setUpTableView()
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self ,forCellReuseIdentifier: "cell" )
    }
    
}

extension ListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = item[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = item[indexPath.row]
        delegate?.didSet(item: selected)
    }
    
}
