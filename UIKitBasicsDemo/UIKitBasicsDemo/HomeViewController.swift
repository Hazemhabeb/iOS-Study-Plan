//
//  Untitled.swift
//  UIKitBasicsDemo
//
//  Created by hazemhabeb on 08/07/2025.
//

import UIKit

class HomeViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Welcome to UIKit"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to Table View", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        view.addSubview(label)
        view.addSubview(button)

        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
        ])

        button.addTarget(self, action: #selector(goToTableView), for: .touchUpInside)
    }

    @objc func goToTableView() {
        let vc = SimpleTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
