//
//  DetailViewController.swift
//  UIKitMiniDemo
//
//  Created by hazemhabeb on 22/10/2025.
//

import UIKit

class DetailViewController : UIViewController {
    
    private let item : Item
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = item.title
        
        let label = UILabel()
        label.text = item.description
        label.textAlignment = .center
        label.numberOfLines = 0
        label.frame = view.bounds
        view.addSubview(label)
    }
    
}
