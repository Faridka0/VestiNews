//
//  XMLParserService.swift
//  VestiNews
//
//  Created by Фарид Гулиев on 17.03.2020.
//  Copyright © 2020 Фарид Гулиев. All rights reserved.
//

import Foundation

class XMLParserService: NSObject, XMLParserDelegate {
    private let sourceURL: URL = URL(string: "https://www.vesti.ru/vesti.rss")!
    private var items: [News] = []
    private var completion: (([News]) -> ())?
    private var currentElement: String = ""
    private var currentTitle: String = ""
    private var currentDescription: String = ""
    private var currentPubDate: String = ""
    private var currentCategory: String = ""
    
    func parse(completion: (([News]) -> ())?) {
        self.completion = completion
        let task = URLSession.shared.dataTask(with: sourceURL) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    //MARK: - XML Parse Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentCategory = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentDescription += string
        case "pubDate": currentPubDate += string
        case "category": currentCategory += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            self.items.append(News(title: currentTitle, description: currentDescription, pubDate: currentPubDate, category: currentCategory))
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.completion?(items)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
