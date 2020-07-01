//
//  Publisher.swift
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

protocol Publishable {
    
    var title: String { get set }
}

class Publisher {
    
    // MARK: - Enums
    enum PublisherResult {
        case approved(publishable: Publishable, approvedMessage: String)
    }
    
    enum PublisherError: Error {
        case someError(String)
        case notApproved(String)
    }
    
    // MARK: - Private Methods
    private func hasBookTitleANumberUsingFilter(title: String) -> Bool {
        
        // Get the number of the book title.
        let titleNumber = title.filter { (character) -> Bool in
            
            let number = Int(String(character))
            
            return number != nil
        }
        
        return !titleNumber.isEmpty
    }
    
    private func hasBookTitleANumber(title: String) -> Bool {
        
        var bookNumber: String.SubSequence = ""
        
        if let indexOfEmptyCharacter = title.firstIndex(of: " ") {
            
            let indexOfFirstCharacterAfterEmptyCharacter = title.index(after: indexOfEmptyCharacter)
            bookNumber = title[indexOfFirstCharacterAfterEmptyCharacter...]
        }
        
        return !bookNumber.isEmpty
    }
    
    // MARK: - Public Methods
    // Only of type Publishable can be published.
    func approvelFor<T: Publishable>(publishable: T, simulateFailure: Bool, completion: @escaping (Result<PublisherResult, PublisherError>) -> ()) {
        
        sleep(2)
        
        if simulateFailure {
            
            completion(.failure(PublisherError.someError("publish book error")))
        }
        else if self.hasBookTitleANumber(title: publishable.title) {
            
            // This simulates an error where publisher returns book without genre.
            /*
            if var book = publishable as? Book {

                book.genre = nil
                completion(.success(Publisher.PublisherResult.approved(publishable: book, approvedMessage: "approved")))
                return
            }
            */
            
            completion(.success(Publisher.PublisherResult.approved(publishable: publishable, approvedMessage: "approved")))
        }
        else {
            
            completion(.failure(Publisher.PublisherError.notApproved("not approved")))
        }
    }
}
