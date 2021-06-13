//
//  HomeView.swift
//  BookWorm
//
//  Created by Alessandro Pace on 10/6/21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddBookScreen = false
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown title")
                                .font(.headline)
                                ///CHALLENGE 2: Color of text in red when rating is 1
                                .foregroundColor(book.rating == 1 ? .red : .black)
                            Text(book.author ?? "Unknown author")
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
                
            }
            .navigationBarTitle("BookWorm")
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action: {
                                        self.showingAddBookScreen.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                    })
            .sheet(isPresented: $showingAddBookScreen, content: {
                AddBookView().environment(\.managedObjectContext, self.moc)
            })
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
