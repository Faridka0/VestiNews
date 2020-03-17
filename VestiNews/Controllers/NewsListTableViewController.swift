//
//  NewsListTableViewController.swift
//  VestiNews
//
//  Created by Фарид Гулиев on 17.03.2020.
//  Copyright © 2020 Фарид Гулиев. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    //MARK: - Services
    private let xmlParser = XMLParserService()
    
    //MARK: - Constants
    private let cellID: String = "newsCell"
    private let newsDetailSegueID: String = "newsDetailSegue"
    private var news: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    //MARK: - Private functions
    private func loadData() {
        xmlParser.parse { (news) in
            
            self.news = news
            
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == newsDetailSegueID {
            let destinationVC = segue.destination as! NewsDetailViewController
            guard let row = tableView.indexPathForSelectedRow?.row else { return }
            destinationVC.selectedNews = news[row]
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NewsListTableViewCell
        let currentNews = news[indexPath.row]
        cell.newsTitle.text = currentNews.title
        cell.newsPubDate.text = currentNews.pubDate
        cell.newsDescription.text = currentNews.description
        cell.newsCategory.text = currentNews.category
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
