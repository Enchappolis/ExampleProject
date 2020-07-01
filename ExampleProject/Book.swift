//
//  Book.swift
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

enum BookGenre {
    case fantasy
    case romance
    case scifi
}

struct Book: Publishable {
    
    // MARK: - Public Variables
    var title = ""
    var genre: BookGenre?
    weak var author: Author?
    
    // MARK: - init
    init(title: String) {
    
        self.title = title
    }
    
    // MARK: - Public Methods
    // Book is invalid if title has no number.
    static func createSampleBooks(numberOfBooks: Int, includeInvalidBooks: Bool = false) -> [Book] {

        func assignBookGenre(bookNumber: Int) -> BookGenre {
            
            switch bookNumber {
            case bookNumber where bookNumber % 2 == 0:
                return BookGenre.romance
            case bookNumber where bookNumber % 3 == 0:
                return BookGenre.scifi
            default:
                return BookGenre.fantasy
            }
            
//            if bookNumber % 2 == 0 {
//                
//                return BookGenre.Romance
//            }
//            
//            if bookNumber % 3 == 0 {
//                
//                return BookGenre.Scifi
//            }
//            
//            return BookGenre.Fantasy
        }
        
        var listOfBooks = [Book]()
        
        var bookNumber = 1
        
        while bookNumber <= numberOfBooks {

            var book: Book!

            // Every third book is invalid.
            if includeInvalidBooks && bookNumber % 3 == 0 {

                book = Book(title: "title")

            }
            else {

                book = Book(title: "title \(bookNumber)")

            }

            book.genre = assignBookGenre(bookNumber: bookNumber)
            
            listOfBooks.append(book)
            
            bookNumber += 1
        }
        
        return listOfBooks
    }
    
//    static func createSampleBooks() -> [Book] {
//
//        var listOfBooks = [Book]()
//
//        var book1 = Book(title: "title 1")
//        book1.genre = BookGenre.Fantasy
//        listOfBooks.append(book1)
//
//        var book2 = Book(title: "title 2")
//        book2.genre = BookGenre.Romance
//        listOfBooks.append(book2)
//
//        var book3 = Book(title: "title 3")
//        book3.genre = BookGenre.Fantasy
//        listOfBooks.append(book3)
//
//        var book4 = Book(title: "title 4")
//        book4.genre = BookGenre.Fantasy
//        listOfBooks.append(book4)
//
//        var book5 = Book(title: "title 5")
//        book5.genre = BookGenre.Romance
//        listOfBooks.append(book5)
//
//        var book6 = Book(title: "title 6")
//        book6.genre = BookGenre.Scifi
//        listOfBooks.append(book6)
//
//        return listOfBooks
//    }
}
