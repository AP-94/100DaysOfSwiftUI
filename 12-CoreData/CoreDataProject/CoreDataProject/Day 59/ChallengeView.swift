//
//  ChallengeView.swift
//  CoreDataProject
//
//  Created by Alessandro Pace on 15/6/21.
//

import SwiftUI

//CHALLENGES TESTING VIEW

struct ChallengeView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var sortDescriptor: [NSSortDescriptor] = []
    @State private var predicateToApplied: Predicates = .containsIgnoreCase
    @State private var filterValue = "E"
    @State private var filterKey = "title"
    
    var body: some View {
        VStack {
            
            FilteredList(sortDescriptorArray: sortDescriptor, filterKey: filterKey, predicate: predicateToApplied, filterValue: filterValue) { (movie: Movie) in
                
                VStack(alignment: .leading) {
                    Text("Title: \(movie.wrappedTitle)")
                    Text("Director: \(movie.wrappedDirector)")
                    Text("Year: \(movie.wrappedYear)")
                }
            }
            
            Button("Add movies") {
                let movie1 = Movie(context: moc)
                movie1.director = "Richard Marquand"
                movie1.title = "Star Wars Episode VI"
                movie1.year = 1983
                
                let movie2 = Movie(context: moc)
                movie2.director = "Irvin Kershner"
                movie2.title = "Star Wars Episode V"
                movie2.year = 1980
                
                let movie3 = Movie(context: moc)
                movie3.director = "Peter Jackson"
                movie3.title = "The Lord of the Rings: The Two Towers"
                movie3.year = 2002
                
                let movie4 = Movie(context: moc)
                movie4.director = "Zack Snyder"
                movie4.title = "Army of the Dead"
                movie4.year = 2021
                
                let movie5 = Movie(context: moc)
                movie5.director = "Joe Russo, Anthony Russo"
                movie5.title = "Avengers: Endgame"
                movie5.year = 2019
                
                let movie6 = Movie(context: moc)
                movie6.director = "Francis Lawrence"
                movie6.title = "I Am Legend"
                movie6.year = 2007
                
                if moc.hasChanges {
                    do {
                        try self.moc.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Text("Sort data by:")
            HStack {
                Button("Director Ascending") {
                    sortDescriptor = [NSSortDescriptor(key: "director", ascending: true)]
                }
                
                Button("Title Ascending") {
                    sortDescriptor = [NSSortDescriptor(key: "title", ascending: true)]
                }
                
                Button("Both") {
                    sortDescriptor = [NSSortDescriptor(key: "director", ascending: true), NSSortDescriptor(key: "title", ascending: true)]
                }
            }
            
            Text("Filter data by:")
            HStack {
                Button("Year 2007") {
                    predicateToApplied = .like
                    filterKey = "year"
                    filterValue = "2007"
                }
                
                Button("Movie begins with A") {
                    predicateToApplied = .beginsWith
                    filterKey = "title"
                    filterValue = "A"
                }
                
                Button("Remove Filters") {
                    predicateToApplied = .containsIgnoreCase
                    filterKey = "title"
                    filterValue = "E"
                }
            }
            
        }
    }
}
