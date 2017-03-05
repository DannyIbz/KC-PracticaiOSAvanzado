//
//  Books+Utils.swift
//  HackerBooksLite
//
//  Created by Daniel Sánchez on 1/3/17.
//  Copyright © 2017 KeepCoding. All rights reserved.
//

import CoreData

extension BookDB {
    
    //MARK: - Decodification
    func decode(book dict: JSONDictionary) throws -> BookDB{
        
        var context: NSManagedObjectContext?
        
        // validate first
        try validate(dictionary: dict)
        
        // extract from dict
        func extract(key: String) -> String{
            return dict[key]!   // we know it can't be missing because we validated first!
        }
        
        // parsing
        let authors = parseCommaSeparated(string: extract(key: "authors"))
        let imgURL = URL(string: extract(key: "image_url"))!
        let pdfURL = URL(string: extract(key: "pdf_url"))!
        let tags = Tags(parseCommaSeparated(string: extract(key: "tags")).map{Tag(name: $0)})
        let title = extract(key: "title").capitalized
        
        let mainBundle = Bundle.main
        
        let defaultImage = mainBundle.url(forResource: "emptyBookCover", withExtension: "png")!
        let defaultPdf = mainBundle.url(forResource: "emptyPdf", withExtension: "pdf")!
        
        // AsyncData
        let image = AsyncData(url: imgURL, defaultData: try! Data(contentsOf: defaultImage))
        let pdf = AsyncData(url: pdfURL, defaultData: try! Data(contentsOf: defaultPdf))
        
        // Insert JSON data on BookDB entity
        for author in authors {
            let authorDB = AuthorsDB(context: context!)
            authorDB.fullName = author
            
            authorDB.addToBooks(b)
            b.authors?.adding(authorDB)
        }
        
        
        self.title = title
        
        self.authors = AuthorsDB
        
        return self
    }
    
    func decode(book dict: JSONDictionary?) throws -> Book{
        
        guard let d = dict else {
            throw JSONErrors.emptyJSONObject
        }
        return try decode(book:d)
    }
    
    
    //MARK: - Validation
    // Validation should be kept waya from processing to
    // insure the single responsability principle
    // https://medium.com/swift-programming/why-swift-guard-should-be-avoided-484cfc2603c5#.bd8d7ad91
    private
    func validate(dictionary dict: JSONDictionary) throws{
        
        func isMissing() throws{
            for key in dict.keys{
                guard let value = dict[key] else{
                    throw JSONErrors.missingField(name: key)
                }
                guard value.characters.count > 0  else {
                    throw JSONErrors.incorrectValue(name: key, value: value)
                }
            }
            
        }
        
        try isMissing()
        
    }
}
