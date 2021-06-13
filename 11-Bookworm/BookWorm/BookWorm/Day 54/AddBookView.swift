//
//  AddBockView.swift
//  BookWorm
//
//  Created by Alessandro Pace on 10/6/21.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var showingGenreAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        createAndSaveBook()
                    }
                }
            }
            .navigationBarTitle("Add Book")
            ///CHALLENGE 1
            .alert(isPresented: $showingGenreAlert) {
                Alert(title: Text("Genre"), message: Text("You must select a genre to create a Book"), dismissButton: .cancel())
            }
        }
    }
    
    ///CHALLENGE 1: VALIDATING GENRE FIELD
    private func validateGenreField() -> Bool {
        return genre.isEmpty ? false : true
    }
    
    private func createAndSaveBook() {
        if validateGenreField() {
            let newBook = Book(context: self.moc)
            newBook.title = self.title
            newBook.author = self.author
            newBook.rating = Int16(self.rating)
            newBook.review = self.review
            newBook.genre = self.genre
            ///CHALLENGE 3: Adding creation time to book
            newBook.date = Date()
            
            try? self.moc.save()
            self.presentationMode.wrappedValue.dismiss()
        } else {
            showingGenreAlert = true
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
