//
//  DetailView.swift
//  BookWorm
//
//  Created by Alessandro Pace on 13/6/21.
//

import CoreData
import SwiftUI

struct DetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                    
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                
                ///CHALLENGE 3
                Text(formattedBookDate(date: self.book.date))
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
            
            
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("Delete Book"), message: Text("Are you sure you want to delete this book?"), primaryButton: .destructive(Text("Confirm"), action: {
                self.deleteCurrentBook()
            }), secondaryButton: .cancel())
        }
        .navigationBarItems(trailing: Button(action: {
            self.showDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
    
    private func deleteCurrentBook() {
        moc.delete(book)
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }

    ///CHALLENGE 3: FORMAT DATE TO STRING
    private func formattedBookDate(date: Date?) -> String {
        guard let dateToFormat = date else {
            return " - "
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        
        return formatter.string(from: dateToFormat)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Mock Book"
        book.author = "Core Data"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This is a mock review!"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
