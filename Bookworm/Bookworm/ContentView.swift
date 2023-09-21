//
//  ContentView.swift
//  Bookworm
//
//  Created by Oluwapelumi Williams on 21/09/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book> // FetchRequest without sorting
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var books: FetchedResults<Book> // FetchRequest with sorting
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.title),
//                                    SortDescriptor(\.author)
//                                   ]) var books: FetchedResults<Book> // FetchRequest with multiple sorting descriptors
    
    @State private var showingAddScreen = false
    
    // function for deleting from the context.
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // locate this book in our fetch request
            let book = books[offset]
            
            // delete it from the context
            moc.delete(book)
        }
        
        // save the context
        try? moc.save()
    }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        // Text(book.title ?? "Unknown Title")
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks) // this gives us swipe to delete functionality
            }
            
            
            
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                    
                    // An edit button that we can also usese to delete, but this time, multiple items at once before committing
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }
}

#Preview {
    ContentView()
}
