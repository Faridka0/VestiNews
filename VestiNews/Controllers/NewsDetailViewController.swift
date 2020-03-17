//
//  NewsDetailViewController.swift
//  VestiNews
//
//  Created by Фарид Гулиев on 17.03.2020.
//  Copyright © 2020 Фарид Гулиев. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private var newsTitle: UILabel!
    @IBOutlet private var newsDescription: UITextView!
    
    //MARK: - Constants
    var selectedNews: News?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIElements()
    }
    
    //MARK: - Setup UI Elements
    private func setupUIElements() {
        guard selectedNews != nil else { return }
        setupLabel()
        setupTextView()
    }
    
    private func setupLabel() {
        newsTitle.text = selectedNews!.title
    }
    
    private func setupTextView() {
        newsDescription.text = selectedNews!.description
    }
}
