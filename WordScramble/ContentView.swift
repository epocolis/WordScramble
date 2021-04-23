//
//  ContentView.swift
//  WordScramble
//
//  Created by Leotis buchanan on 2021-04-23.
//
/*
 Now that our game is all set up, the last part of this project is to make sure the user can’t enter invalid words. We’re going to implement this as four small methods, each of which perform
 exactly one check: is the word original (it hasn’t been used already), is the word possible (they aren’t trying to spell “car” from “silkworm”), and is the word real (it’s an actual English
 word).
 
 If you were paying attention you’ll have noticed that was only three methods – that’s because the fourth method will be there to make showing error messages easier.
 */

import SwiftUI




struct ContentView: View {
    @State private var  usedWords  = [String]()
    @State private var  rootWord  = ""
    @State private var  newWord   = ""
    @State private var score = 0
    
    // state variables to make showing error alerts easier
    
    @State private var errorTitle      = ""
    @State private var errorMessage    = ""
    @State private var showingError    = false
    
    
    func wordError(title:String, message:String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    
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
    
    /*
     Validation functions
     
     */
    
    func isReal(word:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range:range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordTooShort(word:String) -> Bool {
        if word.count < 3 {
            return false
        }
        
        return true
    }
    
    
    func wordIsInputWord(word:String) -> Bool {
        let a = rootWord.lowercased()
        let b = word.lowercased()
        
        
        return !(a == b)
        
       
        
     
    }
    
    
    
    func isOriginal(word:String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word:String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at:pos)
                
            } else {
                return false
            }
        }
        
        return true
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in:.whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        //add validation
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word:answer)  else {
            
            wordError(title:"Word not recognized", message: "You can't just make up words")
            return
            
        }
        guard  isReal(word:answer) else {
            
            wordError(title:"Word not possible", message: "That isn't a real word")
            
            return
            
        }
        
        guard wordIsInputWord(word:answer) else {
            wordError(title:"Really dude", message: "You cannot use the same word as the input word")
            
            return
        }
        
        guard wordTooShort(word:answer) else {
            
            wordError(title:"Word is too short", message: "words should have more than 2 letters")
            
            return
        }
        
        
        usedWords.insert(answer, at:0)
        newWord = ""
        // if we get here the word was good so we can update the score
        score += 1
        
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
                
                Text("Score: \(score)").font(.title)
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing:
                                    Button(action:startGame) {
                                        Text("Restart Game")
                                    }
            )
            .onAppear(perform:startGame)
            .alert(isPresented: $showingError){
                Alert(title: Text(errorTitle), message:Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
