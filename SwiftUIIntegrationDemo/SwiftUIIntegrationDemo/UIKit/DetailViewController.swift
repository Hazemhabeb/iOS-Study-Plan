//
//  DetailViewController.swift
//  SwiftUIIntegrationDemo
//
//  Created by hazemhabeb on 22/10/2025.
//

import UIKit

protocol DetailViewControllerDelegate : AnyObject {
    func didDismissDetail()
}

final class DetailViewController : UIViewController {
    var item : Item?
    weak var delegate : DetailViewControllerDelegate?
    
    private let titleLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI (){
        titleLabel.text = item?.title
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setTitle("dismiss", for: .normal)
        closeButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            closeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func dismissTapped() {
        delegate?.didDismissDetail()
        dismiss(animated: true)
    }

}
