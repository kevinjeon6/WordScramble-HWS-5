//
//  ContentView.swift
//  WordScramble
//
//  Created by Kevin Mattocks on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) {
                        word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            //Can add the onSubmit modifier somewhere in our view hierarchy. Can add it anywhere because it will be triggered when any text is submitted
            .onSubmit {
                addNewWord()
            }
        }
        
    }
    
    //MARK: - Methods
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        //checking at least for one letter
        guard answer.count > 0 else { return }
        
        //Extra validation to come
        withAnimation {
            usedWords.insert(answer, at: 0)
            //Using insert instead of append because the append would take the current word and place it at the end and not the current
            newWord = ""
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 List is the view that you rely on the most compared to VStack, etc.
 
 Lists provide a scrolling table is for presentation data while form is for user input
 
 Use Dynamic content using ForEach inside the brackets or List(0...5)
 
 Modifier .listStyle can change the appearance of the list
 
 
 ID parameter is used to tell SwiftUI on how to identify each item in the array unique
 
 \.self is used for Strings and numbers
 */


/*
 If you want to read the URL for a file in our main app bundle, we use Bundle.main.url(forResources: "some-file", withExtension: "txt")
 */


/*
 trimmingCharacters(in: .whitespacesAndNewlines) will trim all whitespace at the start and end of a string
 */
