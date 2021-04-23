//
//  ContentView.swift
//  WordScramble
//
//  Created by Leotis buchanan on 2021-04-23.
//
/*
 The user interface for this app will be made up of three main SwiftUI views: a NavigationView showing the word they are
 spelling from, a TextField where they can enter one answer, and a List showing all the words they have entered
 previously.

 For now, every time users enter a word into the text field, we’ll automatically add it to the list of used words.
 Later, though, we’ll add some validation to make sure the word hasn’t been used before, can actually be produced from
 the root word they’ve been given, and is a real word and not just some random letters.
 */

import SwiftUI




struct ContentView: View {
    @State private var  usedWords  = [String]()
    @State private var  rootWord  = ""
    @State private var  newWord   = ""
    
    
    func startGame(){
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource:"start", withExtension: "txt") {
            // 2 . Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL){
            // 3 . Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4 . Pick one random word, or use "silkworm as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                // If we are here everything has worked, so we can exit
                return
            }
            
        }
        
        // If we are here then there was a  problem- trigger a crash and report the error
        fatalError("Could not load start.txt from bundle")
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in:.whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        usedWords.insert(answer, at:0)
        newWord = ""
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit:addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()

                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform:startGame)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
