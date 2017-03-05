//
//  Books+Utils.swift
//  HackerBooksLite
//
//  Created by Daniel Sánchez on 5/3/17.
//  Copyright © 2017 KeepCoding. All rights reserved.
//

import CoreData

extension Book {
    func bookDB(context: NSManagedObjectContext) -> BookDB {
        
        let aBook = BookDB(context: context)
        
        aBook.title = self.title
        
        for author in _authors {
            let authorDB = AuthorsDB(context: context)
            authorDB.fullName = author
            
            authorDB.addToBooks(aBook)
            aBook.authors?.adding(authorDB)
        }
        
        for tag in _tags {
            let bookTagDB = TagDB(context: context)
            bookTagDB.tagName = tag._name
            
            let tagDB = TagDB(context: context)
            tagDB.tagName = tag._name
            tagDB.tagNameSorting = tag._name
            
            bookTagDB.tagName = tagDB
            bookTagDB.books = aBook
            aBook.addToBookTags(bookTagDB)
        }
        
        let pdfData = Pdf(context: context)
        pdfData.book = aBook
        pdfData.urlString = self._pdf.url.absoluteString
        pdfData.pdfData = self._pdf._data as NSData?
        
        let image = Photo(context: context)
        image.bookDB = aBook
        image.remoteUrl = self._image.url.absoluteString
        
        return aBook
    }
    
    func booksData(books: [Book]) -> [BookDB] {
        
        let booksData = [BookDB]()
        for book in books {
            
        }
        return booksData
    }
}
