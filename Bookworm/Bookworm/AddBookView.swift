//
//  AddBookView.swift
//  Bookworm
//
//  Created by Oluwapelumi Williams on 21/09/2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Guide"
    @State private var review = ""
    
    let genres = ["Action and Adventure", "Anthology", "Art/Architecture", "Autobiography", "Biography", "Business/Economics", "Comic Book", "Crime", "Drama", "Dystopian", "Fairytale", "Fantasy", "Guide", "Health/Fitness", "Historical Fiction", "History", "Horror", "Humor", "Journal", "Kids", "Memoir", "Mystery", "Neo noir", "Poetry", "Prayer", "Religion and Spirituality", "Review", "Romance", "Satire", "Sci-Fi", "Science", "Self help", "Short story", "Sports and leisure", "Suspense", "Thriller", "Travel", "True Crime", "War", "Western", "Young adult"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Name of author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    
//                    Section {
//                        TextEditor(text: $review)
//                        
//                        Picker("Rating", selection: $rating) {
//                            ForEach(0..<6) {
//                                Text(String($0))
//                            }
//                        }
//                    } header: {
//                        Text("Write a review")
//                    }
                    
                    Section {
                        TextEditor(text: $review)
                        RatingView(rating: $rating)
                    } header: {
                        Text("Write a review")
                    }
                    
                    Section {
                        Button("Save") {
                            // code for adding the book
                            let newBook = Book(context: moc)
                            newBook.id = UUID()
                            newBook.title = title
                            newBook.author = author
                            newBook.rating = Int16(rating)
                            newBook.genre = genre
                            newBook.review = review
                            
                            try? moc.save()
                            
                            dismiss()
                        }
                    }
                } // closing brace of the first Section
            } // closing brace of the Form
            .navigationTitle("Add Book")
        } // closing brace of the NavigationView
    }
}

#Preview {
    //@Environment(\.managedObjectContext) var moc
    AddBookView()
}
