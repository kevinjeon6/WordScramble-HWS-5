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
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
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
            .onAppear {
                //onAppear is a dedicated view modifier when a view is shown. Will run the function when the view is shown.
                startGame()
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
   
        }
        
    }
    
    //MARK: - Methods
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        //checking at least for one letter
        guard answer.count > 0 else { return }
        
        //Extra validation to come
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \(rootWord)!")
            return
        }
        
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        withAnimation {
            usedWords.insert(answer, at: 0)
            //Using insert instead of append because the append would take the current word and place it at the end and not the current
            newWord = ""
        }
        
    }
    
    func startGame() {
        //Find file
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
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
