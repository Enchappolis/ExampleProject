//
//  main.swift
//  ExampleProject
//
//  Copyright © 2018 SwiftTheCompleteProgrammingCourse. All rights reserved.
//
/*
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
*/

import Foundation

let author = Author(firstName: "John", lastName: "Smith")
author.address = Address(city: "city", state: "state", zipCode: 0)

var bookList = [Book]()
bookList = Book.createSampleBooks(numberOfBooks: 10, includeInvalidBooks: false)

let bookHandler = BookHandler()
bookHandler.delegate = author

var numberOfBooksPublished = 0

let dispatchGroup = DispatchGroup()

// Publish books result.
let publishBookResultHandler: PublishResultHandler = { result in
    
    //        print("Publisher.bookApproval() \(Thread.current)")
    
    switch result {
        
    case .success(.bookPublished(bookTitle: let bookTitle)):
        
        numberOfBooksPublished += 1
        
        print("Book \(bookTitle) published")
    case .failure(.genreMissing(let errorMessage)):
        
        print(errorMessage)
        
    case .failure(.authorMissing(let errorMessage)):
        
        print(errorMessage)
    case .failure(.bookNotApproved(let errorMessage)):
        
        print(errorMessage)
        
    case .failure(.error(let errorMessage)):
        print(errorMessage)
    }
    
    dispatchGroup.leave()
}

// Publish books.
for book in bookList {
    
    dispatchGroup.enter()
    
    bookHandler.publish(book: book, from: author, completion: publishBookResultHandler)
}

dispatchGroup.notify(queue: .main) {
    
    print("\n")
    print("Tried to publish \(bookList.count) books")
    print("Number of books published \(numberOfBooksPublished)")
    
    let numberOfFantasyBooks = bookHandler.numberOfBooksInList(bookGenre: BookGenre.fantasy)
    let numberOfRomanceBooks = bookHandler.numberOfBooksInList(bookGenre: BookGenre.romance)
    let numberOfScifiBooks = bookHandler.numberOfBooksInList(bookGenre: BookGenre.scifi)
    
    print("numberOfFantasyBooks: \(numberOfFantasyBooks)")
    print("numberOfRomanceBooks: \(numberOfRomanceBooks)")
    print("numberOfScifiBooks: \(numberOfScifiBooks)")
    
    print("numberOfFantasyBooksPublishedByAuthor: \(author.numberOfFantasyBooksPublished)")
    print("numberOfRomanceBooksPublishedByAuthor: \(author.numberOfRomanceBooksPublished)")
    print("numberOfSciFiBooksPublishedByAuthor: \(author.numberOfSciFiBooksPublished)")
}

RunLoop.main.run()
