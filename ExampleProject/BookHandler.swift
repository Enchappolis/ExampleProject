//
//  BookHandler.swift
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

typealias PublishResultHandler = (Result<BookHandler.BookHandlerResult, BookHandler.BookHandlerError>) -> ()

protocol BookHandlerProtocol: AnyObject {
    func published(book: Book)
}

class BookHandler {
    
    // MARK: - Enums
    enum BookHandlerResult {
        case bookPublished(bookTitle: String)
    }
    
    enum BookHandlerError: Error {
        case genreMissing(errorMessage: String)
        case authorMissing(errorMessage: String)
        case bookNotApproved(errorMessage: String)
        case error(String)
    }
    
    // MARK: - Private Variables
    private var publisher = Publisher()

    // BookHandler keeps record of all published books by storing them here.
    private var publishedBooks = [BookGenre:[Book]]()
    
    // MARK: - Public Variables
    weak var delegate: BookHandlerProtocol?
    
    // MARK: - Private Methods
    private func appendBookAndNotify(book: Book) {
        
        if let bookGenre = book.genre {
            
            var books = [Book]()
            
            if let alreadyExistingBooks = publishedBooks[bookGenre] {
                
               books = alreadyExistingBooks
            }
                
            books.append(book)

            publishedBooks[bookGenre] = books

            delegate?.published(book: book)
        }
    }
    
    // MARK: - Public Methods
    func publish(book: Book, from author: Author?, completion: @escaping PublishResultHandler) {
        
        // Genre is required.
        guard book.genre != nil else {
        
            let errorMessage = """
            Genre Of Book "\(book.title)" is Missing.
            """
            
            let bookHandlerError = BookHandler.BookHandlerError.genreMissing(errorMessage: errorMessage)
            
            completion(.failure(bookHandlerError))
            return
        }
        
        // Author is required.
        guard author != nil else {
            
            let errorMessage = """
            Author Of Book "\(book.title)" is Missing.
            """
            
            completion(.failure(BookHandler.BookHandlerError.authorMissing(errorMessage: errorMessage)))
            return
        }
        
        // Get approvel from publisher.
        publisher.approvelFor(publishable: book, simulateFailure: false) { (result) in
            
            switch result {
                
            // Ignore approvedMessage.
            case .success(.approved(publishable: let publishable, approvedMessage: _)):
                
                // BookHandler can only deal with books.
                // Make sure publishable is of type Book.
                guard let book = publishable as? Book else {
                    
                    completion(.failure(BookHandler.BookHandlerError.error("BookHandler can only publish books.")))
                    return
                }
                
                // Genre is required.
                guard book.genre != nil else {
                
                    let errorMessage = """
                    Genre Of Book "\(book.title)" is Missing.
                    """
                    
                    let bookHandlerError = BookHandler.BookHandlerError.genreMissing(errorMessage: errorMessage)
                    
                    completion(.failure(bookHandlerError))
                    return
                }
                
                // Add book to list and notify delegate.
                self.appendBookAndNotify(book: book)
                
                completion(.success(BookHandler.BookHandlerResult.bookPublished(bookTitle: book.title)))
                
            case .failure(let publisherError):
                
                switch publisherError {
                case .notApproved(let errorMessage):
                    
                    completion(.failure(BookHandler.BookHandlerError.bookNotApproved(errorMessage: errorMessage)))
                
                case .someError(let errorMessage):
                    
                    completion(.failure(BookHandler.BookHandlerError.error(errorMessage)))
                }
            }
        }
    }
    
    func numberOfBooksInList(bookGenre: BookGenre) -> Int {
        
        return publishedBooks[bookGenre]?.count ?? 0
    }
}
