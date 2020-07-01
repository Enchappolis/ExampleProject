//
//  Author.swift
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

final class Author: Employee {
    
    // MARK: - Private Variables
    private var listOfBooksPublished = [(genre: BookGenre, book: Book)]()
    
    // MARK: - Public Variables
    var numberOfFantasyBooksPublished: Int {
        return listOfBooksPublished.filter {$0.genre == BookGenre.fantasy}.count
    }

    // or
    //    lazy var numberOfFantasyBooks = listOfBooks.filter {$0.genre == BookGenre.Fantasy}.count

    // or
    //    func numberOfFantasyBooks() -> Int {
    //
    //        var sum = 0
    //
    //        for book in listOfBooks {
    //            if book.genre == BookGenre.Fantasy {
    //                sum += 1
    //            }
    //        }
    //
    //        return sum
    //    }
    
    var numberOfRomanceBooksPublished: Int {
        return listOfBooksPublished.filter {$0.genre == BookGenre.romance}.count
    }
    
    var numberOfSciFiBooksPublished: Int {
        return listOfBooksPublished.filter {$0.genre == BookGenre.scifi}.count
    }
    
    deinit {
        print("deinit author")
    }
}

// MARK: - BookHandlerProtocol
extension Author: BookHandlerProtocol {
    
    func published(book: Book) {
        
        if let bookGenre = book.genre {
            
            listOfBooksPublished.append((genre: bookGenre, book: book))
            
            print("author appended book \(book.title)")
        }
    }
}
